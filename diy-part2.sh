#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

curl -fsSL  https://raw.githubusercontent.com/firkerword/KPR/main/logo.jpg > ./package/luci-app-serverchan/root/usr/bin/serverchan/api/logo.jpg
curl -fsSL  https://raw.githubusercontent.com/firkerword/KPR/main/cus_config.yaml > ./package/openwrt-mos/luci-app-mosdns/root/etc/mosdns/cus_config.yaml
sed -i 's/luci-theme-bootstrap/luci-theme-opentomcat/g' ./feeds/luci/collections/luci/Makefile
rm -rf ./feeds/luci/applications/luci-app-serverchan
rm -rf ./feeds/luci/applications/luci-app-mosdns
# rm -rf ./package/diy-ziyong/adguardhome
rm -rf ./package/diy-ziyong/smartdns
rm -rf ./feeds/packages/net/adguardhom
rm -rf ./feeds/packages/net/smartdns
rm -rf ./feeds/packages/net/mosdns
# rm -rf ./package/mosdns/mosdns
rm -rf ./feeds/luci/themes/luci-theme-argon
# rm -rf ./package/openwrt-passwall/v2ray-geodata
rm -rf ./package/ssr/v2ray-geodata
# rm -rf ./feeds/packages/net/https-dns-proxy
# svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy feeds/packages/net/https-dns-proxy
# rm -rf feeds/packages/lang/golang
# svn export https://github.com/sbwml/packages_lang_golang/trunk feeds/packages/lang/golang
