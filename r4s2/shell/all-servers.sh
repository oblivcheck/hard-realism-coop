#!/bin/bash
target_group=$(cat /tmp/r4s2/target_group)
nice -n 10 bash shell/all-servers/make.sh
nice -n 10 bash /tmp/r4s2/all-servers/generate.sh
#nice -n 10 bash shell/msg2qq.sh -t "$target_group" -g -i /tmp/r4s2/all-servers/info.png
