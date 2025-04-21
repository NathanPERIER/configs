#!/bin/bash

usage() {
	echo "usage: $0 [<bash|fish|vim|git>...]"
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
do_fish=false
do_scripts=false
do_prompts=false
do_colours=false
do_vim=false
do_git=false
while [[ $# -gt 0 ]]; do
	case "$1" in
		bash) do_bash=true; do_scripts=true; do_colours=true; do_prompts=true;;
		fish) do_fish=true; do_scripts=true; do_colours=true;;
		git)  do_git=true;;
		vim)  do_vim=true;;
		*)    usage; exit 1;;
	esac
	shift
done


this_dir=$(dirname "$(realpath "$0")")

install_file() {
	# usage: install_file <source> <destination>
	echo "INSTALL $1 -> $2"
	if [[ -O "$1" ]]; then
		[[ -f "$2" ]] && rm "$2"
		ln "$1" "$2"
	else
		cp "$1" "$2"
	fi
}


if [[ "$do_bash" = true ]] || [[ "$do_all" = true ]]; then
	echo " ===== Bash =========================="

	bash_config_dir="${HOME}/.config/bash"
	[[ -d "$bash_config_dir" ]] || mkdir "$bash_config_dir"

	install_file "${this_dir}/shell/profile.sh" ~/.profile
	install_file "${this_dir}/shell/bash/bashrc.sh" ~/.bashrc
	install_file "${this_dir}/shell/bash/bash_variables.sh" "${bash_config_dir}/variables"
	install_file "${this_dir}/shell/bash/bash_aliases.sh" "${bash_config_dir}/aliases"
	install_file "${this_dir}/shell/bash/bash_prompt.sh" "${bash_config_dir}/prompt"
fi


if [[ "$do_fish" = true ]] || [[ "$do_all" = true ]]; then
	echo " ===== Fish =========================="

	fish_config_dir="${HOME}/.config/fish"
	fish_functions_dir="${fish_config_dir}/functions"
	mkdir -p "$fish_functions_dir"

	install_file "${this_dir}/shell/fish/config.fish" "${fish_config_dir}/config.fish"
	install_file "${this_dir}/shell/fish/variables.fish" "${fish_config_dir}/variables.fish"
	install_file "${this_dir}/shell/fish/aliases.fish" "${fish_config_dir}/aliases.fish"
	install_file "${this_dir}/shell/fish/functions/fish_prompt.fish" "${fish_functions_dir}/fish_prompt.fish"
	install_file "${this_dir}/shell/fish/functions/fish_greeting.fish" "${fish_functions_dir}/fish_greeting.fish"
fi


if [[ "$do_scripts" = true ]] || [[ "$do_all" = true ]]; then
	echo " ===== Scripts =========================="

	scripts_exec_dir="${HOME}/.local/bin"
	mkdir -p "$scripts_exec_dir"

	while IFS= read -r script_file; do
		filename="$(basename "$script_file")"
		filename="${filename%.*}"
		install_file "$script_file" "${scripts_exec_dir}/${filename}"
	done < <(find "${this_dir}/shell/scripts" -executable -type f)

fi


if [[ "$do_prompts" = true ]] || [[ "$do_all" = true ]]; then
	echo " ===== Prompts =========================="

	starship_conf_dir="${HOME}/.config/starship"
	mkdir -p "$starship_conf_dir"

	while IFS= read -r prompt_file; do
		filename="$(basename "$prompt_file")"
		install_file "$prompt_file" "${starship_conf_dir}/${filename}"
	done < <(find "${this_dir}/terminal/starship" -type f -name '*.toml')

fi


if [[ "$do_colours" = true ]] || [[ "$do_all" = true ]]; then
	echo " ===== Colours =========================="

	colours_script="${this_dir}/shell/colours/colour_variables.py"
	colours_conf_dir="${HOME}/.config/custom_colours"
	mkdir -p "$colours_conf_dir"

	generate_colour_profile() { # generate_colour_profile <classes> <colours> <out_file>
		echo "GENERATE ${3}.sh"
		"${colours_script}" bash "$1" "$2" > "${3}.sh"
		echo "GENERATE ${3}.fish"
		"${colours_script}" fish "$1" "$2" > "${3}.fish"
	}

	while IFS= read -r profile_dir; do
		profile_name="$(basename "$profile_dir")"
		classes_file="${profile_dir}/ls_classes.yaml"
		colours_file="${profile_dir}/colours.yaml"
		if [[ -f "$classes_file" ]] && [[ -f "$colours_file" ]]; then
			generate_colour_profile "$classes_file" "$colours_file" "${colours_conf_dir}/${profile_name}"
		fi
	done < <(find "${this_dir}/shell/colours" -type d)

fi


if [[ "$do_git" = true ]] || [[ "$do_all" = true ]]; then
	echo " ===== Git =========================="

	git_config_dir='.config/git'
	git_scripts_dir='.local/share/git'
	[[ -d ~/"$git_config_dir" ]] || mkdir ~/"$git_config_dir"
	mkdir -p ~/"$git_scripts_dir"

	git_config_file="${git_config_dir}/config"
	if ! git config --global --get-all include.path | grep '^'"~/$git_config_file"'$' > /dev/null; then
		git config --global --add include.path "~/$git_config_file"
	fi
	install_file "${this_dir}/command-line/git/config" ~/"$git_config_file"

	for file in "${this_dir}/command-line/git/scripts"/*.sh; do
		install_file "${file}" ~/"$git_scripts_dir/$(basename "$file")"
	done
fi


if [[ "$do_vim" = true ]] || [[ "$do_all" = true ]]; then
	echo " ===== Vim =========================="

	vim_config_dir="${HOME}/.vim"
	[[ -d "$vim_config_dir" ]] || mkdir "$vim_config_dir"

	install_file "${this_dir}/command-line/vim/vimrc" ~/.vimrc
	install_file "${this_dir}/command-line/vim/options.vim" "${vim_config_dir}/options.vim"
	install_file "${this_dir}/command-line/vim/commands.vim" "${vim_config_dir}/commands.vim"
	install_file "${this_dir}/command-line/vim/mappings.vim" "${vim_config_dir}/mappings.vim"
	install_file "${this_dir}/command-line/vim/filetypes.vim" "${vim_config_dir}/filetypes.vim"
fi


