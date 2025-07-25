，#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================
# sed -i '/DTS_DIR:=$(LINUX_DIR)/a\BUILD_DATE_PREFIX := $(shell date +'%F')' ./include/image.mk
# sed -i 's/IMG_PREFIX:=/IMG_PREFIX:=$(BUILD_DATE_PREFIX)-/g' ./include/image.mk

# curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
# curl -fsSL  https://raw.githubusercontent.com/siropboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
# curl -fsSL  https://raw.githubusercontent.com/firkerword/KPR/main/logo.jpg > .package/luci-app-serverchan/root/usr/bin/serverchan/api/logo.jpg

# 修改openwrt登陆地址,把下面的192.168.2.106修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.2.106/g' package/base-files/files/bin/config_generate

# 修改主机名字，把Unicorn修改你喜欢的就行（不能纯数字或者使用中文）
# sed -i "/uci commit system/i\uci set system.@system[0].hostname='OpenWrt-King'" package/lean/default-settings/files/zzz-default-settings
# sed -i "s/hostname='OpenWrt'/hostname='OpenWrt-King'/g" ./package/base-files/files/bin/config_generate

sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile
rm -rf ./package/diy-ziyong/theme
rm -rf ./package/diy-ziyong/luci-app-wrtbwmon-zh
rm -rf ./package/diy-ziyong/wrtbwmon
# rm -rf ./package/diy-ziyong/adguardhome
rm -rf ./feeds/packages/net/adguardhome
rm -rf ./feeds/packages/net/smartdns
rm -rf ./feeds/packages/net/mosdns
rm -rf ./feeds/luci/applications/luci-app-passwall
rm -rf ./feeds/luci/applications/luci-app-ssr-plus
rm -rf ./feeds/luci/applications/luci-app-openclash
rm -rf ./feeds/luci/applications/luci-app-smartdns
# rm -rf ./feeds/luci/applications/luci-app-adbyby-plus
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
