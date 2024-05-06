#!/usr/bin/fish

# colour various commands by default
if test "$colour_support" = yes
    # enable color support of ls
    # if test -x /usr/bin/dircolors
    # 	test -r ~/.dircolors && eval (dircolors -b ~/.dircolors) || eval (dircolors -b)
    # 	alias ls='ls --color=auto'
	# end

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

	alias ip='ip --color=auto'
end


# ls aliases
alias l='ls -CF'
alias ll='ls -l'
alias lli='ls -li'
alias lla='ls -lA'

# clear the "$status" value
alias ok=':'
alias mb=':'

# quickly clear the terminal
alias xx='clear'

# erase a variable
alias unset='set --erase'

# force python to version 3 by default
alias python='python3'
alias pip='pip3'

# you do not want to ask
alias eclp='rm -f ~/.eclipse_history; rlwrap eclipse'

# by the way, I use vim
alias ed='vim'
alias nano='vim'
alias emacs='vim'

# quick edit and reload of the .bashrc
alias eb='vim ~/.config/fish/config.fish'
alias ebv='vim ~/.config/fish/variables.fish'
alias ebl='vim ~/.config/fish/local.fish'
alias eba='vim ~/.config/fish/aliases.fish'
alias ebp='vim ~/.config/fish/functions/fish_prompt.fish'
alias sb='. ~/.config/fish/config.fish'

# edit or ls
function led
	if test (count $argv) -ne 1 || test $argv[1] = '-h'
		echo 'usage: led <file>'
		if test (count $argv) -ne 1
			return 1
		else 
			return 0
		end
	end
	set file $argv[1]
	if test ! -e $file
		set parent_dir (dirname $file)
		if test ! -d $parent_dir
			echo 'path to file does not exist'
			return 1
		end
		echo 'file does not exist, creating'
		ed $file
	else if test -d $file
		ll $file
	else if test -f $file
		test -w $file && ed $file || less $file
	else
		echo "that's a weird file you got there, mate"
		return 1
	end
end

# mkdir and cd
function mkd
	mkdir $argv
	if test $status -ne 0
		return $status
	end
	if test $argv[1] = '-p'
		unset $argv[1]
	end
	cd $argv[1]
end

# remove current directory and go back to parent
function rmd
	set old_workdir "$OLDPWD"
	set dirname (basename "$PWD")
	cd ..
	rmdir $dirname
	set res $status
	if test $res -ne 0
		cd "$OLDPWD"
	end
	set -x OLDPWD $old_workdir
	return $res
end

# word-level diff
alias wdiff='git diff -U0 --word-diff --no-index --'

# get public ip
alias ipinfo='curl ipinfo.io/ip'

# download musics
if which yt-dlp > /dev/null
	alias music-dl='yt-dlp --extract-audio --audio-format mp3 --embed-thumbnail'
end

# quick compression and decompression
alias mktgz='tar -czvf'
alias untgz='tar -xvf'

# ls in a .tar (or .tar.sth)
alias lstar='tar -tvf'

# quick find by name (in the current directory)
alias f='find . -name'

# quick find by content and by name
function ff
	if test (count $argv) -eq 0 || test (count $argv) -gt 2 || test $argv[1] = '-h'
		echo 'usage: ff <pattern> [filename_pattern]'
		if test (count $argv) -eq 0 || test (count $argv) -gt 2
			return 1
		else
			return 0
		end
	end
	set pattern $argv[1]
	unset $argv[1]
	if test (count $argv) -ge 1
		set name_args '-name' $argv[1]
	else
		set name_args
	end
	find . -type f $name_args -print0 | xargs -0 grep -l $pattern
	return $status
end

# command to check the syslog quickly
for file in '/var/log/syslog' '/var/log/messages'
    if test -f "$file"
        set maybe_sudo ''
        if test ! -r "$file"
            set maybe_sudo 'sudo '
        end
        alias syslog="$maybe_sudo""tail -f $file"
		unset maybe_sudo
        break
    end
end

# open a new terminal or a file explorer (native desktop only)
if test "$MACHINE_TYPE" = 'desktop'
	alias here='gnome-terminal'
	alias xo='xdg-open'
end

# for when the compilation takes way too much time
alias mk="make -j (nproc)"

# for when even Ctrl+C won't end a program
alias solong='pkill -9'

# for when I try to quit the terminal like it's a vim editor
alias q='exit'
alias wq='exit'

# quick computer shutdown
if test "$MACHINE_TYPE" = 'desktop'
	alias dodo='shutdown +0'
end
