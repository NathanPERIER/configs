#!/bin/bash

usage() {
	echo "usage: $0 [<bash|vim|git>...]"
}


if [[ $# -gt 0 ]] && [[ "$1" = '-h' ]]; then
	usage
	exit 0
fi


do_all=false
if [[ $# -eq 0 ]]; then
	do_all=true
fi


do_bash=false
do_vim=false
do_git=false
while [[ $# -gt 0 ]]; do
	case "$1" in
		bash) do_bash=true;;
		git)  do_git=true;;
		vim)  do_vim=true;;
		*)    usage; exit 1;;
	esac
	shift
done


this_dir=$(dirname "$(realpath "$0")")

install_file() {
	# usage: install_file <source> <destination>
	if [[ -O "$1" ]]; then
		[[ -f "$2" ]] && rm "$2"
		ln "$1" "$2"
	else
		cp "$1" "$2"
	fi
}


# custom directories
if [[ "$do_bash" = true ]] || [[ "$do_all" = true ]]; then
	bash_config_dir="${HOME}/.config/bash"
	[[ -d "$bash_config_dir" ]] || mkdir "$bash_config_dir"

	install_file "${this_dir}/shell/profile.sh" ~/.profile
	install_file "${this_dir}/shell/bash/bashrc.sh" ~/.bashrc
	install_file "${this_dir}/shell/bash/bash_variables.sh" "${bash_config_dir}/variables"
	install_file "${this_dir}/shell/bash/bash_aliases.sh" "${bash_config_dir}/aliases"
	install_file "${this_dir}/shell/bash/bash_prompt.sh" "${bash_config_dir}/prompt"
fi


if [[ "$do_git" = true ]] || [[ "$do_all" = true ]]; then
	git_config_dir=".config/git"
	[[ -d ~/"$git_config_dir" ]] || mkdir ~/"$git_config_dir"
	
	git_config_file="${git_config_dir}/config"
	install_file "${this_dir}/command-line/git/config" ~/"$git_config_file"

	if ! git config --global --get-all include.path | grep '^'"~/$git_config_file"'$' > /dev/null; then
		git config --global --add include.path "~/$git_config_file"
	fi
fi


if [[ "$do_vim" = true ]] || [[ "$do_all" = true ]]; then
	install_file "${this_dir}/command-line/vim/vimrc" ~/.vimrc
fi


