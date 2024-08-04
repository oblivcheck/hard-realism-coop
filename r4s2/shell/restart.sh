#!/bin/bash
#text="#12"
target_group=$(cat /tmp/r4s2/target_group)
#现在只需要第一行包括#符，提取该符号之后的所有字符
target=$(echo -e "$text" | sed -n '1p' | cut -d\# -f2)
shellpath=$(cat /tmp/r4s2/rc_shellpath)
cd $shellpath && cd ../
cd rcon
rcon_command="./rcon -e 'r$target' \"status\""
result=$(eval "$rcon_command")
cd $shellpath && cd ../
echo $shellpath
echo "处于shell目录"
if echo "$result" | grep -q "os      : Linux Dedicated" && ! echo "$result" | grep -q ": 0 humans, 0 bots"; then
  bash msg2qq.sh -t "$target_group" -g -s "[CQ:at,qq=$qq_id]\n 目标服务器中还有玩家！"
else
  screen_names=("r1" "r2" "r3" "r4" "r5" "r6" "r7" "r8" "r9" "r10" "r11" "r12")
  maps=("c2m1_highway" "c5m1_waterfront" "c9m1_alleys" "c12m1_hilltop" "c1m1_hotel" "c8m1_apartment" "c1m1_hotel" "c1m1_hotel" "c1m1_hotel" "c1m1_hotel" "c1m1_hotel" "c1m1_hotel")
  ports=("48001" "48002" "48003" "48004" "48005" "48006" "48007" "48008" "48009" "48010" "48011" "48012")

  sv_find=false
  for i in "${!screen_names[@]}"; do
      name=${screen_names[$i]}
      map=${maps[$i]}
      port=${ports[$i]}
      if [ "${name:1}" == "${target}" ]; then
        sv_find=true
        cd rcon
        ./rcon -e r${target} "say 此服务器(#$target)即将通过QQ群$target_group手动重启"
        cd $shellpath && cd ../
        bash msg2qq.sh -t "$target_group" -g -s "[CQ:at,qq=$qq_id]\n 正在重启#${target}服务器"

        sleep 1
        echo "\n!!!!!!!!重新启动r$target服务器中!!!!!!!!!!!!!!!\n"
        ps aux | grep -i Steam/l4d2_r${target} | awk '{print $2}' | xargs kill
        sleep 1
        screen -dmS ${name} /home/steam/Steam/l4d2_r${target}/srcds_run +map ${map} -port ${port} -tickrate 60 -nowatchdog
        break
      fi
  done
  if ! $sv_find ; then
        bash msg2qq.sh -t "$target_group" -g -s "[CQ:at,qq=$qq_id]\n 错误的服务器序号#${target}"
  fi
fi
