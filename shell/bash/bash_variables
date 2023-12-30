#!/bin/bash

if printenv | grep '^WSL_DISTRO_NAME=' > /dev/null; then
	export MACHINE_TYPE='wsl'
elif dpkg -s xserver-xorg | grep '^Status' | grep installed > /dev/null; then
	export MACHINE_TYPE='desktop'
else
	export MACHINE_TYPE='server'
fi


if printenv | grep '^GNOME_TERMINAL_SCREEN=' > /dev/null; then
	export TERMINAL_TYPE='gnome'
elif printenv | grep '^WT_SESSION=' > /dev/null; then
	export TERMINAL_TYPE='windows'
elif printenv | grep '^TERM_PROGRAM=vscode$' > /dev/null; then
	export TERMINAL_TYPE='vscode'
elif printenv | grep '^TERM=xterm' > /dev/null; then
	export TERMINAL_TYPE='xterm'
else
	export TERMINAL_TYPE='other'
fi



# set variable identifying the chroot you work in
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

colour_support=no
case "$TERM" in
    xterm-color|*-256color) colour_support=yes;;
esac

terminal_is_xterm=no
case "$TERM" in
	xterm*|rxvt*) terminal_is_xterm=yes;;
esac



# coloured GCC warnings and errors
# if [ "$colour_support" = yes ]; then
#      export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# fi

