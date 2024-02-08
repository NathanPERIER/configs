#!/usr/bin/fish

if printenv | grep '^WSL_DISTRO_NAME=' > /dev/null
	set -x MACHINE_TYPE 'wsl'
else if which dpkg > /dev/null && dpkg -s xserver-xorg 2>&1 | grep '^Status:.* installed' > /dev/null
	set -x MACHINE_TYPE 'desktop'
else
	set -x MACHINE_TYPE 'server'
end


if printenv | grep '^GNOME_TERMINAL_SCREEN=' > /dev/null
	set -x TERMINAL_TYPE 'gnome'
else if printenv | grep '^WT_SESSION=' > /dev/null
	set -x TERMINAL_TYPE 'windows'
else if printenv | grep '^TERM_PROGRAM=vscode$' > /dev/null
	set -x TERMINAL_TYPE 'vscode'
else if printenv | grep '^TERM=xterm' > /dev/null
	set -x TERMINAL_TYPE 'xterm'
else
	set -x TERMINAL_TYPE 'other'
end


switch $TERM
	case 'xterm-color' '*-256color'
		set colour_support yes
	case '*'
		set colour_support no
end


