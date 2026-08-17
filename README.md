# ImmortalWrt for NanoPi M4

This repository contains the configuration to build [ImmortalWrt](https://immortalwrt.org/) for the [FriendlyElec NanoPi M4](https://wiki.friendlyelec.com/wiki/index.php/NanoPi_M4) development board.

## Hardware Specifications

- **SoC:** Rockchip RK3399
- **CPU:** Dual-core Cortex-A72 (up to 1.8GHz) + Quad-core Cortex-A53 (up to 1.4GHz)
- **RAM:** 1GB/2GB/4GB LPDDR3
- **Storage:** eMMC module socket, MicroSD card slot
- **Network:** Gigabit Ethernet, optional WiFi/BT module
- **USB:** 2x USB 3.0 Type-A, 1x USB 2.0, 1x USB Type-C
- **GPIO:** 40-pin header

## Features

This build includes:

- **LuCI Web Interface** - Modern web-based configuration interface
- **Docker Support** - Containerization via Docker CE
- **VPN Support** - OpenVPN, WireGuard, ZeroTier
- **Network Tools** - curl, wget, tcpdump, nmap
- **Storage Support** - EXT4, NTFS, exFAT, SMB/CIFS
- **USB Support** - USB storage, serial devices, network adapters
- **IPv6 Support** - Full IPv6 networking
- **QoS** - Traffic shaping and bandwidth management

## Build Instructions

### Automatic Build (GitHub Actions)

1. Fork this repository
2. Go to Actions tab
3. Run the "Build ImmortalWrt for NanoPi M4" workflow
4. Download the firmware from Releases or Artifacts

## Default Access

- **Web Interface:** http://192.168.1.1
- **SSH:** root@192.168.1.1 (no password by default)

## Credits

- [ImmortalWrt](https://immortalwrt.org/)
- [FriendlyElec](https://www.friendlyelec.com/)
- [OpenWrt](https://openwrt.org/)

## License

This project is licensed under the GNU General Public License v3.0

---

## 中文版

# 适用于 NanoPi M4 的 ImmortalWrt

本仓库包含为 [FriendlyElec NanoPi M4](https://wiki.friendlyelec.com/wiki/index.php/NanoPi_M4) 开发板构建 [ImmortalWrt](https://immortalwrt.org/) 的配置文件。

### 硬件规格

- **SoC:** Rockchip RK3399
- **CPU:** 双核 Cortex-A72（最高 1.8GHz）+ 四核 Cortex-A53（最高 1.4GHz）
- **RAM:** 1GB/2GB/4GB LPDDR3
- **存储:** eMMC 模块插槽、MicroSD 卡槽
- **网络:** 千兆以太网，可选 WiFi/BT 模块
- **USB:** 2x USB 3.0 Type-A、1x USB 2.0、1x USB Type-C
- **GPIO:** 40 针排针

### 功能特性

本构建包含：

- **LuCI Web 界面** - 现代化的基于 Web 的配置界面
- **Docker 支持** - 通过 Docker CE 实现容器化
- **VPN 支持** - OpenVPN、WireGuard、ZeroTier
- **网络工具** - curl、wget、tcpdump、nmap
- **存储支持** - EXT4、NTFS、exFAT、SMB/CIFS
- **USB 支持** - USB 存储、串口设备、网络适配器
- **IPv6 支持** - 完整的 IPv6 网络
- **QoS** - 流量整形和带宽管理

### 构建说明

#### 自动构建（GitHub Actions）

1. Fork 本仓库
2. 前往 Actions 选项卡
3. 运行“Build ImmortalWrt for NanoPi M4”工作流
4. 从 Releases 或 Artifacts 下载固件

### 默认访问

- **Web 界面：** http://192.168.1.1
- **SSH：** root@192.168.1.1（默认无密码）

### 致谢

- [ImmortalWrt](https://immortalwrt.org/)
- [FriendlyElec](https://www.friendlyelec.com/)
- [OpenWrt](https://openwrt.org/)

### 许可证

本项目采用 GNU 通用公共许可证 v3.0 许可
