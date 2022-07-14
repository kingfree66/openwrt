#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================

# sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.15/g' ./target/linux/x86/Makefile

# Uncomment a feed source
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# 修改openwrt登陆地址,把下面的192.168.2.66修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.2.66/g' package/base-files/files/bin/config_generate

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
# sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default
# sed -i '$a src-git jerryk https://github.com/jerrykuku/openwrt-package' feeds.conf.default
# git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/QiuSimons/openwrt-mos.git package/openwrt-mos
git clone https://github.com/fw876/helloworld.git package/ssr
git clone https://github.com/firker/diy-ziyong.git package/diy-ziyong
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
git clone https://github.com/kiddin9/openwrt-bypass.git package/openwrt-bypass
git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
git clone -b luci https://github.com/xiaorouji/openwrt-passwall package/passwall
# git clone https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
# git clone https://github.com/dwj0/luci-app-sms-tool.git package/luci-app-sms-tool
git clone -b master https://github.com/vernesong/OpenClash.git package/OpenClash
git clone https://github.com/jerrykuku/luci-app-vssr.git  package/luci-app-vssr
svn co https://github.com/linkease/istore/trunk/luci/luci-app-store package/luci-app-store
svn co https://github.com/linkease/istore-ui/trunk/app-store-ui package/app-store-ui
# svn co https://github.com/kiddin9/openwrt-packages/trunk/adguardhome package/adguardhome
