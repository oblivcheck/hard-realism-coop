#!/bin/bash
mkdir -p /tmp/r4s2/mpds/ServerInfoCollector/images/
mkdir -p /tmp/r4s2/rc/ServerInfoCollector/images/
mkdir -p /tmp/r4s2/all-servers

#echo "948265569" > /tmp/r4s2/target_group
echo "300129041" > /tmp/r4s2/target_group

echo "/home/tic/git/hard-realism-coop/r4s2/shell/chunjing" > /tmp/r4s2/rc_shellpath
echo "/tmp/r4s2/rc" > /tmp/r4s2/rc_tmpfpath
echo "/home/tic/git/hard-realism-coop/r4s2/shell/shichao" > /tmp/r4s2/mpds_shellpath
echo "/tmp/r4s2/mpds" > /tmp/r4s2/mpds_tmpfpath
echo "/home/tic/git/hard-realism-coop/r4s2/shell/all-servers" > /tmp/r4s2/all-servers_shellpath
echo "/tmp/r4s2/all-servers" > /tmp/r4s2/all-servers_tmpfpath

ruby r4s2.rb
