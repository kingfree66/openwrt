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

# 修改openwrt登陆地址,把下面的192.168.2.106修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.2.106/g' package/base-files/files/bin/config_generate

# 修改主机名字，把Unicorn修改你喜欢的就行（不能纯数字或者使用中文）
sed -i "/uci commit system/i\uci set system.@system[0].hostname='OpenWrt-King'" package/lean/default-settings/files/zzz-default-settings
sed -i "s/hostname='immortalwrt'/hostname='OpenWrt-King'/g" ./package/base-files/files/bin/config_generate

# Add a feed source
sed -i '$a src-git nas https://github.com/linkease/nas-packages.git;master' feeds.conf.default
sed -i '$a src-git nas_luci https://github.com/linkease/nas-packages-luci.git;main' feeds.conf.default
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
# sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default
# sed -i '$a src-git jerryk https://github.com/jerrykuku/openwrt-package' feeds.conf.default
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
# git clone https://github.com/QiuSimons/openwrt-mos.git package/openwrt-mos
git clone https://github.com/fw876/helloworld.git package/ssr
git clone https://github.com/jerrykuku/luci-app-vssr.git  package/luci-app-vssr
git clone https://github.com/firker/diy-ziyong.git package/diy-ziyong
# git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
# git clone https://github.com/kiddin9/openwrt-bypass.git package/openwrt-bypass
git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
git clone -b luci https://github.com/xiaorouji/openwrt-passwall package/passwall
# git clone https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns
git clone https://github.com/immortalwrt/homeproxy.git package/luci-app-homeproxy
git clone https://github.com/linkease/istore.git package/istore
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone https://github.com/linkease/istore-ui.git package/istore-ui
git clone https://github.com/firkerword/luci-app-lucky.git package/lucky
git clone https://github.com/QiuSimons/openwrt-mos.git package/openwrt-mos
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
# svn co https://github.com/coolsnowwolf/packages/trunk/net/redsocks2 package/redsocks2
# svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt package/aliyundrive-webdav
# svn co https://github.com/kiddin9/openwrt-packages/trunk/adguardhome package/adguardhome
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-wrtbwmon package/luci-app-wrtbwmon
svn co https://github.com/kiddin9/openwrt-packages/trunk/wrtbwmon package/wrtbwmon
