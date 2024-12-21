#!/bin/bash

for monitor in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  MONITOR="$monitor" polybar &
done
