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

echo '添加软件源'
# sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
# sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
echo "src-git pw_packages https://github.com/xiaorouji/openwrt-passwall.git;packages" >> feeds.conf.default
echo "src-git pw_luci https://github.com/xiaorouji/openwrt-passwall.git;luci" >> feeds.conf.default
echo 'src-git unblockneteasemusic https://github.com/cnsilvan/luci-app-unblockneteasemusic.git' >> feeds.conf.default
echo '=========Add feed source OK!========='

# echo '添加K3屏幕插件'
# rm -rf package/lean/k3screenctrl
# git clone --depth=1 https://github.com/Hill-98/luci-app-k3screenctrl.git package/k3/luci-app-k3screenctrl
# git clone --depth=1 https://github.com/Hill-98/openwrt-k3screenctrl.git package/k3/openwrt-k3screenctrl
# echo '=========Add k3screen plug OK!========='

# echo '屏幕插件'
git clone https://github.com/yangxu52/luci-app-k3screenctrl.git package/k3/luci-app-k3screenctrl
git clone https://github.com/yangxu52/k3screenctrl_build.git package/k3/k3screenctrl
# echo '=========Replace k3screen drive plug OK!========='


sed -i '429,460d' target/linux/bcm53xx/image/Makefile
sed -i '140,419d' target/linux/bcm53xx/image/Makefile
sed -i 's/$(BRCMFMAC_4366C0) $(USB3_PACKAGES)/& k3screenctrl luci-app-k3screenctrl/' target/linux/bcm53xx/image/Makefile

#1.'asus_dhd24' 2.'ac88u_20' 3.'69027'
# firmware='ac88u_20'
# echo '替换K3的无线驱动为ac88u_20'
# wget -nv https://github.com/yangxu52/Phicomm-k3-Wireless-Firmware/raw/master/brcmfmac4366c-pcie.bin.${firmware} -O package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
# echo '=========Replace k3 wireless firmware OK!========='

echo './feeds.conf.default:'
cat feeds.conf.default
