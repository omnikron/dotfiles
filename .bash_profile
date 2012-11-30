alias ls='ls -la'
alias grep='grep --color'
alias code='cd ~/code'
alias subma='cd ~/code/digitaleseiten/submarine'
alias g='git'
alias app1='ssh -t crm@app1.subma.net "cd -P current; bash"'
alias app2='ssh -t crm@app2.subma.net "cd -P current; bash"'
alias sstaging='ssh -t crm@staging.subma.net "cd -P current; bash"'

# Git autocompletion

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash  ]; then
source `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

# Autocomplete for 'g' as well
complete -o default -o nospace -F _git g

# Use Vi commands in terminal
set -o vi

# Use Vim as default editor
export EDITOR='vim'

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm --default use 1.9.2-p290

if [ -f ~/.bashrc ]; then
     source ~/.bashrc
fi
