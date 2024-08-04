#!/bin/bash
target_group=$(cat /tmp/r4s2/target_group)
#nice -n 10 bash msg2qq.sh -t "$target_group" -g -s "[CQ:at,qq=$qq_id]\n 生成图片中..."
nice -n 10 bash shell/shichao/make.sh
nice -n 10 bash /tmp/r4s2/mpds/generate.sh
nice -n 10 bash shell/msg2qq.sh -t "$target_group" -g -i /tmp/r4s2/mpds/ServerInfoCollector/images/output.jpg
