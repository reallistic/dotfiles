###
# NOTE: This file is also picked up by zsh.
#   DO NOT put anything in it that is incompatible
###

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


export JAVA_HOME=$(/usr/libexec/java_home)
export NODE_PATH=`which node`

# if [ -e "$HOME/workspace/ntflx/itay_cde_helpers/autoloaded_profile_files" ]; then
#     for sh_file in $HOME/workspace/ntflx/itay_cde_helpers/autoloaded_profile_files/*.sh; do
#       source $sh_file
    #    if [ -d "${_envdir}" ]; then
    #        for _envfile in "${_envdir}"/*; do
    #            if [ -r "${_envfile}" ]; then
    #                . "${_envfile}"
    #            fi
    #        done
    #    fi
#     done
#     unset sh_file
# fi
unset PYTHONSTARTUP

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export GOPATH="$HOME/workspace/ntflx/go_workspace"
export GOPRIVATE="*.corp.netflix.com"
