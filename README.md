# NanoPi M4 固件

为 NanoPi M4 (Rockchip RK3399) 提供两种固件选择：

- **ImmortalWrt** - 基于 [ImmortalWrt](https://github.com/immortalwrt/immortalwrt) 的固件
- **iStore OS** - 基于 [iStoreOS](https://github.com/istoreos/istoreos) 的固件

## ✨ 功能特性

### ImmortalWrt 固件

#### 📡 网络支持
- **4G/5G模组支持** - 支持 QMI、NCM、RNDIS 等4G/5G模组
- **安卓USB网络共享** - 支持 Android USB Tethering
- **多WAN负载均衡** - MWAN3 多线负载均衡

#### 🐳 Docker 支持
- Docker Engine
- Docker Man (LuCI管理界面)
- 支持 Docker Compose

#### 🎮 网络工具
- **OpenClash** - 基于 Clash 的透明代理工具

#### ⚡ 性能优化
- **TurboACC** - 网络加速
- **ttyd** - 终端Web界面

### iStore OS 固件

#### 📡 网络支持
- **4G/5G模组支持** - 支持 QMI、NCM、RNDIS 等4G/5G模组
- **安卓USB网络共享** - 支持 Android USB Tethering

#### 🐳 Docker 支持
- Docker Engine
- 完整的容器管理

#### 📁 NAS 功能
- SMB/NFS 文件共享
- 磁盘管理

#### 🏪 iStore 应用商店
- 丰富的应用生态
- 一键安装各种插件

## 🖥️ 支持设备

| 设备 | 型号 | 架构 |
|------|------|------|
| NanoPi M4 | FriendlyElec | Rockchip RK3399 |

## 📥 下载固件

### ImmortalWrt
前往 [ImmortalWrt Releases](https://github.com/RNGCHEER/nanopim4-immortalwrt/releases) 页面下载。

### iStore OS
前往 [iStoreOS Releases](https://github.com/RNGCHEER/nanopim4-immortalwrt/releases) 页面下载（标签以 iStoreOS- 开头）。

## 🔧 默认登录信息

| 项目 | ImmortalWrt | iStore OS |
|------|-------------|-----------|
| 地址 | http://192.168.1.1 | http://192.168.1.1 |
| 用户名 | root | root |
| 密码 | password | password |

## 🛠️ 手动编译

### 编译 ImmortalWrt

    git clone https://github.com/RNGCHEER/nanopim4-immortalwrt.git
    cd nanopim4-immortalwrt
    act -j -W .github/workflows/build-openwrt.yml

### 编译 iStore OS

    git clone https://github.com/RNGCHEER/nanopim4-immortalwrt.git
    cd nanopim4-immortalwrt
    act -j -W .github/workflows/build-istoreos.yml

## 📝 更新日志

### ImmortalWrt
- 📡 支持4G/5G模组 (QMI/NCM/RNDIS)
- 📱 支持安卓USB网络共享
- 🐳 集成 Docker 支持
- 🎮 集成 OpenClash
- ⚡ 启用 TurboACC 网络加速

### iStore OS
- 📡 支持4G/5G模组
- 🐳 完整 Docker 支持
- 📁 NAS 功能 (SMB/NFS)
- 🏪 iStore 应用商店

## 📄 许可证

本项目基于 ImmortalWrt 和 iStoreOS，遵循 GPL v3 许可证。

## 🙏 致谢

- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt)
- [iStoreOS](https://github.com/istoreos/istoreos)
- [OpenWrt](https://openwrt.org/)
- [FriendlyElec](https://www.friendlyelec.com/)