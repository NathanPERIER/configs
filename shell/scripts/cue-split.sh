#!/bin/bash

function help {
	echo "$0 <music_file> [cue_file]"
}

if [[ $# -lt 1 ]]; then
	help
	exit 1
fi

if [[ "$1" = '-h' ]] || [[ "$1" = '--help' ]]; then
	help
	exit 0
fi

music_file="$1"
shift

if [[ ! -f "$music_file" ]]; then
	echo "File does no exist: $music_file"
	exit 1
fi

extension="${music_file##*.}"
extract_folder="${music_file%.*}"

if [[ "$extension" != 'flac' ]]; then
	echo "Warning: support for anyhting else than flac is experimental"
fi

if [[ -e "$extract_folder" ]]; then
	echo "Folder '${extract_folder}' already exists"
	exit 1
fi

if [[ $# -ge 1 ]]; then
	cue_file="$1"
	shift
else
	cue_file="${extract_folder}.cue"
fi

if [[ ! -f "$cue_file" ]]; then
	echo "File does no exist: $cue_file"
	exit 1
fi

if [[ $# -ge 1 ]]; then
	help
	exit 1
fi


mkdir "${extract_folder}"

shnsplit -f "$cue_file" -t '%n-%t' -o "$extension" -d "$extract_folder" "$music_file" || exit 1

cuetag "$cue_file" "$extract_folder"/*."$extension" || exit 1

