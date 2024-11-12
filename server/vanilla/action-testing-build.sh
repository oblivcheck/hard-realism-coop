#!/bin/bash
# 为什么写的简陋？ 因为在测试过程中我意外删除了一个接近完成状态的详细版本 :(
# 很不巧，我还位于/tmp中，且该目录挂载为tmpfs :(
# 我现在唯一能做的是记录这件事情，然后*耐心地*重新编写 :)


URL_MM="https://mms.alliedmods.net/mmsdrop/1.11/mmsource-latest-linux"
URL_SM="https://sm.alliedmods.net/smdrop/1.12/sourcemod-latest-linux"
URL_L4DTOOLZ="https://github.com/lakwsh/l4dtoolz/releases/download/2.3.4/l4dtoolz-11618361613.zip"
# echo "https://github.com/${{ github.repository }}/tree/${{ github.sha }}"
URL_REPO="$1"
echo "# $URL_REPO"

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
PACKAGE_DIR="$SCRIPT_DIR/package"

if [[ $2 = "mdgen" ]]; then

  exit 0
fi

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
      exit -1
    fi
    wget -q "https://mms.alliedmods.net/mmsdrop/1.11/$(cat URL)"
    if [ $? -ne 0 ]; then
      echo "DOWNLOAD F MM"
      exit -1
    fi
    tar -xzvf "$(cat URL)"

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

    cd l4dtoolz
    wget -q "${URL_L4DTOOLZ}"
    if [ $? -ne 0 ]; then
      echo "DOWNLOAD F TOOLZ"
      exit -1
    fi
    unzip *.zip
    rm *.zip
    rm *.dll
    mv * ../addons
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
# 移动仓库的SMX插件源代码与库文件到包裹
LIST_DISABLE_PLUGIN="$(cat LIST_DISABLE_PLUGIN)"
  mv -n "$SCRIPT_DIR/left4dead2/addons/sourcemod/scripting"/* "$PACKAGE_DIR/left4dead2/addons/sourcemod/scripting/"
  cd "$PACKAGE_DIR/left4dead2/addons/sourcemod/scripting/"
PLUGIN_NUM=$(ls *.sp | xargs -I {} basename {} | sed 's/.sp/.smx/' | grep -v "${LIST_DISABLE_PLUGIN}" | wc -l | tr -d '\n')
  mv orig ../
  ./compile.sh *.sp
  mkdir "$PACKAGE_DIR/left4dead2/addons/sourcemod/plugins/disabled"
  mv ../orig .
  cd compiled
  echo "$LIST_DISABLE_PLUGIN" | xargs -I {} -n 1 mv {} "$PACKAGE_DIR/left4dead2/addons/sourcemod/plugins/disabled/"
TMP=$(ls | wc -l | tr -d '\n')
  if [ $TMP -ne $PLUGIN_NUM ]; then
    echo "F PLUGIN NUM"
    exit -1
  fi
  mv *.smx "$PACKAGE_DIR/left4dead2/addons/sourcemod/plugins/"

# 移动各种配置文件与脚本
  cd $PACKAGE_DIR
  cp -r $SCRIPT_DIR/left4dead2/cfg/* left4dead2/cfg/
  cp -r $SCRIPT_DIR/left4dead2/scripts/vscripts/* left4dead2/scripts/vscripts/
  cp -r $SCRIPT_DIR/left4dead2/ems/* left4dead2/ems/
  cp -r $SCRIPT_DIR/left4dead2/host.txt left4dead2/host.txt
  cp -r $SCRIPT_DIR/left4dead2/motd.txt left4dead2/motd.txt

# 清理
  cd left4dead2
  rm *.tar.gz URL

echo " $PLUGIN_NUM # $TMP "
