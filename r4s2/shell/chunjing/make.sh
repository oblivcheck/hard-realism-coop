#/bin/bash
shellpath=$(cat /tmp/r4s2/rc_shellpath)
tmpfpath=$(cat /tmp/r4s2/rc_tmpfpath)
font_path=$shellpath/font/
cd $shellpath
# 生成的脚本的路径
shname=$tmpfpath/generate.sh

image=$(ls -d images/* | sort -R | head -n 1 | xargs  readlink -f)
echo "convert -size 1600x1400 xc:none  -quality 75 \\" > $shname
for server in {1..12}; do
cd ../rcon/
result=$(./rcon -e r$server "status")
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

faild=0
if echo "$result" | grep -q "os      : Linux Dedicated"; then
  :
else
  sv_humannum=""
  sv_slotsmax=""
  sv_name=""
  sv_map=""
  #player_name=$(echo "$result" | grep -oP '"\K[^"]+(?=" STEAM)' | sed 's/$/\n/')
  p1=""
  p2=""
  p3=""
  p4=""
  p5=""
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
SVW=400
# 整个服务器信息面板的横向偏移
SVO=-16
# 整个服务器信息面板的垂直偏移
SVV=60

if [[ $server -ge 1 && $server -le 4 ]]; then
    y=$(($IW * (server-1) + $IOFFSET))
    x=$((IOFFSET_V + 128))
elif [[ $server -ge 5 && $server -le 8 ]]; then
    y=$(($IW * (server-5) + $IOFFSET))
    x=$(($SVW + IOFFSET_V + 128))
elif [[ $server -ge 9 && $server -le 12 ]]; then
    y=$(($IW * (server-9) + $IOFFSET))
    x=$(($SVW * 2 + IOFFSET_V + 128))
fi

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
mkdir -p $tmpfpath/ServerInfoCollector/images/
echo "$tmpfpath/ServerInfoCollector/images/output.png" >> $shname
echo "convert ${image} -resize 2560x1440^ -gravity center -extent 2560x1440 $tmpfpath/ServerInfoCollector/images/resized_image.png" >> $shname
echo "convert $tmpfpath/ServerInfoCollector/images/resized_image.png \\
\( +clone -alpha set -channel A -evaluate set 0 +channel -draw 'roundrectangle 32,32 1296,1408 50,50' \\
   -write mpr:mask +delete \) \\
\( -clone 0 -region 1264x1376+32+32 -blur 0x6 \\
   -write mpr:blurred +delete \) \\
mpr:mask -compose DstIn -composite mpr:blurred -compose Over -composite \\
-fill 'rgba(0,0,0,0.6)' -draw 'roundrectangle 32,32 1296,1408 50,50' \\
$tmpfpath/ServerInfoCollector/images/output2.png" >> "$shname"

echo "convert $tmpfpath/ServerInfoCollector/images/output2.png $tmpfpath/ServerInfoCollector/images/output.png -geometry +${SVO}+${SVV}+340+260 -composite $tmpfpath/ServerInfoCollector/images/output3.jpg"  >> $shname
echo "convert $tmpfpath/ServerInfoCollector/images/output3.jpg \
$shellpath/sv.jpg \
-gravity northeast -geometry +20+30 -composite \
$tmpfpath/ServerInfoCollector/images/output4.jpg" >> $shname

nowtime=$(date)
#echo $nowtime
echo "convert $tmpfpath/ServerInfoCollector/images/output4.jpg -font \"${font_path}NotoSansMonoCJKsc-Regular.otf\" -pointsize 24 -fill red -gravity northwest -geometry +0+0 -annotate +440+40 \"${nowtime}\" $tmpfpath/ServerInfoCollector/images/output4.jpg" >> $shname
echo "convert $tmpfpath/ServerInfoCollector/images/output4.jpg \\
-fill \"rgba(0,0,0,0.6)\" \\
-draw \"roundrectangle 1311,739 2540,1410 50,50\" \\
$tmpfpath/ServerInfoCollector/images/output4.jpg" >> "$shname"
