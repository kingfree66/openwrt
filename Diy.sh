#!/bin/bash
# DIY 自定义脚本
# 在 feeds 更新安装完成后执行

set -e

echo "=== 开始执行 DIY 脚本 ==="

# ============================================================
# 1. 修复循环依赖（fchomo / nikki）
# ============================================================
echo "[1/7] 修复循环依赖..."
find package feeds -type d -name "luci-app-fchomo" 2>/dev/null | xargs rm -rf
find package feeds -type d -name "nikki" 2>/dev/null | xargs rm -rf
find package feeds -type d -name "luci-app-nikki" 2>/dev/null | xargs rm -rf
find feeds -name "*packageinfo*nikki*" 2>/dev/null | xargs rm -f || true
find feeds -name "*packageinfo*fchomo*" 2>/dev/null | xargs rm -f || true
echo "循环依赖修复完成"

# ============================================================
# 2. 删除版本不兼容的包
# ============================================================
echo "[2/7] 删除版本不兼容的包..."
rm -rf feeds/kenzo/luci-theme-design 2>/dev/null || true
rm -rf package/feeds/kenzo/luci-theme-design 2>/dev/null || true
rm -rf package/feeds/kenzo/luci-app-store 2>/dev/null || true
echo "不兼容包删除完成"

# ============================================================
# 3. 设置默认 IP 和主机名
# ============================================================
echo "[3/7] 设置默认 IP 和主机名..."
sed -i 's/192.168.1.1/192.168.2.106/g' package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/Openwrt-King/g' package/base-files/files/bin/config_generate
echo "IP 和主机名设置完成：192.168.2.106 / Openwrt-King"

# ============================================================
# 4. 设置默认主题为 luci-theme-design
# ============================================================
echo "[4/7] 设置默认主题..."
sed -i 's/+luci-theme-bootstrap/+luci-theme-design/g' feeds/luci/collections/luci-light/Makefile 2>/dev/null || true
sed -i 's/+luci-theme-bootstrap/+luci-theme-design/g' feeds/luci/collections/luci-nginx/Makefile 2>/dev/null || true
sed -i 's/+luci-theme-bootstrap/+luci-theme-design/g' feeds/luci/collections/luci-ssl-nginx/Makefile 2>/dev/null || true

# UCI 默认主题设置
mkdir -p package/base-files/files/etc/uci-defaults
cat > package/base-files/files/etc/uci-defaults/99-luci-theme << 'EOF'
#!/bin/sh
uci set luci.main.mediaurlbase='/luci-static/design'
uci commit luci
exit 0
EOF
echo "默认主题设置完成：luci-theme-design"

# ============================================================
# 5. 更新 passwall 为最新版（从 small feed）
# ============================================================
echo "[5/7] 更新 passwall 版本..."
if [ -d "feeds/small/luci-app-passwall" ]; then
    SMALL_VER=$(grep "PKG_VERSION" feeds/small/luci-app-passwall/Makefile | head -1 | cut -d= -f2)
    LUCI_VER=$(grep "PKG_VERSION" feeds/luci/applications/luci-app-passwall/Makefile 2>/dev/null | head -1 | cut -d= -f2)
    echo "passwall 版本: luci=$LUCI_VER, small=$SMALL_VER"
    rm -rf feeds/luci/applications/luci-app-passwall
    cp -r feeds/small/luci-app-passwall feeds/luci/applications/luci-app-passwall
    echo "passwall 已更新到 $SMALL_VER"
fi

if [ -d "feeds/small/luci-app-passwall2" ]; then
    rm -rf feeds/luci/applications/luci-app-passwall2
    cp -r feeds/small/luci-app-passwall2 feeds/luci/applications/luci-app-passwall2
    echo "passwall2 已更新"
fi

# ============================================================
# 6. 修复 sing-box 版本（使用 small feed 的新版）
# ============================================================
echo "[6/7] 更新 sing-box 版本..."
if [ -d "feeds/small/sing-box" ]; then
    SMALL_SVER=$(grep "PKG_VERSION" feeds/small/sing-box/Makefile | head -1 | cut -d= -f2)
    PKG_SVER=$(grep "PKG_VERSION" feeds/packages/net/sing-box/Makefile 2>/dev/null | head -1 | cut -d= -f2)
    echo "sing-box 版本: packages=$PKG_SVER, small=$SMALL_SVER"
    if [ "$SMALL_SVER" != "$PKG_SVER" ]; then
        rm -rf feeds/packages/net/sing-box
        cp -r feeds/small/sing-box feeds/packages/net/sing-box
        echo "sing-box 已更新到 $SMALL_SVER"
    fi
fi

# ============================================================
# 7. 设置 Go 代理（加速 Go 包下载）
# ============================================================
echo "[7/7] 设置 Go 代理..."
export GOPROXY=https://goproxy.cn,direct
export GONOSUMDB=*
echo "Go 代理设置完成"

echo "=== DIY 脚本执行完成 ==="
