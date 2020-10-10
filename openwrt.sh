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

# from [quintus-lab](https://github.com/quintus-lab/Openwrt-R2S)
clear

echo "VersionDate=$(git show -s --date=short --format="%cd")"
echo "VersionDate::$VersionDate"
echo "DATE::$(date "+%Y-%m-%d %H:%M:%S")"
echo "Build_Date::$(date +%Y.%m.%d)"
echo "Build_Date=$(date +%Y.%m.%d)" >> $GITHUB_ENV


./scripts/feeds update -a && ./scripts/feeds install -a

patch -p1 < ./project-openwrt.patch

# svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cifsd package/lean/luci-app-cifsd

echo -e '\n '$Build_Date'\n'  >> package/lean/default-settings/files/openwrt_banner
sed -i 's/'$Build_Date'/g' package/lean/default-settings/files/zzz-default-settings

# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate
