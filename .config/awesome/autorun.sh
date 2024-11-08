#!/usr/bin/bash

function run {
    if ! pgrep "$1" ; then
        $@&
    fi
}


run picom
run nm-applet
run flameshot
run syncthing
run xclip
run emacs --daemon
