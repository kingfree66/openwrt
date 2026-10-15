#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================

sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=6.6/g' ./target/linux/x86/Makefile
# sed -i '/openwrt-25.12/d' feeds.conf.default
sed -i '/openwrt-24.10/d' feeds.conf.default
# sed -i '/openwrt-23.05/d' feeds.conf.default
sed -i '/^src-git luci/d' feeds.conf.default
sed -i '2i src-git luci https://github.com/openwrt/luci.git;openwrt-24.10' feeds.conf.default

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

# 修改openwrt登陆地址,把下面的192.168.2.106修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.2.106/g' package/base-files/files/bin/config_generate

# 修改主机名字，把Unicorn修改你喜欢的就行（不能纯数字或者使用中文）
sed -i "/uci commit system/i\uci set system.@system[0].hostname='OpenWrt-King'" package/lean/default-settings/files/zzz-default-settings
sed -i "s/hostname='OpenWrt'/hostname='OpenWrt-King'/g" ./package/base-files/files/bin/config_generate

# Add a feed source
git clone https://github.com/fw876/helloworld.git package/ssr
git clone https://github.com/firker/diy-ziyong.git package/diy-ziyong
git clone -b 18.06 https://github.com/garypang13/luci-theme-edge.git package/luci-theme-edge
git clone https://github.com/gngpp/luci-theme-design.git  package/luci-theme-design
git clone https://github.com/sirpdboy/luci-theme-kucat.git
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/gngpp/luci-theme-neobird.git package/luci-theme-neobird
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
# find ./ | grep Makefile | grep mosdns | xargs rm -f
# git clone https://github.com/firkerword/openwrt-mos.git package/openwrt-mos
# git clone https://github.com/QiuSimons/openwrt-mos.git package/openwrt-mos
# find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
git clone https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git package/openwrt-passwall
git clone https://github.com/Openwrt-Passwall/openwrt-passwall.git package/passwall
# git clone -b luci-smartdns-new-version https://github.com/Openwrt-Passwall/openwrt-passwall.git package/passwall
# git clone https://github.com/firkerword/luci-app-mosdns.git package/mosdns
git clone https://github.com/Openwrt-Passwall/openwrt-passwall2.git package/passwall2
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/sbwml/luci-app-mosdns -b v5-lua package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
git clone https://github.com/firkerword/luci-app-serverchan.git package/luci-app-serverchan
# git clone https://github.com/sirpdboy/luci-app-lucky.git package/lucky
git clone https://github.com/firkerword/luci-app-lucky.git package/lucky
chmod 755 ./package/lucky/luci-app-lucky/root/usr/bin/luckyarch
git clone https://github.com/liudf0716/luci-app-apfree-wifidog.git package/wifidog
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
merge_package https://github.com/vernesong/OpenClash OpenClash/luci-app-openclash
git clone https://github.com/linkease/istore.git package/istore
# Nikki (mihomo 透明代理) + luci-app-nikki，mihomo-meta 提供 mihomo 依赖
git clone https://github.com/nikkinikki-org/OpenWrt-nikki.git package/nikki
# Turbo ACC (chenmozhijin)：luci-app + SFE 内核加速
# LEDE 的 6.6 内核补丁与配置已自带(952/953/613)，只需补充软件包
TURBOACC_TMP="$(mktemp -d)"
git clone --depth 1 --single-branch -b luci https://github.com/chenmozhijin/turboacc.git "$TURBOACC_TMP/turboacc"
git clone --depth 1 --single-branch -b package https://github.com/chenmozhijin/turboacc.git "$TURBOACC_TMP/pkg"
mkdir -p package/turboacc
cp -r "$TURBOACC_TMP/turboacc/luci-app-turboacc" package/turboacc/
cp -r "$TURBOACC_TMP/pkg/nft-fullcone" package/turboacc/
cp -r "$TURBOACC_TMP/pkg/shortcut-fe" package/turboacc/
rm -rf "$TURBOACC_TMP"
[ -f package/turboacc/luci-app-turboacc/Makefile ] || { echo "ERROR: turboacc 拉取失败"; exit 1; }
# luci-app-zerotier：官方 luci 源(openwrt-24.10)中没有，从 coolsnowwolf/luci 取
# 注意：不用 svn，GitHub 已停用 Subversion 协议，改用 git 稀疏检出
rm -rf /tmp/luci-zt
git clone --depth 1 --branch openwrt-24.10 --sparse https://github.com/coolsnowwolf/luci.git /tmp/luci-zt
git -C /tmp/luci-zt sparse-checkout set applications/luci-app-zerotier
cp -r /tmp/luci-zt/applications/luci-app-zerotier package/luci-app-zerotier
rm -rf /tmp/luci-zt
# package/ 目录下的 luci 应用需用绝对路径引用 luci.mk
sed -i 's#include ../../luci.mk#include $(TOPDIR)/feeds/luci/luci.mk#' package/luci-app-zerotier/Makefile
[ -f package/luci-app-zerotier/Makefile ] || { echo "ERROR: luci-app-zerotier 拉取失败"; exit 1; }
