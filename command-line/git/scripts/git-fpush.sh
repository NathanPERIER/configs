#!/bin/bash
# usage : ./git-fpush.sh

current_branch=$(git branch --show-current)
if [[ -z "$current_branch" ]]; then
    current_commit=$(git rev-parse --short HEAD)
    echo "Currently in detached HEAD state on commit $current_commit"
    exit 1
fi
echo "You are currently on branch $current_branch"


read -p "Do you really want to force an update on the origin ? (n/Y) " yn
if [[ "$yn" = 'Y' ]]; then 
    git push -f "$@"
    exit $?
else
    echo 'Canceled'
fi
