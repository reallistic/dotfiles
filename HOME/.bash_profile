export OC_REPO_PATH=/Users/michase/workspace/ntflx/octools
source ${OC_REPO_PATH}/shell/oc_bash_profile.sh
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

set -o vi

export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

HISTFILESIZE=10000000

export KUBERNETES_PROVIDER=vagrant
export REACT_EDITOR=/Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text

# Imports local changes from .bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Adds pyenv stuff
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export NVM_DIR="$HOME/.nvm"

[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/michase/.sdkman"
[[ -s "/Users/michase/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/michase/.sdkman/bin/sdkman-init.sh"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
