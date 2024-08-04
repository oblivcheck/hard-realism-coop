#/bin/bash
shellpath=$(cat /tmp/r4s2/mpds_shellpath)
tmpfpath=$(cat /tmp/r4s2/mpds_tmpfpath)
font_path=$shellpath/font/

cd $shellpath
shname=$tmpfpath/generate.sh
counter=0

cd ../rcon
result_m1=$(./rcon -e m1 status)
cd $shellpath

sn_m1=$( echo "$result_m1" | grep "hostname: " | cut -d ':' -f 2)
sm_m1=$( echo "$result_m1" | grep "map" | cut -d ':' -f 2)
faild_m1=0
if echo "$result_m1" | grep -q "os      : Linux Dedicated"; then
	:
else
	faild_m1=1
fi

cd ../rcon
m1_name_info=$(./rcon -e m1 sm_si_info)
cd $shellpath
pn_m1=$(echo "$m1_name_info" |wc -l)
pn_m1=$((pn_m1 /2))
counter=$pn_m1

counter=0
name=0
connecttime=0

########
echo "convert -size 800x$((120 + 40 * ((counter+1) * 2) )) xc:black -background black -quality 75 \\" > $shname
echo "\( -font \"$font_path/NotoSansMonoCJKsc-Regular.otf\" -pointsize 28 -fill white  -gravity North -annotate +0+40 '${sn_m1}' \) \\" >> $shname

if [ "$pn_m1" = 0 ]; then
	if [ "$faild_m1" = 1 ]; then
		echo "\( -font \"$font_path/NotoSansMonoCJKsc-Regular.otf\" -pointsize 24 -fill red -gravity North -annotate +0+80 '获取服务器信息失败' \) \\" >> $shname
	else
		echo "\( -font \"$font_path/NotoSansMonoCJKsc-Regular.otf\" -pointsize 24 -fill red -gravity North -annotate +0+80 '此服务器目前没有玩家' \) \\" >> $shname
	fi
else
{
	echo "\( -font \"$font_path/NotoSansMonoCJKsc-Regular.otf\" -pointsize 24 -fill white  -gravity North -annotate +0+80 '地图：${sm_m1}' \) \\" >> $shname

	while [ $counter -lt $((pn_m1 * 2)) ]
	do
		if ((counter % 2 == 0)); then
			name=$(echo "$m1_name_info" | sed -n "$((counter+1))p")
			connecttime=$(echo "$m1_name_info" | sed -n "$((counter+2))p")
			echo "\( -font \"$font_path/font/NotoSansMonoCJKsc-Regular.otf\" -pointsize 24 -fill \"#AAAAAA\" -gravity North -annotate +0+$((120 + 40 * counter)) '${name}    已连接时间：${connecttime}' \) \\" >> $shname
		fi
		((counter++))
	done
}
fi
########
echo "$tmpfpath/ServerInfoCollector/images/output.jpg" >> $shname
