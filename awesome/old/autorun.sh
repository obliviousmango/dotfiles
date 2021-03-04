#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#run /usr/lib/xfce-polkit/xfce-polkit
run nitrogen --restore
run xfce4-power-manager
run nm-applet
run picom 
run unclutter --timeout 2
#run copyq
run redshift
run pa-applet --disable-notifications
#run syndaemon -i 1.0 -K -d
