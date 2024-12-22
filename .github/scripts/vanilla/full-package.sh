#!/bin/bash
# 生成完整的服务器包裹

# $1 devenv包裹的名称
# $2 devenv包裹根目录的绝对路径
# $3 devenv包裹所使用的服务器版本

PACKAGE_NAME="$1"
PACKAGE_DIR="$2"
# 服务器文件根目录的绝对路径
SERVER_DIR="$2/../server/vanilla/"
TIME_STAMP="$3"

 mkdir $PACKAGE_DIR/left4dead2/addons/sourcemod/plugins/disabled/

 # 将不使用的插件关闭
  cd "$PACKAGE_DIR/left4dead2/addons/sourcemod/scripting/compiled/"
LIST_DISABLE_PLUGIN="$(cat $SERVER_DIR/LIST_DISABLE_PLUGIN)"
  echo "$LIST_DISABLE_PLUGIN" | xargs -I {} -n 1 mv {} "$PACKAGE_DIR/left4dead2/addons/sourcemod/plugins/disabled/"

# 移动编译好的插件
  mv *.smx $PACKAGE_DIR/left4dead2/addons/sourcemod/plugins/
   
# 移动服务器配置文件
  cd $PACKAGE_DIR  
# 确保目录存在
  mkdir left4dead2/ems
  mkdir -p left4dead2/cfg
  mkdir -p left4dead2/scripts/vscripts
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
 
# 应该保留的服务器配置
  cd "$SERVER_DIR"
  sed -n 'n;p' LIST_IGNORE | xargs -I {} cp -rf {} "$PACKAGE_DIR/"
  cd "$PACKAGE_DIR"
  
# 准备更新存储库
#  git config --global user.name "GitHub Actions"
#  git config --global user.email "actions@github.com"
#  git add -A .
  cd $PACKAGE_DIR
  rm admins_simple.ini
  # 在workflow中就已经被删除
  # rm PACKAGE_NAME
  cd ../
  # workflow中命名为root?
  mv "$PACKAGE_NAME" "package-$TIME_STAMP"
  # mv root  "package-$TIME_STAMP"
PACKAGE_NAME="package-$TIME_STAMP"
  tar -czvf "$PACKAGE_NAME.tar.gz" $PACKAGE_NAME/ > /dev/null
#  同样，目录已经被重命名为root
#  git rm -rf "$PACKAGE_NAME"
#  git commit -m "Vanilla: $TIME_STAMP 生成包裹并更新存储库"
  cd $SERVER_DIR
  echo "$TIME_STAMP" > SERVER_VERSION
#  git add -A .
