#!/bin/bash
# 生成完整的服务器包裹

# $1 devenv包裹的名称
# $2 devenv包裹根目录的绝对路径
# $3 devenv包裹所使用的服务器版本

PACKAGE_NAME="$1"
PACKAGE_DIR="$2"
# 服务器文件根目录的绝对路径
SERVER_DIR="$2/../server/vanilla/"
TIMESTAMP="$3"

 # 将不使用的插件关闭
  cd "$PACKAGE_DIR/left4dead2/addons/sourcemod/scripting/compiled/"
LIST_DISABLE_PLUGIN="$(cat $SERVER_DIR/LIST_DISABLE_PLUGIN)"
  echo "$LIST_DISABLE_PLUGIN" | xargs -I {} -n 1 mv {} "$PACKAGE_DIR/left4dead2/addons/sourcemod/plugins/disabled/"

# 移动服务器配置文件
  cd $PACKAGE_DIR  
# 确保目录存在
  mkdir left4dead2/ems
  mkdir -p left4dead2/cfg
  mkdir left4dead2/scripts
# 资源文件
  cp -r $SERVER_DIR/left4dead2/models $PACKAGE_DIR/left4dead2/
  cp -r $SERVER_DIR/left4dead2/materials $PACKAGE_DIR/left4dead2/
  cp -r $SERVER_DIR/left4dead2/sound $PACKAGE_DIR/left4dead2/

  cp -r $SERVER_DIR/left4dead2/cfg/* $PACKAGE_DIR/left4dead2/cfg/
  cp -r $SERVER_DIR/left4dead2/scripts/vscripts/* $PACKAGE_DIR/left4dead2/scripts/vscripts/
  cp -r $SERVER_DIR/left4dead2/ems/* $PACKAGE_DIR/left4dead2/ems/
  cp -r $SERVER_DIR/left4dead2/host.txt $PACKAGE_DIR/left4dead2/host.txt
  cp -r $SERVER_DIR/left4dead2/motd.txt $PACKAGE_DIR/left4dead2/motd.txt

# 所有的配置文件
  cp -rf "$SERVER_DIR/left4dead2/addons/sourcemod"/* "$PACKAGE_DIR/left4dead2/addons/sourcemod/"

# 准备更新存储库
  git config --global user.name "GitHub Actions"
  git config --global user.email "actions@github.com"
  git add -A .
  cd $PACKAGE_DIR
  rm PACKAGE_NAME
  cd ../
  mv "$PACKAGE_NAME"  "package-$TIMESTAMP"
PACKAGE_NAME="package-$TIMESTAMP"
  tar -czvf "$PACKAGE_NAME.tar.gz" $PACKAGE_NAME/ > /dev/null

  git rm -rf "$PACKAGE_NAME"
  git commit -m "Vanilla: $TIMESTAMP 生成包裹并更新存储库"
  cd $SERVER_DIR
  echo "$TIMESTAMP" > SERVER_VERSION
  git add -A .