#!/bin/bash

URL_SM="https://sm.alliedmods.net/smdrop/1.12/sourcemod-latest-linux"
# echo "https://github.com/${{ github.repository }}/tree/${{ github.sha }}"
URL_REPO="$1"
echo "# $URL_REPO"

TAG=$(TZ='China/ShangHai' date +"%y%m%d")
TAG="update-package.$TAG-${{ github.sha }}"

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
PACKAGE_DIR="$SCRIPT_DIR/package"

# 创建必要文件夹
cd "$SCRIPT_DIR"
mkdir $TAG
cd "$PACKAGE_DIR"
mkdir left4dead2
cd "$PACKAGE_DIR/left4dead2"
if [[ $2 != "testing" ]]; then
    # 获取Sourcemod
    curl -s "${URL_SM}" > URL
    if [ $? -ne 0 ]; then
      echo "GET F SM"
      exit -1
    fi
    wget -q "https://sm.alliedmods.net/smdrop/1.12/$(cat URL)"
    if [ $? -ne 0 ]; then
      echo "DOWNLOAD F SM"
      exit -1
    fi
    tar -xzvf "$(cat URL)"
fi
