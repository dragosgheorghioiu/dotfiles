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

if xrandr --query | grep "HDMI-A-0 connected"; then
  export AWSM_MONITORS=2
  xrandr --output eDP --rate 120 --mode 2880x1800 --pos 3840x360 --rotate normal --output DP2 --off --output HDMI2 --off --output VIRTUAL1 --off --output HDMI-A-0 --primary --rate 120 --mode 1920x1080 --pos 0x0 --scale 2x2 --rotate normal --output DP-1-0 --off --output DP-1-1 --off
else
  export AWSM_MONITORS=1
  xrandr --output eDP --primary --mode 2880x1800 --rate 120 --pos 0x0 --rotate normal --output HDMI-A-0 --off
fi

xset s off
xset r rate 200 50
exec awesome

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
