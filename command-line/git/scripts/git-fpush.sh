#!/bin/bash
# usage : ./git-fpush.sh

current_branch=$(git branch --show-current)
echo "You are currently on branch $current_branch"


read -p "Do you really want to force an update on the origin ? (n/Y) " yn
if [[ "yn" = 'Y' ]]; then 
    git push -f \"$@\"
    exit $?
else
    echo 'Canceled'
fi
