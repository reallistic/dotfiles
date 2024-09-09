#!/bin/bash -e


PY_VERSIONS=(
2.7.14
3.6.4
3.6.5
3.6.9
3.7.5
3.7.9
3.8.0
3.8.15
3.9.4
3.9.13
3.10.6
3.11.0
)

INSTALL_LOCATION="$HOME/.pyenv"
REQS_LOCATION="$HOME/.dotfiles_public/pyenv"
DEFAULT_REQUIREMENTS_IN_FILE="$REQS_LOCATION/global_requirements.in"

if [ ! -f $DEFAULT_REQUIREMENTS_IN_FILE ]; then
    echo "failed to find $DEFAULT_REQUIREMENTS_IN_FILE"
    exit 1
fi

export PIP_REQUIRE_VIRTUALENV=false

if command -v pyenv &> /dev/null; then
    for version in $PY_VERSIONS; do
        if [ ! -f $INSTALL_LOCATION/versions/$version/bin/python ]; then
            pyenv install $version
        fi

        cmd_bin="$(pyenv prefix $version)/bin"
        in_file="$DEFAULT_REQUIREMENTS_IN_FILE"
        if [[ -f "$REQS_LOCATION/global_requirements.$version.in" ]]; then
            in_file="$REQS_LOCATION/global_requirements.$version.in"
        fi
        out_file="$REQS_LOCATION/global_requirements.$version.txt"
        echo "processing python version $version"
        echo "bin dir: $cmd_bin"
        echo "in file: $in_file"
        echo "out file: $out_file"
        echo "=========================="

        echo "Upgrading pip"
        $cmd_bin/pip install --upgrade pip setuptools wheel
        echo "Installing pip-tools"
        $cmd_bin/pip install --upgrade pip-tools
        echo "compiling in file $in_file"
        $cmd_bin/pip-compile --upgrade --output-file $out_file $in_file
        # $cmd_bin/pip-sync $out_file
        $cmd_bin/pip install -r $out_file
        echo "=========================="
        echo ""
        echo ""
        echo "========== DONE =========="
    done
fi
