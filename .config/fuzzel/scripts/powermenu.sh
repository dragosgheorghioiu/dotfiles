#!/bin/bash

options="Power Off\nReboot"

choice=$(echo -e "$options" | fuzzel -l 2 --dmenu)

case "$choice" in
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

