#!/bin/bash
target_group=$(cat /tmp/r4s2/target_group)
qq_id=$(cat /tmp/r4s2/qq_id)
MIP=$(eval "cat /tmp/ip")

nice -n 10 bash shell/msg2qq.sh -t "$target_group" -g -s "[CQ:at,qq=$qq_id]\n纯净服端口: 48001~48012\n尸潮服端口: 37000"
nice -n 10 bash shell/msg2qq.sh -t "$target_group" -g -s "connect ${MIP}:端口"
nice -n 10 bash shell/msg2qq.sh -t "$target_group" -g -s "mm_dedicated_force_servers ${MIP}:端口"
