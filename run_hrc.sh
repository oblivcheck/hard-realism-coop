#!/bin/bash
tmpdir=/tmp/hard-realism-coop
repurl="https://github.com/oblivcheck/hard-realism-coop"

export http_proxy="http://10.10.10.10:8066"
export https_proxy="http://10.10.10.10:8066"
if [ -d "$tmpdir" ]; then
  cd $tmpdir
  git pull
else
  cd /tmp
  git clone $repurl
  cd $tmpdir
fi

cp -r server/* /home/steam/Steam/hrc/
cp -r run_hrc.sh /home/steam/Steam/
chmod +x /home/steam/Steam/run_hrc.sh
export http_proxy=
export https_proxy=
screen -dmS h1 /home/steam/Steam/hrc/srcds_run +map c8m1_apartment -port 37010 -tickrate 96
