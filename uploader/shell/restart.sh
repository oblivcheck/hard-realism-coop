#!/bin/bash

cd shell/rcon

MSG=""
if [[ $1 == "sv.sayuri.city" ]]; then
  # 先不管有人的*昵称*是这个怎么办
  info=$(./rcon -e r1 status)
  if ! echo "$info" | grep -q "players : 0 humans,"; then
    MSG="${MSG}#1失败 "
  else
    ./rcon -e r1 "sm__restart" > /dev/null
    MSG="${MSG}#1成功 "
  fi

  info=$(./rcon -e r2 status)
  if ! echo "$info" | grep -q "players : 0 humans,"; then
    MSG="${MSG}#2失败 "
  else
    ./rcon -e r2 "sm__restart" > /dev/null
    MSG="${MSG}#2成功 "
  fi

  info=$(./rcon -e r3 status)
  if ! echo "$info" | grep -q "players : 0 humans,"; then
    MSG="${MSG}#3失败 "
  else
    ./rcon -e r3 "sm__restart" > /dev/null
    MSG="${MSG}#3成功 "
  fi

  info=$(./rcon -e r4 status)
  if ! echo "$info" | grep -q "players : 0 humans,"; then
    MSG="${MSG}#4失败 "
  else
    ./rcon -e r4 "sm__restart" > /dev/null
    MSG="${MSG}#4成功 "
  fi
else
  info=$(./rcon -e r13 status)
  if ! echo "$info" | grep -q "players : 0 humans,"; then
    MSG="${MSG}#5失败 "
  else
    ./rcon -e r13 "sm__restart" > /dev/null
    MSG="${MSG}#5成功 "
  fi

  info=$(./rcon -e r14 status)
  if ! echo "$info" | grep -q "players : 0 humans,"; then
    MSG="${MSG}#6失败 "
  else
    ./rcon -e r14 "sm__restart" > /dev/null
    MSG="${MSG}#6成功 "
  fi
fi
echo -n $MSG
