# NanoPi M4 固件与 IPK 构建

面向 FriendlyElec NanoPi M4（RK3399）。Actions 保留三个独立入口：

| Actions 工作流 | 文件 | 产物 |
|---|---|---|
| Build iStore OS for NanoPi M4 | `.github/workflows/build-istoreos.yml` | iStoreOS 完整固件 |
| Build ImmortalWrt for NanoPi M4 | `.github/workflows/build.yml` | ImmortalWrt 完整固件 |
| Build NanoPi M4 IPK Packages | `.github/workflows/build-openwrt.yml` | 指定固件体系的 IPK 包集合 |

## 源码与版本

- ImmortalWrt：自动查询官方最新正式版本标签，排除 RC；也可在 `source_ref` 中指定正式标签。目前验证的版本为 `v25.12.2`。
- iStoreOS：默认追踪稳定维护分支 `istoreos-24.10` 的最新提交，可手动指定其他 `istoreos-年.月` 分支。
- 三个入口使用同一套 `.config` 和设备适配代码。软件包入口的 `distribution` 可选 `immortalwrt` 或 `istoreos`，默认 ImmortalWrt。
- 推送构建配置到 main 会触发三个工作流；README 等文档改动不会触发完整重编译。
- 不再下载其他发行版的基础镜像替换 rootfs；两种固件均从各自源码直接生成 NanoPi M4 镜像。

## 界面与功能

两种固件均集成 Argon 主题、官方 iStoreOS QuickStart 首页和 iStore。
ImmortalWrt 保持自己的系统基础，通过界面组件提供类似 iStoreOS 的使用方式。

QuickStart 使用官方打包仓库：
- [nas-packages](https://github.com/linkease/nas-packages)：后端及启动服务。
- [nas-packages-luci](https://github.com/linkease/nas-packages-luci)：LuCI 首页。
- [iStore](https://github.com/istoreos/istore)：应用商店和任务依赖。

同时选择 Docker/Dockerman、Docker Compose、OpenClash、MWAN3、ttyd、SMB，以及 USB QMI/NCM/MBIM/RNDIS 网络支持。默认 LAN 为内置 eth0，USB 网卡自动绑定 WAN。首次登录使用 `192.168.1.1`、`root / password`，登录后修改密码。

## 下载与包兼容性

成功构建后，固件或 IPK 压缩包会发布到 [Releases](https://github.com/RNGCHEER/nanopim4-immortalwrt/releases)，Actions 页面同时提供 Artifact。

- 固件：`*nanopi-m4*sysupgrade.img.gz`，包含 ext4 和 squashfs 选择，根分区 4096 MiB。
- 软件包：`*-nanopi-m4-ipk.tar.gz`，保留源目录结构，包含普通 feed 包及 target/kernel 包。
- 每次附带 `build-info.txt`、完整配置及 SHA256 校验值，记录源码提交与 feed 提交。
- 为满足 IPK 要求，构建显式禁用 APK 并选择 opkg。原生使用 APK 的新版官方软件源不能直接作为本固件的 IPK 软件源。
- 软件包必须匹配发行版、源码和内核配置；iStoreOS 和 ImmortalWrt 的 IPK 尤其是 kmod 不能互换。安装前对比 `build-info.txt`，旧固件不应直接使用新版内核包。
- 缺少指定设备、Argon、QuickStart 或输出文件时，构建明确失败。失败日志也会作为 Artifact 保留。

## 手动运行

在 Actions 中选择对应工作流，再点击 Run workflow：
1. 固件入口：保持 `source_ref` 空白以编译默认最新版本。
2. IPK 入口：选择目标 `distribution`，并使用与目标固件相同的 `source_ref`。

旧的 `patches/` 和 `istoreos/` 文件保留供历史参考，当前构建使用 `scripts/prepare-source.py`、`scripts/build.sh` 和 `files/`。
