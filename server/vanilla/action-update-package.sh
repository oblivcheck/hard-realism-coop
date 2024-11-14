#!/bin/bash

URL_SM="https://sm.alliedmods.net/smdrop/1.11/sourcemod-latest-linux"
# echo "https://github.com/${{ github.repository }}/tree/${{ github.sha }}"

TAG=$(TZ='China/ShangHai' date +"%y%m%d")
TAG="update-package.$TAG-${{ github.sha }}"

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
PACKAGE_DIR="$SCRIPT_DIR/$TAG"

# 创建必要文件夹
cd "$SCRIPT_DIR"
mkdir $TAG
cd "$PACKAGE_DIR"
mkdir left4dead2
cd "$PACKAGE_DIR/left4dead2"
  # 获取Sourcemod
  curl -s "${URL_SM}" > URL
  if [ $? -ne 0 ]; then
    echo "GET F SM"
    exit -1
  fi
  wget -q "https://sm.alliedmods.net/smdrop/1.11/$(cat URL)"
  if [ $? -ne 0 ]; then
    echo "DOWNLOAD F SM"
    exit -1
  fi
  tar -xzvf "$(cat URL)"

  # 移动仓库中的文件
  cp -ravf "$SCRIPT_DIR/left4dead2/*" .
  cd addons/sourcemod/scripting/
  # 编译插件
  ./compile.sh *.sp
  # 移动插件
  mkdir $SCRIPT_DIR/tmp
  cp compiled/*.smx $SCRIPT_DIR/tmp/
  # 整理包裹
  rm -r $PACKAGE_DIR/*
  cp -r $SCRIPT_DIR/left4dead2 $PACKAGE_DIR/
  cd $PACKAGE_DIR
  echo "https://github.com/${{ github.repository }}/tree/${{ github.sha }}" > COMMIT
  cp $SCRIPT_DIR/tmp/* left4dead2/addons/sourcemod/plugins/
  cd ../
  tar -cvf "package.tar" $PACKAGE_DIR


 

