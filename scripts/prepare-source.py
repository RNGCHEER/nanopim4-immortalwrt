#!/usr/bin/env python3
"""Add NanoPi M4 support without depending on upstream line numbers."""
import argparse
import re
from pathlib import Path


def insert_before(path: Path, marker: str, anchor: str, text: str) -> None:
    content = path.read_text(encoding="utf-8")
    if marker in content:
        return
    if content.count(anchor) != 1:
        raise RuntimeError(f"Expected exactly one {anchor!r} in {path}")
    path.write_text(content.replace(anchor, text + anchor), encoding="utf-8", newline="\n")


def prepare(source: Path) -> None:
    # Reuse the equivalent RK3399 board's SoC defaults and Wi-Fi firmware names.
    # 24.10 has global KERNEL_LOADADDR, while 25.12 uses Device/rk3399.
    image = source / "target/linux/rockchip/image/armv8.mk"
    template = re.search(r"define Device/friendlyarm_nanopc-t4\n(.*?)endef", image.read_text(encoding="utf-8"), re.S)
    if template is None:
        raise RuntimeError("Cannot locate RK3399 reference device")
    device = "define Device/friendlyarm_nanopi-m4\n" + template[1].replace("NanoPC T4", "NanoPi M4") + "endef\nTARGET_DEVICES += friendlyarm_nanopi-m4\n\n"
    insert_before(
        image,
        "define Device/friendlyarm_nanopi-m4\n",
        "define Device/friendlyarm_nanopc-t6\n",
        device,
    )
    uboot = source / "package/boot/uboot-rockchip/Makefile"
    insert_before(
        uboot,
        "define U-Boot/nanopi-m4-rk3399\n",
        "define U-Boot/nanopi-r4s-rk3399\n",
        """define U-Boot/nanopi-m4-rk3399
  $(U-Boot/rk3399/Default)
  NAME:=NanoPi M4
  BUILD_DEVICES:= \\
    friendlyarm_nanopi-m4
endef

""",
    )
    content = uboot.read_text(encoding="utf-8")
    targets = content.split("UBOOT_TARGETS :=", 1)
    if len(targets) != 2:
        raise RuntimeError("Missing UBOOT_TARGETS")
    if "  nanopi-m4-rk3399 \\\n" not in targets[1]:
        anchor = "  nanopc-t4-rk3399 \\\n"
        if content.count(anchor) != 1:
            raise RuntimeError("Cannot locate NanoPC T4 U-Boot list entry")
        uboot.write_text(content.replace(anchor, anchor + "  nanopi-m4-rk3399 \\\n"), encoding="utf-8", newline="\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    prepare(parser.parse_args().source.resolve())
