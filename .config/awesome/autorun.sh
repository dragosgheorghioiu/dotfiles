#!/usr/bin/bash

function run {
    if ! pgrep $1 ; then
        $@&
    fi
}

if xrandr --query | grep "HDMI-0 connected"; then
	run ~/.screenlayout/default.sh
else
	run ~/.screenlayout/onlyinternal.sh
fi

run picom
run nm-applet
run flameshot
