#!/bin/bash
SCRIPT_DIR="../server/vanilla/"
DEVENV_ROOT=$(pwd)
  cd $DEVENV_ROOT/left4dead2/addons/sourcemod/scripting
# 将Sourcemod的原始插件代码备份移回scpiting目录
  mv ../orig .
# 将不使用的插件关闭
LIST_DISABLE_PLUGIN="$(cat $SCRIPT_DIR/LIST_DISABLE_PLUGIN)"
  echo "$LIST_DISABLE_PLUGIN" | xargs -I {} -n 1 mv {} "$PACKAGE_DIR/left4dead2/addons/sourcemod/plugins/disabled/"
  find .

# 移动服务器配置文件
  # 确保目录存在
  cd $DEVENV_ROOT
  mkdir left4dead2/ems
  mkdir -p left4dead2/cfg
  mkdir left4dead2/scripts
  # 资源文件
  cp -r $SCRIPT_DIR/left4dead2/models $DEVENV_ROOT/left4dead2/
  cp -r $SCRIPT_DIR/left4dead2/materials $DEVENV_ROOT/left4dead2/
  cp -r $SCRIPT_DIR/left4dead2/sound $DEVENV_ROOT/left4dead2/

  cp -r $SCRIPT_DIR/left4dead2/cfg/* $DEVENV_ROOT/left4dead2/cfg/
  cp -r $SCRIPT_DIR/left4dead2/scripts/vscripts/* $DEVENV_ROOT/left4dead2/scripts/vscripts/
  cp -r $SCRIPT_DIR/left4dead2/ems/* $DEVENV_ROOT/left4dead2/ems/
  cp -r $SCRIPT_DIR/left4dead2/host.txt $DEVENV_ROOT/left4dead2/host.txt
  cp -r $SCRIPT_DIR/left4dead2/motd.txt $DEVENV_ROOT/left4dead2/motd.txt

# 准备更新存储库
  git config --global user.name "GitHub Actions"
  git config --global user.email "actions@github.com"
  git add -A .
  cd $DEVENV_ROOT
TIMESTAMP=$(cat PACKAGE_NAME)
  cd ../
  mv devenv/ package
  tar -czvf server/vanilla/package-$TIMESTAMP.tar.gz package
  git rm -rf package/
  git commit -m "Vanilla: $TIMESTAMP 生成包裹并更新存储库"
  cd server/vanilla/
  echo "TIMESTAMP" > PACKAGE_NAME
  git add -A .
  cd ../../ && find .
