export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export ZSH="/Users/oli/.oh-my-zsh"
export EDITOR='vim'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# don't paginate less than one screen
# Is this annoying? possibly.
export LESS="--no-init --quit-if-one-screen -R"

# chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

alias ctags=/usr/local/Cellar/universal-ctags/HEAD-217cdf1/bin/ctags

if [ -f ~/.zsh_aliases ]; then
	. ~/.zsh_aliases
fi

if [ -f ~/.zsh_global_config ]; then
	. ~/.zsh_global_config
fi

# Mobile APP
alias bump-app-version="bundle exec fastlane android fatmap_bump_app_build_version && bundle exec fastlane ios fatmap_bump_app_build_version && bundle exec fastlane android fatmap_update_app_version && bundle exec fastlane ios fatmap_update_app_version"

# Me
alias gcob='git checkout -b'
alias shake='adb shell input keyevent 82'
alias ngrok='~/code/ngrok'
alias gbdmerged="git branch --merged master | grep -v -e 'master' -e '\*' | xargs -n 1 git branch -d && git remote prune origin"
# 'git tag recent'
alias gtr="git tag --sort=-creatordate | head"

# Don't include this user in shell prompt (agnoster)
DEFAULT_USER=oli

CASE_SENSITIVE="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
ZSH_THEME="agnoster"
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true
plugins=(asdf git react-native ruby chruby kubectl kube-ps1 zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# nvm - custom code to speed up loading
# https://gist.github.com/gfguthrie/9f9e3908745694c81330c01111a9d642
# https://github.com/nvm-sh/nvm/issues/1277#issuecomment-536218082
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"
export PATH="$NVM_DIR/versions/node/v$(<$NVM_DIR/alias/default)/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

# scm breeze
[ -s "/Users/oli/.scm_breeze/scm_breeze.sh" ] && source "/Users/oli/.scm_breeze/scm_breeze.sh"

# https://facebook.github.io/react-native/docs/getting-started.html
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# heroku autocomplete setup
#HEROKU_AC_ZSH_SETUP_PATH=/Users/oli/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# bindings for pgup/pgdown during autocomplete
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward



export PROMPT=$PROMPT'$(kube_ps1)'
kubeoff # kubeon to turn kube_ps1 on
