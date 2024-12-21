#!/bin/sh

wm_choice=${1:-1}

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

  xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

  xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

if xrandr --query | grep "HDMI-1-0 connected"; then
  xrandr --output eDP1 --rate 144 --mode 1920x1080 --pos 0x1080 --rotate normal --output DP2 --off --output HDMI2 --off --output VIRTUAL1 --off --output HDMI-1-0 --primary --rate 144 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-0 --off --output DP-1-1 --off
else
  xrandr --output HDMI-0 --off --output DP-0 --off --output DP-1 --off --output eDP-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-2 --off --output HDMI-1-2 --off
fi

xset s off

case $wm_choice in
1)
  exec i3
  ;;
2)
  exec awesome
  ;;
*)
  echo "Unknown window manager: $wm_choice"
  exec i3
  ;;
esac
