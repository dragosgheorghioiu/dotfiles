#!/bin/bash

options="Screenshot\nScreenshot to Clipboard\nScreenshot All Windows"

choice=$(echo -e "$options" | fuzzel -l 3 --dmenu --prompt="Select Screenshot Option: ")

case "$choice" in
    "Screenshot")
        grim -g "$(slurp)"
        thunar ~/Pictures
        ;;
    "Screenshot to Clipboard")
        grim -g "$(slurp)" - | wl-copy
        ;;
    "Screenshot All Windows")
        grim
        thunar ~/Pictures
        ;;
    *)
        echo "No valid option selected."
        ;;
esac

