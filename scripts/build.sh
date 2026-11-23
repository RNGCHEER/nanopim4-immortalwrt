#!/usr/bin/env bash
set -euo pipefail

case "${DISTRO:?}" in
  immortalwrt) repository=https://github.com/immortalwrt/immortalwrt.git ;;
  istoreos) repository=https://github.com/istoreos/istoreos.git ;;
  *) echo 'Unsupported distribution' >&2; exit 1 ;;
esac
source_dir="$GITHUB_WORKSPACE/source"
output="$GITHUB_WORKSPACE/output"

case "${1:?}" in
  source)
    ref="${SOURCE_REF:-}"
    if [[ -z "$ref" || "$ref" == latest ]]; then
      if [[ "$DISTRO" == immortalwrt ]]; then
        ref=$(git ls-remote --tags --refs "$repository" | awk '{sub("refs/tags/", "", $2); print $2}' | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n1)
      else
        ref=istoreos-24.10
      fi
    fi
    [[ "$ref" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ || "$ref" =~ ^istoreos-[0-9]+\.[0-9]+$ ]] || { echo 'Invalid source reference'; exit 1; }
    git clone --depth 1 --branch "$ref" "$repository" "$source_dir"
    python3 "$GITHUB_WORKSPACE/scripts/prepare-source.py" "$source_dir"
    printf 'SOURCE_REF_RESOLVED=%s\nSOURCE_DIR=%s\n' "$ref" "$source_dir" >> "$GITHUB_ENV"
    printf 'ref=%s\n' "$ref" >> "$GITHUB_OUTPUT"
    ;;
  feeds)
    cd "$source_dir"
    # Keep the feeds pinned by a release tag; add only the official iStore components.
    grep -Eq '^src-git [^ ]+ .*[/]istore(\.git)?[;^]' feeds.conf.default || echo 'src-git store https://github.com/istoreos/istore.git;main' >> feeds.conf.default
    grep -Eq '^src-git nas ' feeds.conf.default || echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
    grep -Eq '^src-git nas_luci ' feeds.conf.default || echo 'src-git nas_luci https://github.com/linkease/nas-packages-luci.git;main' >> feeds.conf.default
    ./scripts/feeds update -a
    ./scripts/feeds install -a
    # The store's own task libraries must match its minimum version constraints.
    store_feed=$(awk '$1 == "src-git" && $3 ~ /\/istore(\.git)?[;^]/ {print $2; exit}' feeds.conf.default)
    ./scripts/feeds install -f -p "$store_feed" taskd luci-lib-xterm luci-lib-taskd luci-app-store
    ./scripts/feeds install -f -p nas quickstart
    ./scripts/feeds install -f -p nas_luci luci-app-quickstart
    if ! find package/feeds -mindepth 2 -maxdepth 2 -name luci-app-openclash -print -quit | grep -q .; then
      git clone --depth 1 --filter=blob:none --sparse https://github.com/vernesong/OpenClash.git openclash-source
      git -C openclash-source sparse-checkout set luci-app-openclash
      cp -a openclash-source/luci-app-openclash package/
    fi
    ;;
  configure)
    cd "$source_dir"
    cp "$GITHUB_WORKSPACE/.config" .config
    cp -a "$GITHUB_WORKSPACE/files" ./
    find files -type f \( -path '*/uci-defaults/*' -o -path '*/hotplug.d/*' \) -exec chmod 755 {} +
    make defconfig
    # Fail instead of silently dropping a requested device or UI component.
    for symbol in TARGET_rockchip_armv8_DEVICE_friendlyarm_nanopi-m4 PACKAGE_luci-theme-argon PACKAGE_quickstart PACKAGE_luci-app-quickstart PACKAGE_luci-app-store PACKAGE_luci-app-openclash PACKAGE_opkg; do
      grep -qx "CONFIG_${symbol}=y" .config || { echo "Missing required selection: $symbol"; exit 1; }
    done
    grep -qx '# CONFIG_USE_APK is not set' .config
    mkdir -p "$output"
    cp .config "$output/build.config"
    ./scripts/diffconfig.sh > "$output/diffconfig"
    {
      printf 'distribution=%s\nref=%s\ncommit=%s\npackage_format=ipk\n' "$DISTRO" "$SOURCE_REF_RESOLVED" "$(git rev-parse HEAD)"
      for feed in feeds/*; do
        [[ -d "$feed/.git" ]] && printf 'feed.%s=%s\n' "$(basename "$feed")" "$(git -C "$feed" rev-parse HEAD)"
      done
      true
    } > "$output/build-info.txt"
    ;;
  compile)
    cd "$source_dir"
    make download -j8 2>&1 | tee "$GITHUB_WORKSPACE/download.log"
    if [[ "${OUTPUT_KIND:?}" == packages ]]; then
      targets=(tools/install toolchain/install target/compile package/compile package/index)
    else
      targets=(world)
    fi
    for target in "${targets[@]}"; do
      make -j"$(nproc)" "$target" 2>&1 | tee -a "$GITHUB_WORKSPACE/build.log" || make -j1 V=s "$target" 2>&1 | tee -a "$GITHUB_WORKSPACE/build.log"
    done
    ;;
  collect)
    cd "$source_dir"
    mkdir -p "$output"
    if [[ "${OUTPUT_KIND:?}" == firmware ]]; then
      find bin/targets/rockchip/armv8 -maxdepth 1 -type f -name '*nanopi-m4*sysupgrade.img.gz' -exec cp {} "$output/" \;
      compgen -G "$output/*nanopi-m4*.img.gz" > /dev/null || { echo 'No NanoPi M4 firmware images produced'; exit 1; }
      find bin/targets/rockchip/armv8 -maxdepth 1 -type f \( -name '*.manifest' -o -name 'profiles.json' \) -exec cp {} "$output/" \;
    else
      mkdir -p "$output/ipk"
      # Include target-specific kernel packages, not only bin/packages feed packages.
      find bin/packages bin/targets/rockchip/armv8/packages -type f -name '*.ipk' | while IFS= read -r file; do
        install -D "$file" "$output/ipk/$file"
      done
      find "$output/ipk" -name '*.ipk' -print -quit | grep -q . || { echo 'No IPK packages produced'; exit 1; }
      tar -C "$output/ipk" -czf "$output/${DISTRO}-nanopi-m4-ipk.tar.gz" .
      rm -r "$output/ipk"
    fi
    cd "$output"
    find . -maxdepth 1 -type f ! -name sha256sums -print0 | sort -z | xargs -0 sha256sum > sha256sums
    ;;
  *) exit 1 ;;
esac
