export NVM_DIR="$HOME/.nvm"

if [ -s "/usr/local/opt/nvm/nvm.sh" ]; then
    . "/usr/local/opt/nvm/nvm.sh"
fi

export NODE_PATH=`nvm which current`
