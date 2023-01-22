#!/bin/bash -e

NODE_VERSIONS=(
12.16.1
13.7.0
14.15.5
18.13.0
)

INSTALL_LOCATION="$HOME/.nvm"

for version in $NODE_VERSIONS; do
    if [ ! -f $INSTALL_LOCATION/versions/node/v$version/bin/node ]; then
        nvm install $version
    fi
done
