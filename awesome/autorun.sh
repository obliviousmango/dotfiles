#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#run syndaemon -i 1.0 -K -d
run /usr/libexec/polkit-gnome-authentication-agent-1
run nitrogen --restore
#run xfce4-power-manager
run mate-power-manager
run nm-applet
setxkbmap eu
run mpd
run picom 
run unclutter --timeout 2
run xset r rate 200 30
#run setxkbmap -option caps:escape
run redshift
run greenclip daemon
run pa-applet --disable-notifications
run xss-lock -- betterlockscreen -l
#run kdeconnect-indicator
run /usr/lib/kdeconnectd
run blueman-applet
