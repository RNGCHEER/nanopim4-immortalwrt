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
