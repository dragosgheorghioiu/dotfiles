
if [ -z "$TMUX" ] && [ "$(tty)" = "/dev/tty1" ] && ! pgrep -x sway > /dev/null; then
    export XDG_SESSION_TYPE=wayland
    export MOZ_ENABLE_WAYLAND=1
    export WLR_RENDERER=vulkan

    exec sway
    # startx
fi

