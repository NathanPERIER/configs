#!/bin/bash

# colour various commands by default
if [ "$colour_support" = yes ]; then
	# Apply custom colours
	if [[ -n "$custom_colour_profile" ]]; then
		colours_dir="${HOME}/.config/custom_colours"
		profile_dir="${colours_dir}/profiles/${custom_colour_profile}"
		# echo "profile_dir=${profile_dir}"
		if [[ -d "$profile_dir" ]] && [[ -e "${colours_dir}/colour_variables.py" ]]; then
			eval "$("${colours_dir}/colour_variables.py" "${profile_dir}/ls_classes.yaml" "${profile_dir}/colours.yaml")"
		fi
		if [[ "$ls_colors_ok" = 'true' ]]; then
			export LS_COLORS
		fi
		if [[ "$gcc_colors_ok" = 'true' ]]; then
			export GCC_COLORS
		fi
		unset gcc_colors_ok
		unset profile_dir
		unset colours_dir
		unset custom_colour_profile
	fi

	if [[ "$ls_colors_ok" != 'true' ]] && which dircolors 2>&1 > /dev/null; then
    	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	fi
	unset ls_colors_ok

	alias ls='ls --color=auto'

	alias diff='diff --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

	alias ip='ip --color=auto'
fi


# ls aliases
alias l='ls -CF'
alias ll='ls -l'
alias lli='ls -li'
alias lla='ls -lA'

# clear the "$?" value
alias ok=':'
alias mb=':'

# quickly clear the terminal
alias xx='clear'

# force python to version 3 by default
alias python='python3'
alias pip='pip3'

# call to pip in venv
alias vpip='vpython -m pip'

# you do not want to ask
alias eclp='rm -f ~/.eclipse_history; rlwrap eclipse'

# by the way, I use vim
alias ed='vim'
alias nano='vim'
alias emacs='vim'

# quick edit and reload of the .bashrc
alias eb='vim ~/.bashrc'
alias ebv='vim ~/.config/bash/variables'
alias ebl='vim ~/.bash_local'
alias eba='vim ~/.config/bash/aliases'
alias ebp='vim ~/.config/bash/prompt'
alias sb='. ~/.bashrc'

