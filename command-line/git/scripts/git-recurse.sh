#!/bin/bash
# usage : ./git-recurse.sh <command> [args...]

if [[ $# -lt 1 ]]; then
    echo "usage : $0 <command> [args...]"
    exit 1
fi


git_root=$(git rev-parse --show-toplevel)

cd "$git_root"

"$@" && git submodule foreach --recursive "$@"
