#!/bin/bash 

# prints colored text
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

    printf "$STARTCOLOR%b$ENDCOLOR\n" "$1";
}


IS_BREW_INSTALLED=0

function install_brew() {
    opt_print="print_style"

    if [ "$1" == "0" ]; then
        opt_print=""

        if [ "$IS_BREW_INSTALLED" == "1" ]; then
            return
        fi
    fi

    if ! command -v brew &> /dev/null
    then
        opt_print "installing homebrew" "info"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    opt_print "found homebrew version:" "success"
    HOMEBREW_VER_OUT=$(brew --version | head -n 1)
    opt_print "\t$HOMEBREW_VER_OUT" "info"
    IS_BREW_INSTALLED=1
}

function install_with_brew() {
    install_brew 0
    export HOMEBREW_NO_INSTALL_UPGRADE=1
    brew install $1
} 

function install_git() {
    install_with_brew pyenv
}

function install_pyenv() {
    install_with_brew pyenv
}


###### Main
export PATH=/usr/local/bin:$PATH

install_brew
install_git
install_pyenv
install_python_versions