# edit or ls
function led {
	if [[ $# -ne 1 ]] || [[ "$1" = '-h' ]]; then
		echo 'usage: led <file>'
		if [[ $# -ne 1 ]]; then 
			return 1
		else 
			return 0
		fi
	fi
	file="$1"
	if [[ ! -e "$file" ]]; then
		parent_dir=$(dirname "$file")
		if [[ ! -d "$parent_dir" ]]; then
			echo 'path to file does not exist'
			return 1
		fi
		echo 'file does not exist, creating'
		ed "$file"
	elif [[ -d "$file" ]]; then
		ll "$file"
	elif [[ -f "$file" ]]; then
		[[ -w "$file" ]] && ed "$file" || less "$file"
	else
		echo "that's a weird file you got there, mate"
		return 1
	fi
}

# mkdir and cd
function mkd {
	mkdir "$@"
	if [[ $? -ne 0 ]]; then
		return $?
	fi
	if [[ "$1" = '-p' ]]; then
		shift
	fi
	cd "$1"
}

# remove current directory and go back to parent
function rmd {
	old_workdir="$OLDPWD"
	dirname=$(basename "$PWD")
	cd ..
	rmdir "$dirname"
	res=$?
	if [[ $res -ne 0 ]]; then
		cd "$OLDPWD"
	fi
	export OLDPWD="$old_workdir"
	return $res
}

# word-level diff
alias wdiff='git diff -U0 --word-diff --no-index --'

# get public ip
alias ipinfo='curl ipinfo.io/ip'

# download musics
if which yt-dlp > /dev/null 2>&1; then
	alias music-dl='yt-dlp --extract-audio --audio-format mp3 --embed-thumbnail'
fi

# quick compression and decompression
alias mktgz='tar -czvf'
alias untgz='tar -xvf'

# ls in a .tar (or .tar.sth)
alias lstar='tar -tvf'

# quick find by name (in the current directory)
alias f='find . -name'

# quick find by content and by name
function ff {
	if [[ $# -eq 0 ]] || [[ $# -gt 2 ]] || [[ "$1" = '-h' ]]; then
		echo 'usage: ff <pattern> [filename_pattern]'
		if [[ $# -eq 0 ]] || [[ $# -gt 2 ]]; then
			return 1
		else
			return 0
		fi
	fi 
	pattern="$1"
	shift
	if [[ $# -ge 1 ]]; then
		name_args=('-name' "$1")
	else
		name_args=()
	fi
	find . -type f "${name_args[@]}" -print0 | xargs -0 grep -l "$pattern"
	return $?
}

# removes or adds an extension to a file (typically .tmp, .bak, ...)
function mext {
    if [[ $# -ne 2 ]]; then
        echo 'usage: mext <file> <extension>'
        return 1
    fi
    if [[ "$1" == *"$2" ]]; then
        with_ext="$1"
        ext_begin=$((${#with_ext}-${#2}-1))
        without_ext="${1:0:ext_begin}"
    else
        without_ext="$1"
        with_ext="${without_ext}.$2"
    fi
    if [[ -f "$with_ext" ]]; then
        if [[ -f "$without_ext" ]]; then
            timestamp=$(date +%s%3N)
            temp_file=".${without_ext}.$$.${timstamp}.tmp"
            mv "$without_ext" "$temp_file"
            mv "$with_ext" "$without_ext"
            mv "$temp_file" "$with_ext"
            echo "$without_ext <-> $with_ext"
        else
            mv "$with_ext" "$without_ext"
            echo "$with_ext -> $without_ext"
        fi
        return 0
    fi
    if [[ -f "$without_ext" ]]; then
        mv "$without_ext" "$with_ext"
        echo "$without_ext -> $with_ext"
        return 0
    fi
    echo "file doesn't exist: $1"
    return 1
}

# command to check the syslog quickly
for file in '/var/log/syslog' '/var/log/messages'
do
    if [[ -f "$file" ]]; then
        maybe_sudo=''
        if [[ ! -r "$file" ]]; then
            maybe_sudo='sudo '
        fi
        alias syslog="${maybe_sudo}tail -f ${file}"
		unset maybe_sudo
        break
    fi
done

# get details on a given command
function what {
	if [[ $# -ne 1 ]]; then
		echo "usage: what <command>"
		return 1
	fi
	if [[ "$1" = '-h' ]] || [[ "$1" = '--help' ]]; then
		echo "usage: what <command>"
		return 0
	fi
	command_name="$1"
	cmd_type="$(type -t "$command_name")" || return 1
	case "$cmd_type" in
		'file')
			filepath="$(which "$command_name" 2> /dev/null)" || return 1
			ll "$filepath" || return 1;;
		'alias')    alias "$command_name" || return 1;;
		'function') declare -f "$command_name" || return 1;;
		'keyword')  echo "shell keyword";;
		'builtin')  echo "shell builtin";;
		*)          return 1;;
	esac
}

# open a new terminal or a file explorer (native desktop only)
if [[ "$MACHINE_TYPE" = 'desktop' ]]; then
	alias here='gnome-terminal'
	alias xo='xdg-open'
fi

# for when the compilation takes way too much time
alias mk="make -j $(nproc)"
alias nj="ninja -j $(nproc)"

# quick Meson update
if which meson > /dev/null 2>&1; then
    alias msup='meson subprojects update'
fi

# for when even Ctrl+C won't end a program
alias solong='pkill -9'

# for when I try to quit the terminal like it's a vim editor
alias q='exit'
alias wq='exit'

# quick computer shutdown
if [[ "$MACHINE_TYPE" = 'desktop' ]]; then
	alias dodo='shutdown +0'
fi
