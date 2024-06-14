#!/bin/bash

if printenv | grep '^WSL_DISTRO_NAME=' > /dev/null; then
	export MACHINE_TYPE='wsl'
elif which dpkg > /dev/null 2>&1 && dpkg -s xserver-xorg 2>&1 | grep '^Status:.* installed' > /dev/null; then
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
elif printenv | grep '^TERM_PROGRAM=tmux$' > /dev/null; then
	export TERMINAL_TYPE='tmux'
elif printenv | grep '^TERM=xterm' > /dev/null; then
	export TERMINAL_TYPE='xterm'
elif printenv | grep '^TERM=rxvt' > /dev/null; then
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



# coloured GCC warnings and errors
# if [ "$colour_support" = yes ]; then
#      export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# fi

