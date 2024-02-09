#!/bin/bash
# usage : ./git-fpull.sh

current_branch=$(git branch --show-current)
if [[ -z "$current_branch" ]]; then
    current_commit=$(git rev-parse --short HEAD)
    echo "Currently in detached HEAD state on commit $current_commit"
    exit 1
fi

remote_branch=$(git status -sb | head -n 1 | sed -r 's/##\s.*\.\.\.(.*)/\1/')
if [[ "$remote_branch" = '##'* ]]; then
    echo "Currently on branch $current_branch with no upstream"
    exit 1
fi

echo "You are currently on branch $current_branch tracking $remote_branch"


read -p "Do you really want to erase all local changes and reset the history to match the remote history ? (n/Y) " yn
if [[ "$yn" = 'Y' ]]; then 
    git reset --hard "$remote_branch" && git pull
    exit $?
else
    echo 'Canceled'
fi
