# Must be done here so that the pyenv plugin doesn't print the annoying warning
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
