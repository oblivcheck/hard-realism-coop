#/bin/bash
shellpath=$(cat /tmp/r4s2/all-servers_shellpath)
tmpfpath=$(cat /tmp/r4s2/all-servers_tmpfpath)
font_path=$shellpath/font/
cd $shellpath
# 生成的脚本的路径
shname=$tmpfpath/generate.sh

echo "convert -size 2000x1400 xc:none  -quality 75 \\" > $shname
for server in {1..14}; do
  cd ../rcon/
  result=""
  sv_is_mpds=0
  sv_is_hrc=0
  if [[ $server == 13 ]]; then
    result=$(./rcon -e m1 "status")
    sv_is_mpds=1
  fi
  if [[ $server == 14 ]]; then
    result=$(./rcon -e h1 "status")
    sv_is_hrc=1
  fi
  if [[ $sv_is_hrc == $sv_is_mpds ]]; then
    result=$(./rcon -e r$server "status")
  fi

  cd $shellpath
  sv_humannum=$( echo "$result" | grep humans | cut -d ',' -f 1 | grep -oE '[0-9]+')
  sv_slotsmax=$( echo "$result" | grep humans | cut -d ',' -f 2 | grep -oP '\d+(?= max)')
  haslobby=1
  if echo "$result" | grep -q unreserved; then
    haslobby=0
  fi

  sv_name=$( echo "$result" | grep "hostname: " | cut -d ':' -f 2)
  sv_map=$( echo "$result" | grep "map" | cut -d ':' -f 2)
  player_name=$(echo "$result" | grep -oP '"\K[^"]+(?=" STEAM)' | sed 's/$/\n/')
  p1=$(echo "$player_name" | sed -n '1{p;q}')
  p2=$(echo "$player_name" | sed -n '3{p;q}')
  p3=$(echo "$player_name" | sed -n '5{p;q}')
  p4=$(echo "$player_name" | sed -n '7{p;q}')
  p5=$(echo "$player_name" | sed -n '9{p;q}')
  p6=$(echo "$player_name" | sed -n '11{p;q}')
  p7=
  p8=
  p9=
  p10=
  p11=
  p12=
  p14=
  # ???
  if [[ $sv_is_mpds == 1 ]]; then
    p7=$(echo "$player_name" | sed -n '13{p;q}')
    p8=$(echo "$player_name" | sed -n '15{p;q}')
    p9=$(echo "$player_name" | sed -n '17{p;q}')
    p10=$(echo "$player_name" | sed -n '19{p;q}')
    p11=$(echo "$player_name" | sed -n '21{p;q}')
    p12=$(echo "$player_name" | sed -n '23{p;q}')
    p13=$(echo "$player_name" | sed -n '25{p;q}')
    p14=$(echo "$player_name" | sed -n '27{p;q}')
  fi
  if [[ $sv_is_hrc == 1 ]]; then
    p5=""
    p6=""
  fi

  faild=0

  if echo "$result" | grep -q "os      : Linux Dedicated"; then
    :
  else
    sv_humannum=""
    sv_slotsmax=""
    sv_name=""
    sv_map=""
    p1=""
    p2=""
    p3=""
    p4=""
    p5=""
    p6=""
    p7=""
    p8=""
    p9=""
    p10=""
    p11=""
    p12=""
    p13=""
    p14=""
    faild=1
  fi
  # 服务器块的上下间隔
  IW=330
  # 服务器块整体垂直偏移
  IOFFSET=48
  # 服务器块整体横向偏移
  IOFFSET_V=40
  # 详细信息的间隔高度
  NIH=36
  # 详细信息左对齐偏移
  NOFFSET=48
  # 服务器块之间的间距
  SVW=440
  # 整个服务器信息面板的横向偏移
  SVO=-16
  # 整个服务器信息面板的垂直偏移
  SVV=64

  if [[ $server -ge 1 && $server -le 4 ]]; then
      y=$(($IW * (server-1) + $IOFFSET))
      x=$((IOFFSET_V + 128))
  elif [[ $server -ge 5 && $server -le 8 ]]; then
      y=$(($IW * (server-5) + $IOFFSET))
      x=$(($SVW + IOFFSET_V + 128))
  elif [[ $server -ge 9 && $server -le 12 ]]; then
      y=$(($IW * (server-9) + $IOFFSET))
      x=$(($SVW * 2 + IOFFSET_V + 128))
  # MPDS
  elif [[ $server == 13 ]]; then
      y=$(($IW + $IOFFSET - 256))
      x=$(($SVW * 3 + IOFFSET_V + 192))
  #HRC
  elif [[ $server == 14 ]]; then
      y=$(($IW * 3  + $IOFFSET - 192))
      x=$(($SVW * 3 + IOFFSET_V + 192))
  fi

  y=$(( $y + $SVV ))

  if [ "$faild" = 1 ]; then
    echo "\( -font \"${font_path}NotoSansCJKsc-Regular.otf\" -pointsize 28 -fill red  -gravity northwest -annotate +$x+$((y + 0)) \"##${server} 服务器没有响应\" \) \\" >> $shname
  else
    if [ "$sv_humannum" = 0 ]; then
      echo "\( -font \"${font_path}NotoSansCJKsc-Regular.otf\" -pointsize 28 -fill \"#AAAAAA\"  -gravity northwest -annotate +$x+$((y + 0)) \"${sv_name}\" \) \\" >> $shname
      echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 24 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + 14))+$((y + $NIH)) \"地图: ${sv_map:1}\" \) \\" >> $shname
    else
      echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 24 -fill orange  -gravity northwest -annotate +$((x - 64 - 4))+$((y + 0)) \"(${sv_humannum}/${sv_slotsmax})\" \) \\" >> $shname
      echo "\( -font \"${font_path}NotoSansCJKsc-Regular.otf\" -pointsize 28 -fill white  -gravity northwest -annotate +$x+$((y + 0)) \"${sv_name}\" \) \\" >> $shname
      echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 24 -fill white  -gravity northwest -annotate +$((x + 14))+$((y + $NIH)) \"地图: ${sv_map:1}\" \) \\" >> $shname
    fi
  fi

  ## MPDS服务器
  if [[ $server == 13 ]]; then
    echo "\( -font \"${font_path}hkbft.ttf\" -pointsize 26 -fill pink  -gravity northwest -annotate +$x+$((y -28)) \"M P D S\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 2 )) \"[${p1}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 3 )) \"[${p2}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 4 )) \"[${p3}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 5 )) \"[${p4}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 6 )) \"[${p5}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 7 )) \"[${p6}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 8 )) \"[${p7}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 9 )) \"[${p8}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 10 )) \"[${p9}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 11 )) \"[${p10}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 12 )) \"[${p11}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 13 )) \"[${p12}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 14)) \"[${p13}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 15 )) \"[${p14}]\" \) \\" >> $shname
    continue
  fi
  ## HRC服务器
  if [[ $server == 14 ]]; then
    echo "\( -font \"${font_path}hkbft.ttf\" -pointsize 27 -fill red  -gravity northwest -annotate +$x+$((y -28)) \"H R C\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 2 )) \"[${p1}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 3 )) \"[${p2}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 4 )) \"[${p3}]\" \) \\" >> $shname
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 5 )) \"[${p4}]\" \) \\" >> $shname
    continue
  fi
  ## RC服务器
  if [ "$haslobby" = 1 ]; then
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 20 -fill green  -gravity northwest -annotate +$x+$((y -32)) \"存在大厅:是\" \) \\" >> $shname
  else
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 20 -fill \"#800000\"  -gravity northwest -annotate +$x+$((y -32)) \"存在大厅:否\" \) \\" >> $shname
  fi

  if [[ $server -ge 10 ]]; then
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 16 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x+128))+$((y -26)) \"端口:480${server}\" \) \\" >> $shname
  else
    echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 16 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x+128))+$((y -26)) \"端口:4800${server}\" \) \\" >> $shname
  fi

  echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 2)) \"[${p1}]\" \) \\" >> $shname
  echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 3 )) \"[${p2}]\" \) \\" >> $shname
  echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 4 )) \"[${p3}]\" \) \\" >> $shname
  echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 5 )) \"[${p4}]\" \) \\" >> $shname
  echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 6 )) \"[${p5}]\" \) \\" >> $shname
  echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 22 -fill \"#AAAAAA\"  -gravity northwest -annotate +$((x + NOFFSET))+$((y + $NIH * 7 )) \"[${p6}]\" \) \\" >> $shname

  if [[ $server -le 8 ]]; then
    echo "\( -font \"${font_path}hkbft.ttf\" -pointsize 20 -fill pink -gravity northwest -annotate +$((x - 48))+$((y + 48)) \"公共\" \) \\" >> $shname
  fi
  if [[ $server -ge 9 ]]; then
    echo "\( -font \"${font_path}hkbft.ttf\" -pointsize 20 -fill pink -gravity northwest -annotate +$((x - 48))+$((y + 48)) \"保留\" \) \\" >> $shname
  fi
  if [[ $server -ge 11 ]]; then
    echo "\( -font \"${font_path}hkbft.ttf\" -pointsize 20 -fill pink -gravity northwest -annotate +$((x - 48))+$((y + 72)) \"群三方\" \) \\" >> $shname
  fi

done

nowtime=$(date)
#echo $nowtime
echo "\( -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 28 -fill orange -gravity north -annotate +0+24 \"${nowtime}\" \) \\"  >> $shname
echo "$tmpfpath/info.png" >> $shname

