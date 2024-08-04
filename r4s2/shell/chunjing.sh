#!/bin/bash
#mkdir -p /tmp/ServerInfoCollector/images/
target_group=$(cat /tmp/r4s2/target_group)
nice -n 10 bash shell/chunjing/make.sh
nice -n 10 bash /tmp/r4s2/rc/generate.sh
nice -n 10 bash shell/msg2qq.sh -t "$target_group" -g -i /tmp/r4s2/rc/ServerInfoCollector/images/output4.jpg

