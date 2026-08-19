# ImmortalWrt for NanoPi M4

This repository contains the configuration to build [ImmortalWrt](https://immortalwrt.org/) for the [FriendlyElec NanoPi M4](https://wiki.friendlyelec.com/wiki/index.php/NanoPi_M4) development board.

## Hardware Specifications

| Parameter | Specification |
|-----------|---------------|
| **Model** | FriendlyElec NanoPi M4 |
| **SoC** | Rockchip RK3399 |
| **CPU** | Dual-core Cortex-A72 (up to 1.8GHz) + Quad-core Cortex-A53 (up to 1.4GHz) |
| **GPU** | Mali-T860 MP4 |
| **RAM** | 1GB/2GB/4GB LPDDR3 |
| **Storage** | eMMC module socket, MicroSD card slot |
| **Network** | Gigabit Ethernet, optional WiFi/BT module |
| **USB** | 2x USB 3.0 Type-A, 1x USB 2.0, 1x USB Type-C |
| **GPIO** | 40-pin header |

## Firmware Features

### KMS Activation Service
- **vlmcsd**: Windows/Office KMS activation
- LuCI management interface
- Out-of-the-box configuration

### DDNS Dynamic Domain Resolution
- **Supported Providers**:
  - Cloudflare
  - DNSPod
  - No-IP
  - Aliyun DNS
- LuCI management interface
- Automatic domain resolution updates

### Proxy Tools

#### PassWall 1
- Supports all proxy protocols: Shadowsocks/Rust, VMess, Trojan, VLESS, Hysteria2, NaiveProxy, etc.
- Transparent proxy + TProxy mode
- Multi-node load balancing

#### SmartDNS + ChinaDNS
- Intelligent DNS split for domestic and international
- DNS cache acceleration

#### OpenClash
- Transparent proxy based on Clash kernel
- Supports multiple proxy protocols

### Storage Support
- **eMMC Write**: Direct firmware writing to onboard eMMC
- **TF Card Boot**: Boot from microSD card
- **ext4/exFAT Filesystem**: High-performance read/write support
- **Rootfs Expansion**: eMMC/SD card space expansion tools (resize2fs, fdisk)

### 4G/5G Module & Android USB Tethering
- QMI/MBIM/NCM/PPP dial-up protocols
- RNDIS/NCM Android USB network sharing

### Docker Support
- Docker CE + CLI + Containerd
- LuCI Docker management interface

## Usage Instructions

### Method 1: TF Card Boot
1. Download the firmware file
2. Use Balena Etcher or `dd` command to write to TF card
3. Insert TF card into NanoPi M4's microSD slot
4. Power on to boot

### Method 2: Write to eMMC
1. Boot from TF card first
2. Use `dd` command to write firmware to eMMC
3. Power off and remove TF card
4. Boot from eMMC

### Method 3: SSH Network Installation
1. Connect NanoPi M4 via Ethernet
2. Access LuCI interface
3. Upload firmware in System -> Backup/Flash Firmware

## Build Instructions

### Automatic Build (GitHub Actions)

1. Fork this repository
2. Go to Actions tab
3. Run the "Build ImmortalWrt for NanoPi M4" workflow
4. Download the firmware from Releases or Artifacts

### Manual Build

```bash
# Clone repository
git clone https://github.com/RNGCHEER/nanopim4-immortalwrt.git
cd nanopim4-immortalwrt

# Clone ImmortalWrt source
git clone -b openwrt-24.10 --depth 1 https://github.com/immortalwrt/immortalwrt.git
cd immortalwrt

# Apply patches
cp ../patches/*.patch .
patch -p1 < 001-add-nanopi-m4-device.patch
patch -p1 < 002-add-nanopi-m4-uboot.patch

# Add feeds
echo 'src-git istore https://github.com/linkease/istore.git;main' >> feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a

# Clone PassWall packages
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git package/passwall-packages
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall.git package/passwall

# Copy config and build
cp ../.config .
make defconfig
make download -j8
make -j$(nproc)
```

## Default Access

- **Web Interface:** http://192.168.1.1
- **SSH:** root@192.168.1.1 (no password by default)

## Credits

- [ImmortalWrt](https://immortalwrt.org/)
- [FriendlyElec](https://www.friendlyelec.com/)
- [OpenWrt](https://openwrt.org/)
- [PassWall](https://github.com/Openwrt-Passwall/openwrt-passwall)
- [OpenClash](https://github.com/vernesong/OpenClash)
- [SmartDNS](https://github.com/pymumu/smartdns)

## License

This project is licensed under the GNU General Public License v3.0

---

## 中文版

# 适用于 NanoPi M4 的 ImmortalWrt

本仓库包含为 [FriendlyElec NanoPi M4](https://wiki.friendlyelec.com/wiki/index.php/NanoPi_M4) 开发板构建 [ImmortalWrt](https://immortalwrt.org/) 的配置文件。

### 硬件规格

| 参数 | 规格 |
|------|------|
| **型号** | FriendlyElec NanoPi M4 |
| **SoC** | Rockchip RK3399 |
| **CPU** | 双核 Cortex-A72（最高 1.8GHz）+ 四核 Cortex-A53（最高 1.4GHz） |
| **GPU** | Mali-T860 MP4 |
| **内存** | 1GB/2GB/4GB LPDDR3 |
| **存储** | eMMC 模块插槽、MicroSD 卡槽 |
| **网络** | 千兆以太网，可选 WiFi/BT 模块 |
| **USB** | 2x USB 3.0 Type-A、1x USB 2.0、1x USB Type-C |
| **GPIO** | 40 针排针 |

### 固件功能

#### KMS 激活服务
- **vlmcsd**: 支持 Windows/Office KMS 激活
- LuCI 管理界面
- 无需额外配置，开箱即用

#### DDNS 动态域名解析
- **支持服务商**:
  - Cloudflare
  - DNSPod
  - No-IP
  - 阿里云解析
- LuCI 管理界面
- 自动更新域名解析

#### 代理工具

##### PassWall 1
- 支持所有代理协议：Shadowsocks/Rust、VMess、Trojan、VLESS、Hysteria2、NaiveProxy 等
- 透明代理 + TProxy 模式
- 多节点负载均衡

##### SmartDNS + ChinaDNS
- 国内外DNS智能分流
- DNS缓存加速

##### OpenClash
- 基于Clash内核的透明代理
- 支持多种代理协议

#### 存储支持
- **eMMC写入**: 支持直接将固件写入板载eMMC
- **TF卡启动**: 支持从microSD存储卡启动
- **ext4/exFAT文件系统**: 高性能读写支持
- **根分区扩容**: eMMC/SD卡空间扩展工具 (resize2fs, fdisk)

#### 4G/5G模组 & 安卓USB共享
- QMI/MBIM/NCM/PPP拨号协议
- RNDIS/NCM安卓USB网络共享

#### Docker支持
- Docker CE + CLI + Containerd
- LuCI Docker管理界面

### 使用方法

#### 方法一：写入TF卡
1. 下载固件文件
2. 使用Balena Etcher或dd命令写入TF卡
3. 将TF卡插入NanoPi M4的microSD卡槽
4. 上电启动

#### 方法二：写入eMMC
1. 先从TF卡启动
2. 使用`dd`命令将固件写入eMMC
3. 断电移除TF卡
4. 从eMMC启动

#### 方法三：SSH网络安装
1. 通过网线连接NanoPi M4
2. 访问LuCI界面
3. 在系统-备份/升级中上传固件

### 构建说明

#### 自动构建（GitHub Actions）

1. Fork 本仓库
2. 前往 Actions 选项卡
3. 运行"Build ImmortalWrt for NanoPi M4"工作流
4. 从 Releases 或 Artifacts 下载固件

#### 手动构建

```bash
# 克隆仓库
git clone https://github.com/RNGCHEER/nanopim4-immortalwrt.git
cd nanopim4-immortalwrt

# 克隆 ImmortalWrt 源码
git clone -b openwrt-24.10 --depth 1 https://github.com/immortalwrt/immortalwrt.git
cd immortalwrt

# 应用补丁
cp ../patches/*.patch .
patch -p1 < 001-add-nanopi-m4-device.patch
patch -p1 < 002-add-nanopi-m4-uboot.patch

# 添加 feeds
echo 'src-git istore https://github.com/linkease/istore.git;main' >> feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a

# 克隆 PassWall 包
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git package/passwall-packages
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall.git package/passwall

# 复制配置并编译
cp ../.config .
make defconfig
make download -j8
make -j$(nproc)
```

### 默认访问

- **Web 界面：** http://192.168.1.1
- **SSH：** root@192.168.1.1（默认无密码）

### 致谢

- [ImmortalWrt](https://immortalwrt.org/)
- [FriendlyElec](https://www.friendlyelec.com/)
- [OpenWrt](https://openwrt.org/)
- [PassWall](https://github.com/Openwrt-Passwall/openwrt-passwall)
- [OpenClash](https://github.com/vernesong/OpenClash)
- [SmartDNS](https://github.com/pymumu/smartdns)

### 许可证

本项目采用 GNU 通用公共许可证 v3.0 许可
