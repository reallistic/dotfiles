# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# enable vim mode in terminal
set -o vi

# increase zsh/bash history length
HISTFILESIZE=10000000

# Magical z
if command -v brew &> /dev/null; then
    . `brew --prefix`/etc/profile.d/z.sh
fi
