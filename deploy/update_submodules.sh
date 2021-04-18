#!/bin/sh

set -e

git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
    while read path_key path
    do
        url_key=$(echo $path_key | sed 's/\.path/.url/')
        branch_key=$(echo $path_key | sed 's/\.path/.branch/')
        branch=""
        if [ "$(git config -f .gitmodules --get "$branch_key")" ]; then
            branch=$(echo -b "$(git config -f .gitmodules --get "$branch_key")" | tr -d '\n')
        fi
        url=$(git config -f .gitmodules --get "$url_key")
        rm -rf "$path"
        git submodule add $branch "$url" "$path"
    done