#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# echo '添加SSRPLUS软件源'
# sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default
# cat feeds.conf.default |grep helloworld
# echo '=========Add feed source OK!========='


echo '添加软件源'
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
echo '=========Add feed source OK!========='

echo '添加K3屏幕插件'
rm -rf package/lean/k3screenctrl
git clone --depth=1 https://github.com/Hill-98/luci-app-k3screenctrl.git package/k3/luci-app-k3screenctrl
git clone --depth=1 https://github.com/Hill-98/openwrt-k3screenctrl.git package/k3/openwrt-k3screenctrl
echo '=========Add k3screen plug OK!========='

echo '移除bcm53xx中的其他机型'
sed -i '421,453d' target/linux/bcm53xx/image/Makefile
sed -i '140,412d' target/linux/bcm53xx/image/Makefile
sed -i 's/$(USB3_PACKAGES) k3screenctrl/luci-app-k3screenctrl/g' target/linux/bcm53xx/image/Makefile
echo '=========Remove other devices of bcm53xx OK!========='
