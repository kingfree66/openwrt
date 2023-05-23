#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================

sed -i 's/KERNEL_PATCHVER:=6.1/KERNEL_PATCHVER:=5.15/g' ./target/linux/x86/Makefile
sed -i 's/KERNEL_PATCHVER:=6.2/KERNEL_PATCHVER:=5.15/g' ./target/linux/x86/Makefile

# 修改openwrt登陆地址,把下面的192.168.2.106修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.2.106/g' package/base-files/files/bin/config_generate

# 修改主机名字，把Unicorn修改你喜欢的就行（不能纯数字或者使用中文）
sed -i "/uci commit system/i\uci set system.@system[0].hostname='OpenWrt-King'" package/lean/default-settings/files/zzz-default-settings
sed -i "s/hostname='OpenWrt'/hostname='OpenWrt-King'/g" ./package/base-files/files/bin/config_generate

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
# sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default
# sed -i '$a src-git jerryk https://github.com/jerrykuku/openwrt-package' feeds.conf.default
git clone https://github.com/jerrykuku/lua-maxminddb.git  package/lua-maxminddb
git clone https://github.com/jerrykuku/luci-app-vssr.git  package/luci-app-vssr
git clone https://github.com/fw876/helloworld.git package/ssr
# git clone https://github.com/immortalwrt/homeproxy.git package/luci-app-homeproxy
git clone https://github.com/firker/diy-ziyong.git package/diy-ziyong
git clone -b 18.06 https://github.com/garypang13/luci-theme-edge.git package/luci-theme-edge
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/luci-theme-argon-18.06
git clone https://github.com/gngpp/luci-theme-neobird.git package/luci-theme-neobird
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
src-git infinityfreedom https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git
# find ./ | grep Makefile | grep mosdns | xargs rm -f
# git clone https://github.com/firkerword/openwrt-mos.git package/openwrt-mos
# git clone https://github.com/QiuSimons/openwrt-mos.git package/openwrt-mos
# find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
# git clone -b luci https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone -b luci-smartdns-new-version https://github.com/xiaorouji/openwrt-passwall.git package/passwall
# git clone https://github.com/firkerword/luci-app-mosdns.git package/mosdns
git clone https://github.com/firkerword/luci-app-smartdns.git package/luci-app-smartdns
git clone https://github.com/firkerword/smartdns.git package/smartdns
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
# git clone https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
git clone https://github.com/sbwml/luci-app-alist.git package/luci-app-alist
git clone https://github.com/firkerword/luci-app-lucky.git package/lucky
# git clone https://github.com/sirpdboy/luci-app-lucky.git package/lucky
# git clone https://github.com/gdy666/luci-app-lucky.git package/lucky
# svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-bypass package/luci-app-bypass
# git clone https://github.com/dwj0/luci-app-sms-tool.git package/luci-app-sms-tool
# git clone -b master https://github.com/vernesong/OpenClash.git package/OpenClash
# git clone https://github.com/linkease/istore.git package/istore
# git clone https://github.com/linkease/istore-ui.git package/istore-ui
# svn co https://github.com/kiddin9/openwrt-packages/trunk/adguardhome package/adguardhome
# svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-adguardhome package/luci-app-adguardhome
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
