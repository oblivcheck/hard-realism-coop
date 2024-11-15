#!/bin/bash
if [[ $2 == "sv.sayuri.city" ]]; then
  find "$1" -type f -name "*.vpk" -exec sh -c 'ln -sf "$0" "/home/steam/Steam/l4d2_r1/left4dead2/addons/$(md5sum "$0" | awk '\''{print $1}'\'').vpk"' {} \;
  find "$1" -type f -name "*.vpk" -exec sh -c 'ln -sf "$0" "/home/steam/Steam/l4d2_r2/left4dead2/addons/$(md5sum "$0" | awk '\''{print $1}'\'').vpk"' {} \;
  find "$1" -type f -name "*.vpk" -exec sh -c 'ln -sf "$0" "/home/steam/Steam/l4d2_r3/left4dead2/addons/$(md5sum "$0" | awk '\''{print $1}'\'').vpk"' {} \;
  find "$1" -type f -name "*.vpk" -exec sh -c 'ln -sf "$0" "/home/steam/Steam/l4d2_r4/left4dead2/addons/$(md5sum "$0" | awk '\''{print $1}'\'').vpk"' {} \;
else
  find "$1" -type f -name "*.vpk" -exec sh -c 'ln -sf "$0" "/home/steam/Steam/l4d2_r13/left4dead2/addons/$(md5sum "$0" | awk '\''{print $1}'\'').vpk"' {} \;
  find "$1" -type f -name "*.vpk" -exec sh -c 'ln -sf "$0" "/home/steam/Steam/l4d2_r14/left4dead2/addons/$(md5sum "$0" | awk '\''{print $1}'\'').vpk"' {} \;
fi
