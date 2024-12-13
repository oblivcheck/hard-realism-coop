#!/bin/bash
# 安装最新的Sourcemod，MetaMod；以及依赖的的扩展

URL_MM="https://mms.alliedmods.net/mmsdrop/1.11/mmsource-latest-linux"
URL_SM="https://sm.alliedmods.net/smdrop/1.12/sourcemod-latest-linux"
URL_L4DTOOLZ="https://github.com/lakwsh/l4dtoolz/releases/download/2.4.0/l4dtoolz-11977260267.zip"
URL_LEFT4DOOKS="https://github.com/SilvDev/Left4DHooks/archive/refs/heads/main.zip"
# 06-12-24
URL_ACTION="https://forums.alliedmods.net/attachment.php?attachmentid=204593&d=1718157838"

URL_REPO="$1"
echo "# $URL_REPO"

TIMESTAMP=$(TZ='Asia/Shanghai' date +"%y%m%d")
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
PACKAGE_DIR="$SCRIPT_DIR/package"

# 创建必要文件夹
cd "$SCRIPT_DIR"
mkdir package
cd "$PACKAGE_DIR"
mkdir left4dead2 left4dead2/l4dtoolz README
cd "$PACKAGE_DIR/left4dead2"
if [[ $2 != "testing" ]]; then
  # 获取并解压
    curl -s "${URL_MM}" > URL
    if [ $? -ne 0 ]; then
      echo "GET F MM"
      touch $SCRIPT_DIR/SCRIPT_FAIL
      exit -1
    fi
    wget -q "https://mms.alliedmods.net/mmsdrop/1.11/$(cat URL)"
    if [ $? -ne 0 ]; then
      echo "DOWNLOAD F MM"
      touch $SCRIPT_DIR/SCRIPT_FAIL
      exit -1
    fi
    tar -xzvf "$(cat URL)"

    curl -s "${URL_SM}" > URL
    if [ $? -ne 0 ]; then
      echo "GET F SM"
      touch $SCRIPT_DIR/SCRIPT_FAIL
      exit -1
    fi
    wget -q "https://sm.alliedmods.net/smdrop/1.12/$(cat URL)"
    if [ $? -ne 0 ]; then
      echo "DOWNLOAD F SM"
      touch $SCRIPT_DIR/SCRIPT_FAIL
      exit -1
    fi
    tar -xzvf "$(cat URL)"

    cd l4dtoolz
    wget -q "${URL_L4DTOOLZ}"
    if [ $? -ne 0 ]; then
      echo "DOWNLOAD F TOOLZ"
      touch $SCRIPT_DIR/SCRIPT_FAIL
      exit -1
    fi
    unzip *.zip
    rm *.zip
    rm *.dll
    mv * ../addons
    cd ..

    mkdir left4dhooks && cd left4dhooks
    wget -q "$URL_LEFT4DOOKS"
    if [ $? -ne 0 ]; then
      echo "DOWNLOAD F Left4Dhooks"
      touch $SCRIPT_DIR/SCRIPT_FAIL
      exit -1
    fi
    unzip  main.zip
    rm main.zip

fi
# 移动已知的说明与许可证&&删除不必要的文件
  rm -r "$PACKAGE_DIR/left4dead2/addons/sourcemod/plugins"/*
# 稍微提醒
  cd "$PACKAGE_DIR/left4dead2/addons/sourcemod/scripting/"
  mkdir orig && mv * orig/
  echo -ne "此包裹的源代码应该参阅:'${URL_REPO}'\n'orig'目录存储scripting目录下原来的文件\n\n" > README.txt
  echo -ne "Source code for this package should refer to: '${URL_REPO}'\n'orig' directory stores the original files from the 'scripting' directory\n" >> README.txt
  cd "$SCRIPT_DIR"
LIST_RDMD_LICENSE="$(cat LIST_RDMD_LICENSE)"
  cat LIST_RDMD_LICENSE | sed '2~2s|^|package/README/|' | sed '1~2s|^|package/|' | xargs -L 2 mv

  cd $PACKAGE_DIR/left4dead2/left4dhooks/
  cp -r Left4DHooks-main/* ../addons/
  cd "$PACKAGE_DIR/left4dead2/addons/sourcemod/scripting/"

  rm -rf $PACKAGE_DIR/left4dead2/l4dtoolz
  rm -rf $PACKAGE_DIR/left4dead2/left4dhooks


# 移动仓库的SMX插件源代码与库文件到包裹
  cd "$PACKAGE_DIR/left4dead2/addons/sourcemod/scripting/"
  cp -rf orig/* .
#  cp -rf "$SCRIPT_DIR/left4dead2/addons/sourcemod/"/* "$PACKAGE_DIR/left4dead2/addons/sourcemod/"
  cp -rf "$SCRIPT_DIR/left4dead2/addons/sourcemod/scripting"/* "$PACKAGE_DIR/left4dead2/addons/sourcemod/scripting/"

# 移动编译器
  mv orig ../
  mv ../orig/spcomp .
  mv ../orig/spcomp64 .
  mv ../orig/*.sh .

  cd $PACKAGE_DIR

# 删除压缩包与临时文件
  cd left4dead2
  rm *.tar.gz URL
  cd $SCRIPT_DIR
# 获取服务器之前的版本号
VER=$(cat SERVER_VERSION)
VER_TIMESTAMP=$( echo $VER | cut -d '-' -f 1)
VER=$( echo $VER | cut -d '-' -f 2)

# 构造新的版本号
NUM=0
  if [[ $VER_TIMESTAMP == $TIMESTAMP ]]; then
    let NUM=$((VER+1));
  else
     NUM=0
  fi
PACKAGE_NMAE="devenv-$TIMESTAMP-$NUM"
  mv package devenv
  echo "VER_TIMESTAM-$NUM" > devenv/PACKAGE_NAME
  tar -czvf devenv.tar.gz devenv/
