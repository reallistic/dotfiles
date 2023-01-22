# Shortcut for deleting pyc files recursively in the current directory
alias rmpyc='find . -name "*.pyc" -delete'

alias activateenv='source venv/bin/activate'

alias makepyenv='virtualenv --no-site-packages venv'
alias makepy3env='python3 -m venv venv'

alias gitpushu='git push -u origin HEAD'
alias gitpushf='git push -f'
alias gitfetchmain='git fetch origin master:master'
alias gitlogu='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' -10'
