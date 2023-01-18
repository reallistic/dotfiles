#!/usr/bin/env bash -e

# Usage: ./script [--noop]

POSITIONAL_ARGS=()

NOOP=0
while [[ $# -gt 0 ]]; do
  case $1 in
    -n|--noop)
      NOOP=1
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

export ENABLE_NOOP=$NOOP
source ./utils.sh


function setup_newt() {
    local prog="Newt"
    print_check "$prog"
    if ! command -v newt &> /dev/null; then
        print_failed_check
        print_check "$prog install script"
        if curl --connect-timeout 4 -sSL 'https://go.prod.netflix.net/newt-install' -o /dev/null; then
            print_passed_check
            wrap_install "$prog" \
                "execute_script" "https://go.prod.netflix.net/newt-install"
        else
            print_failed_check
            print_stylen "Failed connecting to newt install script" danger
            exit 1
        fi
    fi
}

function setup_commandline_tools() {
    local prog="Xcode command line tools"
    print_check "$prog"
    if ! xcode-select -p 1>/dev/null; then
        print_failed_check
        wrap_install "$prog" xcode-select --install
    else
        print_passed_check
    fi
}

function vpn_check() {
    print_check "VPN connectivity"
    if ! noop newt vpn-check; then
        print_failed_check "❌"
        print_stylen "VPN is required to continue with setup" danger
        exit 1
    else
        print_passed_check
    fi
}

function setup_brew() {
    local prog="Brew"
    print_check "$prog"
    if ! command -v brew &> /dev/null; then
        print_failed_check
        wrap_install "$prog" \
            "execute_script" \
            "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
    else
        print_passed_check
    fi

    if command -v brew &> /dev/null; then
        print_stylen "$prog version:" "success"
        HOMEBREW_VER_OUT=$(brew --version | head -n 1)
        print_stylen "\t$HOMEBREW_VER_OUT" "info"
    fi
}

function setup_newt_python() {
    print_stylen "Bootstrapping python (pynt, pickley)" info
    noop newt --app-type python setup
}

function make_pynt_venv() {
    local location=$1; shift
    local msg="venv at $location"
    if [ $# -ge 1 ]; then
        msg=$1
    fi
    wrap_install "$msg" \
        newt --app-type python virtualenv -p3.9 $location
}

function run_bootstrap() {
    local prog="python bootstrap venv"
    print_check "$prog"
    if [ ! -f ".venv/bin/python" ]; then
        print_failed_check
        make_pynt_venv .venv "$prog"
    fi
    noop .venv/bin/pip install -r requirements.txt
    noop .venv/bin/python mac_bootstrap
}

function setup_docker() {
    # https://docs.docker.com/desktop/install/mac-install/

}

setup_commandline_tools
setup_brew
setup_newt
vpn_check
run_bootstrap
