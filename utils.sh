#!/usr/bin/env bash

ENABLE_NOOP=${ENABLE_NOOP:-0}

# prints colored text
function print_stylen () {

    if [ "$2" == "info" ] ; then
        COLOR="96m";
    elif [ "$2" == "success" ] ; then
        COLOR="92m";
    elif [ "$2" == "warning" ] ; then
        COLOR="93m";
    elif [ "$2" == "danger" ] ; then
        COLOR="91m";
    else #default color
        COLOR="0m";
    fi

    STARTCOLOR="\e[$COLOR";
    ENDCOLOR="\e[0m";

    printf "$STARTCOLOR%b$ENDCOLOR\n" "$1";
}

function print_style () {

    if [ "$2" == "info" ] ; then
        COLOR="96m";
    elif [ "$2" == "success" ] ; then
        COLOR="92m";
    elif [ "$2" == "warning" ] ; then
        COLOR="93m";
    elif [ "$2" == "danger" ] ; then
        COLOR="91m";
    else #default color
        COLOR="0m";
    fi

    STARTCOLOR="\e[$COLOR";
    ENDCOLOR="\e[0m";

    printf "$STARTCOLOR%b$ENDCOLOR" "$1";
}


function noop () {
    if [ $ENABLE_NOOP -eq 1 ]; then
        local cmd="$@"
        print_stylen "'$cmd' SKIPPED" warning
    else
        $@
    fi
}


function install_with_brew() {
    export HOMEBREW_NO_INSTALL_UPGRADE=1
    noop brew install $1
}


function wrap_run() {
    local pre_msg=$1; shift
    if [ $ENABLE_NOOP -eq 1 ]; then
        local cmd="$@"
        print_style "$pre_msg" info
        print_stylen "'$cmd' SKIPPED" warning
    else
        print_style "$pre_msg" info
        $@
        print_passed_check
    fi
}


function print_check() {
    print_style "Checking if $1 is available..."
}

function print_failed_check() {
    print_stylen "❌"
}

function print_passed_check() {
    print_stylen "✅"
}

function wrap_install() {
    local prog=$1; shift
    wrap_run "Installing $prog..." $@
}

function execute_script() {
    curl -q -fsSL "$1" | bash
}
