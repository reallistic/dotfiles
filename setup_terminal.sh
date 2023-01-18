#!/usr/bin/env bash -e

source utils.sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

WORKSPACE_DIR="${WORKSPACE_DIR:-$HOME/workspace}":
WORK_DIR_NAME="${WORK_DIR_NAME:-ntflx}"
PERSONAL_DIR_NAME="${PERSONAL_DIR_NAME:-personal}"

## trim trailing slashes
WORK_DIR_NAME=$(echo "$WORK_DIR_NAME" | sed 's:/*$::')
PERSONAL_DIR_NAME=$(echo "$PERSONAL_DIR_NAME" | sed 's:/*$::')
WORKSPACE_DIR=$(echo "$WORKSPACE_DIR" | sed 's:/*$::')

# combine vars
WORK_DIR="$WORKSPACE_DIR/WORK_DIR_NAME"
PERSONAL_DIR="$WORKSPACE_DIR/PERSONAL_DIR_NAME"

function add_symlink () {
    local force=0
    if [ "$1" == "force" ]; then
        force=1
        shift
    fi
    if [[ -f $2 && "$force" == "0" ]]; then
        print_stylen "file exists at $2. Not overwriting" danger
        return
    elif [[ -f $2 ]]; then
        print_style "renaming existing file at $2 and overwriting" warning
        mv $2 "$2.bak"
    fi
    ln -s $1 $2
}


function add_home_rc () {
    print_style "Installing $1.." info
    add_symlink "${SCRIPT_DIR}/HOME/${1}" "${HOME}/${1}"
    print_stylen "done" success
}

HOME_FILES="HOME/.*"

for f in $HOME_FILES
do
    add_home_rc $f
done
