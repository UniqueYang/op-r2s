#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
wget "https://raw.githubusercontent.com/quintus-lab/Openwrt-R2S/master/patches/for_r2s_18.06.patch"

patch -p1 < ./for_r2s_18.06.patch

wget -O package/lean/default-settings/files/zzz-default-settings https://github.com/quintus-lab/Openwrt-R2S/raw/master/script/zzz-default-settings-18.06

svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cifsd package/lean/luci-app-cifsd

# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate
