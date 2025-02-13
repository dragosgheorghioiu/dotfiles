#!/usr/bin/bash

function run {
    if ! pgrep "$1" ; then
        $@&
    fi
}

prev_AWSM_MONITORS=$AWSM_MONITORS

if xrandr --query | grep "HDMI-A-0 connected"; then
  export AWSM_MONITORS=2
  if [ "$prev_AWSM_MONITORS" != "$AWSM_MONITORS" ]; then
    xrandr --output eDP --rate 120 --mode 2880x1800 --pos 3840x360 --rotate normal --output DP2 --off --output HDMI2 --off --output VIRTUAL1 --off --output HDMI-A-0 --primary --rate 120 --mode 1920x1080 --pos 0x0 --scale 2x2 --rotate normal --output DP-1-0 --off --output DP-1-1 --off
  fi
else
  export AWSM_MONITORS=1
  if [ "$prev_AWSM_MONITORS" != "$AWSM_MONITORS" ]; then
    xrandr --output eDP --primary --mode 2880x1800 --rate 120 --pos 0x0 --rotate normal --output HDMI-A-0 --off
  fi
fi

pkill picom; picom -b
run xclip
run redshift -l 44.25:26.6 -m randr -v
