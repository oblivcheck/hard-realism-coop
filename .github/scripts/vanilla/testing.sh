#!/bin/bash
# 安装最新的Sourcemod，MetaMod；以及依赖的的扩展

# $1 执行脚本前所处的工作目录的绝对路径 
# $2 当前选择的commit的的永久URL

URL_MM="https://mms.alliedmods.net/mmsdrop/1.11/mmsource-latest-linux"
URL_SM="https://sm.alliedmods.net/smdrop/1.12/sourcemod-latest-linux"
URL_L4DTOOLZ="https://github.com/lakwsh/l4dtoolz/releases/download/2.4.0/l4dtoolz-11977260267.zip"
URL_LEFT4DOOKS="https://github.com/SilvDev/Left4DHooks/archive/refs/heads/main.zip"
# 06-12-24
URL_ACTION="https://forums.alliedmods.net/attachment.php?attachmentid=204593&d=1718157838"

ACTION_PATH="$1"
echo "S1 # $ACTION_PATH"
URL_REPO="$2"
echo "S2 # $URL_REPO"

# 版本日期的时间戳
TIME_STAMP=$(TZ='Asia/Shanghai' date +"%y%m%d")
# 这个脚本的当前绝对路径
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
# 目标包裹根目录的绝对路径
PACKAGE_DIR="$1/devenv/"
# 服务器文件根目录的绝对路径
SERVER_DIR="$1/../server/vanilla/"


cd "$PACKAGE_DIR"

mkdir left4dead2 left4dead2/l4dtoolz README

# 参考MMS与SM的目录结构
cd left4dead2

# 下载所需文件
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
tar -xzvf "$(cat URL)" > /dev/null

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
tar -xzvf "$(cat URL)" > /dev/null

# 获取L4DtoolZ
cd l4dtoolz
wget -q "${URL_L4DTOOLZ}"
if [ $? -ne 0 ]; then
  echo "DOWNLOAD F TOOLZ"
  touch $SCRIPT_DIR/SCRIPT_FAIL
  exit -1
fi
unzip *.zip > /dev/null
rm *.zip
rm *.dll
# 移动它到正确的位置
mv * ../addons/

# $PACKAGE_DIR/left4dead2/ 
cd ..
rm -r l4dtoolz

mkdir left4dhooks && cd left4dhooks
wget -q "$URL_LEFT4DOOKS"
if [ $? -ne 0 ]; then
  echo "DOWNLOAD F Left4Dhooks"
  touch $SCRIPT_DIR/SCRIPT_FAIL
  exit -1
fi
unzip  main.zip > /dev/null
rm main.zip

# 删除SM自带的插件SMX
  rm -r "$PACKAGE_DIR/left4dead2/addons/sourcemod/plugins"/*
  cd "$PACKAGE_DIR/left4dead2/addons/sourcemod/"
  mkdir origin && mv scripting/* origin/
  cd scripting/
  echo -ne "此包裹的源代码应该参阅:'${URL_REPO}'\n'../origin'目录存储scripting目录下原来的文件\n\n" > README.txt
  echo -ne "Source code for this package should refer to: '${URL_REPO}'\n'../origin' directory stores the original files from the 'scripting' directory\n" >> README.txt
####
#
if find "$PACKAGE_DIR/left4dead2/addons/sourcemod/plugins/" -maxdepth 1 -type f | grep -q . ; then
  echo "包裹中 plugins/ 目录不为空"
  touch $SCRIPT_DIR/SCRIPT_FAIL
  exit 1
fi
####
# 移动已知的 MMS/SM/L4DToolZ/Left4Dhooks 的 许可证,README,更新记录 文件并重命名保存它们
  cd "$SERVER_DIR"
LIST_RDMD_LICENSE="$(cat LIST_RDMD_LICENSE)"
  cat LIST_RDMD_LICENSE | sed '2~2s|^|package/README/|' | sed '1~2s|^|package/|' | xargs -L 2 mv

# 移动Left4Dhooks到正确的位置
  cd $PACKAGE_DIR/left4dead2/left4dhooks/
  cp -r Left4DHooks-main/* ../addons/
  rm -rf $PACKAGE_DIR/left4dead2/left4dhooks

# 创建一个干净的scripting目录
  cd "$PACKAGE_DIR/left4dead2/addons/sourcemod/scripting/"
  cp -rf ../origin/* .

# 移动存储库的插件源代码到包裹
  cp -rf "$SCRIPT_DIR/left4dead2/addons/sourcemod/scripting"/* .

# 删除MMS/SM的压缩包与URL临时文件
  cd $PACKAGE_DIR/left4dead2
  rm *.tar.gz URL

####
#
  if [ ! -e "$PACKAGE_DIR/left4dead2/addons/sourcemod/scripting/./compile.sh" ]; then
    echo "Sourcemod 编译器脚本 compile.sh 不在正确的位置"
    touch $SCRIPT_DIR/SCRIPT_FAIL
    exit -1
  fi

  if [ ! -e "$PACKAGE_DIR/left4dead2/addons/l4dtoolz.so" ]; then
    echo "L4DToolZ 的二进制文件 l4dtoolz.so 不在正确的位置"
    touch $SCRIPT_DIR/SCRIPT_FAIL
    exit -1
  fi

  if [ ! -d "$PACKAGE_DIR/README" ]; then
    echo "用于存储 许可证,README文件,更新记录 的目录 README/ 不在正确的位置"
    touch $SCRIPT_DIR/SCRIPT_FAIL
    exit -1
  fi

  if [ ! -e "$PACKAGE_DIR/left4dead2/addons/sourcemod/scripting/origin" ]; then
    echo "目录 scripting/ 的原始备份不在正确的位置"
    touch $SCRIPT_DIR/SCRIPT_FAIL
    exit -1
  fi
#
###

# 关于包裹的版本标识
  cd $SERVER_DIR
# 获取服务器之前的版本号
VER=$(cat SERVER_VERSION)
VER_TIMESTAMP=$( echo $VER | cut -d '-' -f 1)
VER_NUM=$( echo $VER | cut -d '-' -f 2)

# 构造新的版本号
NUM=0
  if [[ $VER_TIMESTAMP == $TIMESTAMP ]]; then
    let NUM=$((VER_NUM+1));
  else
     NUM=0
  fi
PACKAGE_NMAE="devenv-$TIMESTAMP-$NUM"

# 创建版本标识文件
  cd "$PACKAGE_DIR/../"
  echo "$TIMESTAMP-$NUM" > devenv/SERVER_VERSION
  mv devenv "$PACKAGE_NAME"

# 打包
  tar -czvf "$PACKAGE_NAME.tar.gz" "$PACKAGE_NAME" > /dev/null

# 让Runner知道这个包裹的名字
  cat "$PACKAGE_NAME" > ../PACKAGE_NAME
