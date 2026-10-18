#!/bin/bash

options="Sleep\nPower Off\nReboot"

choice=$(echo -e "$options" | fuzzel -l 3 --dmenu)

case "$choice" in
    "Sleep")
        swaylock -f -c 000000 & disown
        sleep 0.5
        systemctl suspend
        ;;
    "Power Off")
        poweroff
        ;;
    "Reboot")
        reboot
        ;;
    *)
        echo "No valid option selected."
        ;;
esac

