#!/bin/bash


auto_newline() {
    IFS='[;' read -p $'\e[6n' -d R -rs _ y x _
    if [ $x -ne 1 ]; then echo '↩'; fi;
}


if [[ -z "$user_colour_code" ]]; then
	if [[ "$USER" = 'root' ]]; then
		user_colour_code='35' # magenta
	else
		user_colour_code='32' # green
	fi
fi

if [[ -z "$path_colour_code" ]]; then
	path_colour_code='34' # blue
fi


if [[ -z "$prompt_style" ]]; then
	prompt_style='default'
fi

if [[ -z "$colour_prompt_style" ]]; then
	colour_prompt_style="$prompt_style"
fi


prompt_user='\u'
if [[ -n "$prompt_detect_sudo" ]]; then
	if [[ "$prompt_detect_sudo" = 'true' ]] && [[ -n "$SUDO_USER" ]]; then
		prompt_user="($SUDO_USER as \u)"
	fi
	unset prompt_detect_sudo
fi

prompt_path='\w'
if [[ -n "$prompt_shorten_path" ]]; then
	if [[ "$prompt_shorten_path" = 'true' ]] && command -v pwd-short > /dev/null; then
		prompt_path='$(pwd-short)'
	fi
	unset prompt_shorten_path
fi

if [[ -n "$starship_theme" ]] && command -v starship 1>&2 > /dev/null; then
	starship_conf_dir="$HOME/.config/starship"
	if [[ "$starship_theme" = 'local' ]]; then
		: # previously set in `.bash_local` and must not be changed
	elif [[ -f "${HOME}/.config/starship/${starship_theme}.toml" ]]; then
		export STARSHIP_CONFIG="${HOME}/.config/starship/${starship_theme}.toml"
	else
		unset STARSHIP_CONFIG
	fi
	eval "$(starship init bash)"
elif [[ "$colour_support" = yes ]]; then
	if [[ "$colour_prompt_style" = 'local' ]]; then
		: # previously set in `.bash_local` and must not be changed
	elif [[ "$colour_prompt_style" = 'multiline' ]]; then
		PS1='$(e="$?"; [ "$e" != 0 ] && err="\[\033[0;31m\](\[\033[01;31m\]${e}\[\033[0;31m\])\[\033[0m\] "; auto_newline; date +"╭── [%H:%M:%S] ${err}\[\033['"01;${path_colour_code}m\]${prompt_path}"'\[\033[00m\]\n╰─ ")\[\033['"01;${user_colour_code}m\\]${prompt_user}"'\[\033['"0;${user_colour_code}m"'\]@\[\033['"01;${user_colour_code}m"'\]\h\[\033[00m\]\$ '
	elif [[ "$colour_prompt_style" = 'owo' ]]; then
		PS1='$(if [ $? = 0 ]; then auto_newline; echo '"'[\\[\033[01;32m\]OwO\[\033[0m\\]'; else auto_newline; echo '[\[\033[01;31m\]╹∧╹\[\e[0m\]'; fi)] \[\033[01;${user_colour_code}m\]${prompt_user}@\h\[\033[00m\]:\[\033[01;${path_colour_code}m\]${prompt_path}\[\033[00m\]\$ "
	elif [[ "$colour_prompt_style" = 'basic' ]]; then
		PS1="${debian_chroot:+($debian_chroot)}"'\[\033['"01;${user_colour_code}m"'\]\u@\h\[\033[00m\]:\[\033['"01;${path_colour_code}m\]\w"'\[\033[00m\]\$ '
	else # default
		PS1="${debian_chroot:+($debian_chroot)}"'\[\033['"01;${user_colour_code}m"'\]'"${prompt_user}"'\[\033['"00;${user_colour_code}m"'\]@\[\033['"01;${user_colour_code}m"'\]\h\[\033[00m\]:\[\033['"01;${path_colour_code}m\]${prompt_path}"'\[\033[00m\]\$ '
	fi
else
	if [[ "$prompt_style" = 'local' ]]; then
		:
	elif [[ "$prompt_style" = 'basic' ]]; then
		PS1="${debian_chroot:+($debian_chroot)}"'\u@\h:\w\$ '
	else # default
		PS1="${debian_chroot:+($debian_chroot)}${prompt_user}"'@\h:'"$prompt_path"'\$ '
	fi
fi

# cleanup utilitary variables
unset starship_theme
unset colour_prompt_style
unset prompt_style
unset user_colour_code
unset path_colour_code
unset prompt_user
unset prompt_path



# If this is an xterm set the title to user@host:dir
if [[ "$TERMINAL_TYPE" = 'xterm' ]]; then
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
fi

