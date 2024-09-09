export NVM_DIR="$HOME/.nvm"

if [ -s "/usr/local/opt/nvm/nvm.sh" ]; then
    . "/usr/local/opt/nvm/nvm.sh"
fi

if command -v metatron &> /dev/null; then
    export NODE_PATH=`nvm which current`
fi
