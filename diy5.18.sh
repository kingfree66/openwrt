#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.18/g' ./target/linux/x86/Makefile

# 修改openwrt登陆地址,把下面的192.168.2.66修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.2.66/g' package/base-files/files/bin/config_generate

# 修改主机名字，把Unicorn修改你喜欢的就行（不能纯数字或者使用中文）
sed -i "/uci commit system/i\uci set system.@system[0].hostname='OpenWrt-King'" package/lean/default-settings/files/zzz-default-settings
sed -i "s/hostname='OpenWrt'/hostname='OpenWrt-King'/g" ./package/base-files/files/bin/config_generate

# Add a feed source
sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default
sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default
sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall;luci' feeds.conf.default
sed -i '$a src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2' feeds.conf.default
sed -i '$a src-git diy https://github.com/firker/diy-ziyong' feeds.conf.default

svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-filebrowser package/luci-app-filebrowser
git clone https://github.com/jerrykuku/luci-app-vssr.git  package/luci-app-vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/zxlhhyccc/luci-app-v2raya package/luci-app-v2raya
git clone https://github.com/thinktip/luci-theme-neobird.git package/luci-theme-neobird
git clone https://github.com/kiddin9/openwrt-bypass.git package/openwrt-bypass

#检索feeds
./scripts/feeds update -a

# 删除重复包
rm -rf feeds/luci/themes/luci-theme-argon

#安装feeds
./scripts/feeds install -a
