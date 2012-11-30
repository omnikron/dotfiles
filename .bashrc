export PATH="/usr/local/bin:/usr/local/pgsql/bin:/usr/local/php5/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"

function git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

PS1='\[\033[0;37m\][\[\033[01;36m\]\W\[\033[0;37m\]] \[\033[0;32m\]$(git_branch)\[\033[00m\]\$ '


[ -s "/Users/oli/.scm_breeze/scm_breeze.sh" ] && . "/Users/oli/.scm_breeze/scm_breeze.sh"

PROMPT_COMMAND="history -a"
shopt -s histappend 
export HISTSIZE=10000
export HISTCONTROL=erasedups

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
