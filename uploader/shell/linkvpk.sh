#!/bin/bash
if [[ $2 == "sv.sayuri.city" ]]; then
  find "$1" -type f -name "*.vpk" -exec sh -c 'ln -sf "$1" "/tmp/1/$(md5sum "$1" | awk '\''{print $1}'\'').vpk"' _ {} \;
  find "$1" -type f -name "*.vpk" -exec sh -c 'ln -sf "$1" "/tmp/1/$(md5sum "$1" | awk '\''{print $1}'\'').vpk"' _ {} \;
  find "$1" -type f -name "*.vpk" -exec sh -c 'ln -sf "$1" "/tmp/1/$(md5sum "$1" | awk '\''{print $1}'\'').vpk"' _ {} \;
  find "$1" -type f -name "*.vpk" -exec sh -c 'ln -sf "$1" "/tmp/1/$(md5sum "$1" | awk '\''{print $1}'\'').vpk"' _ {} \;
else
  find "$1" -type f -name "*.vpk" -exec sh -c 'ln -sf "$1" "/tmp/1/$(md5sum "$1" | awk '\''{print $1}'\'').vpk"' _ {} \;
  find "$1" -type f -name "*.vpk" -exec sh -c 'ln -sf "$1" "/tmp/1/$(md5sum "$1" | awk '\''{print $1}'\'').vpk"' _ {} \;
fi
