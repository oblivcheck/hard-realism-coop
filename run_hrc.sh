#!/bin/bash
mkdri -p /tmp/hard-realism-coop/
cd /tmp/hard-realism-coop/
git pull
cp -r server/* /home/steam/Steam/hrc/
cp -r run_hrc.sh /home/steam/Steam/
chmod +x /home/steam/Steam/run_hrc.sh

screen -S h1 /home/steam/Steam/hrc/srcds_run +map c8m1_apartment -port 37010 -tickrate 96
