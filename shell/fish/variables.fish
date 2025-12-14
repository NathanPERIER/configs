#!/usr/bin/fish

if printenv | grep '^WSL_DISTRO_NAME=' > /dev/null
	set -x MACHINE_TYPE 'wsl'
else if test "$XDG_SESSION_TYPE" = 'tty'
	set -x MACHINE_TYPE 'server'
else if test -n "$XDG_SESSION_TYPE" || test -n "$XDG_CURRENT_DESKTOP" || command -v xdg-desktop-menu > /dev/null
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
else if printenv | grep '^TERM_PROGRAM=tmux$' > /dev/null
	set -x TERMINAL_TYPE 'tmux'
else if printenv | grep '^TERM=screen$' > /dev/null
	set -x TERMINAL_TYPE 'tmux'
else if printenv | grep '^TERM=xterm' > /dev/null
	set -x TERMINAL_TYPE 'xterm'
else if printenv | grep '^TERM=rxvt' > /dev/null
	set -x TERMINAL_TYPE 'xterm'
else
	set -x TERMINAL_TYPE 'other'
end


set custom_colour_profile default

switch $TERM
	case 'xterm-color' '*-256color'
		set colour_support yes
	case '*'
		set colour_support no
end


if test "$TERMINAL_TYPE" = 'tmux'
    # Since we can't get any real information inside tmux,
    # we assume colour is supported unless we are in the console of a server without ↪\SSH
    if test "$MACHINE_TYPE" = 'desktop' || test -n "$SSH_CONNECTION"
        set colour_support yes
    else
        set colour_support no
    end
end

