#
# ~/.zprofile
#

if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
    exec startx
fi

[[ -f ~/.zshrc ]] && . ~/.zshrc
