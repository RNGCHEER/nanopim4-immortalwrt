# NanoPi M4 ImmortalWrt 固件

基于 [ImmortalWrt](https://github.com/immortalwrt/immortalwrt) 为 NanoPi M4 编译的固件。

## ✨ 功能特性

### 📡 网络支持
- **4G/5G模组支持** - 支持 QMI、NCM、RNDIS 等4G/5G模组
- **安卓USB网络共享** - 支持 Android USB Tethering
- **多WAN负载均衡** - MWAN3 多线负载均衡

### 🐳 Docker 支持
- Docker Engine
- Docker Man (LuCI管理界面)
- 支持 Docker Compose

### 🎮 网络工具
- **OpenClash** - 基于 Clash 的透明代理工具
- **SSR Plus** - 科学上网工具
- **PassWall** - 网络代理工具

### ⚡ 性能优化
- **TurboACC** - 网络加速
- **ttyd** - 终端Web界面

## 🖥️ 支持设备

| 设备 | 型号 |
|------|------|
| NanoPi M4 | FriendlyElec |

## 📥 下载固件

前往 [Releases](https://github.com/RNGCHEER/nanopim4-immortalwrt/releases) 页面下载最新固件。

## 🔧 默认登录信息

- **地址**: http://192.168.1.1
- **用户名**: root
- **密码**: password

## 🛠️ 手动编译

```bash
# 克隆仓库
git clone https://github.com/RNGCHEER/nanopim4-immortalwrt.git
cd nanopim4-immortalwrt

# 启动编译
act -j -W .github/workflows/build-openwrt.yml
```

## 📝 更新日志

- 📡 支持4G/5G模组 (QMI/NCM/RNDIS)
- 📱 支持安卓USB网络共享
- 🐳 集成 Docker 支持
- 🎮 集成 OpenClash
- ⚡ 启用 TurboACC 网络加速

## 📄 许可证

本项目基于 ImmortalWrt，遵循 GPL v3 许可证。

## 🙏 致谢

- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt)
- [OpenWrt](https://openwrt.org/)
- [FriendlyElec](https://www.friendlyelec.com/)