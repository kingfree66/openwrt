#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================
sed -i 's/KERNEL_PATCHVER:=6.1/KERNEL_PATCHVER:=6.6/g' ./target/linux/x86/Makefile
sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=6.6/g' ./target/linux/x86/Makefile
sed -i '/openwrt-23.05/d' feeds.conf.default
sed -i 's/^#\(.*luci\)/\1/' feeds.conf.default
# sed -i '2i src-git luci https://github.com/coolsnowwolf/luci.git' feeds.conf.default


function merge_package(){
    repo=`echo $1 | rev | cut -d'/' -f 1 | rev`
    pkg=`echo $2 | rev | cut -d'/' -f 1 | rev`
    # find package/ -follow -name $pkg -not -path "package/custom/*" | xargs -rt rm -rf
    git clone --depth=1 --single-branch $1
    mv $2 package/custom/
    rm -rf $repo
}
function drop_package(){
    find package/ -follow -name $1 -not -path "package/custom/*" | xargs -rt rm -rf
}

rm -rf package/custom; mkdir package/custom

# Add a feed source
git clone https://github.com/fw876/helloworld.git package/ssr
git clone https://github.com/firker/diy-ziyong.git package/diy-ziyong
git clone -b 18.06 https://github.com/garypang13/luci-theme-edge.git package/luci-theme-edge
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/luci-theme-argon-18.06
# git clone https://github.com/thinktip/luci-theme-neobird.git package/luci-theme-neobird
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
# git clone https://github.com/siropboy/sirpdboy-package package/sirpdboy-package
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git package/openwrt-passwall
git clone https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone https://github.com/firkerword/luci-app-parentcontrol.git package/parentcontrol
git clone https://github.com/firkerword/luci-app-smartdns.git package/luci-app-smartdns
git clone https://github.com/firkerword/smartdns.git package/smartdns
# git clone https://github.com/firkerword/luci-app-mosdns.git package/OpenWrt-mosdns
# git clone https://github.com/immortalwrt/homeproxy.git package/luci-app-homeproxy
git clone https://github.com/linkease/istore.git package/istore
git clone https://github.com/linkease/istore-ui.git package/istore-ui
# svn co https://github.com/kiddin9/openwrt-packages/trunk/adguardhome package/adguardhome
# svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-adguardhome package/luci-app-adguardhome
# svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
merge_package https://github.com/vernesong/OpenClash OpenClash/luci-app-openclash
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/sbwml/luci-app-mosdns -b v5-lua package/mosdns
git clone https://github.com/sbwml/luci-app-dae package/dae
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
