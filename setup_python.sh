#!/bin/bash -e

# export PIP_INDEX_URL="https://smartiproxy.mgmt.netflix.net/pypi"

DEFAULT_REQUIREMENTS_IN_FILE="global_requirements.in"

python_versions=$(pyenv versions --bare --skip-aliases)
for version in $python_versions
do
    cmd_bin="$(pyenv prefix $version)/bin"
    in_file="$DEFAULT_REQUIREMENTS_IN_FILE"
    if [[ -f "global_requirements.$version.in" ]]; then
        in_file="global_requirements.$version.in"
    fi
    out_file="global_requirements.$version.txt"
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
