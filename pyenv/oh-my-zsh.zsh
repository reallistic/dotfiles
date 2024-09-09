# Must be done here so that the pyenv plugin doesn't print the annoying warning
if command -v pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
fi
