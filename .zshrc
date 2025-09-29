# Profiling zsh startup (see end)
# zmodload zsh/zprof

# Speed up compinit by checking cached .zcompdump only once per day
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# https://copperlight.github.io/shell/zsh-keyboard-shortcuts/
# ctrl-t swaps two preceding characters
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export ZSH="/Users/oli/.oh-my-zsh"
export EDITOR='vim'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# don't paginate less than one screen
# Is this annoying? possibly.
export LESS="--no-init --quit-if-one-screen -R"

alias ctags=/opt/homebrew/Cellar/universal-ctags/HEAD-fe5a84e/bin/ctags

alias be='bundle exec'

# alias yarn=npm_yarn
# npm_yarn() {
#   echo "use npm run instead, idiot 👹"
#   npm run "$@"
# }

if [ -f ~/.zsh_aliases ]; then
	. ~/.zsh_aliases
fi

if [ -f ~/.strava_env ]; then
	. ~/.strava_env
fi

if [ -f ~/.zsh_global_config ]; then
	. ~/.zsh_global_config
fi

# Me
alias gcob='git checkout -b'
alias shake='adb shell input keyevent 82'
alias ngrok='~/code/ngrok'
alias gbdmerged="git branch --merged main | grep -v -e 'main' -e '\*' | xargs -n 1 git branch -d && git remote prune origin"
alias gbdmergedmaster="git branch --merged master | grep -v -e 'master' -e '\*' | xargs -n 1 git branch -d && git remote prune origin"
# 'git tag recent'
alias gtr="git fetch >> /dev/null && git tag --sort=-creatordate | head"
# open PR from current branch in browser
alias pro="gh pr view --web"
alias deploydev="gh pr comment -b /deploydev"

# Don't include this user in shell prompt (agnoster)
DEFAULT_USER=oli

CASE_SENSITIVE="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
ZSH_THEME="agnoster"
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true
plugins=(git ruby chruby kubectl kube-ps1 zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# nvm - custom code to speed up loading
# https://gist.github.com/gfguthrie/9f9e3908745694c81330c01111a9d642
# https://github.com/nvm-sh/nvm/issues/1277#issuecomment-536218082
# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"
# export PATH="$NVM_DIR/versions/node/v$(<$NVM_DIR/alias/default)/bin:$PATH"
# export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# export PATH="/Users/oli/Library/Python/3.9/bin:$PATH"
# alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

# https://facebook.github.io/react-native/docs/getting-started.html
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# bindings for pgup/pgdown during autocomplete
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward

export PROMPT=$PROMPT'$(kube_ps1)'
kubeoff # kubeon to turn kube_ps1 on
export AWS_CONFIG_FILE=/Users/oli/.aws/config
alias fm-mfa-engineering='awsume fatmap-default-engineering -o fatmap-default && awsume -u'
alias fm-mfa-terraform='awsume fatmap-root-terraform --role-duration 3600'
alias fm-mfa-admin='awsume fatmap-default-admin -o fatmap-default && awsume -u'

# STRAVA
# https://strava.atlassian.net/wiki/spaces/eng/pages/1874133015/Docker+images+on+Elastic+Container+Registry+ECR#Recommended-Option%3A-aws-login-Script
alias aws-login="/Users/oli/code/strava/configuration/mesos/tools/aws-login"

# note: this makes dockerBuildAndPush work locally, but might break active.
# have fun Oli! blame charlie if this doesn't work
# export DOCKER_BUILDKIT=1
# export DOCKER_DEFAULT_PLATFORM=linux/amd64

# alias docker-compose="docker compose"

# Scala https://strava.atlassian.net/wiki/spaces/eng/pages/1651114149/System+Setup#MacOS
# export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
# export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"
export PATH="$HOME/.canary-tools/bin:$PATH"


# ASDF, chatgpt told me to do it
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# golang setup https://go.dev/doc/install
export PATH=$PATH:/usr/local/go/bin

export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# scm breeze got broken, temporarily replacing with
# https://github.com/mroth/scmpuff and https://github.com/ajeetdsouza/zoxide
# via brew
# [ -s "/Users/oli/.scm_breeze/scm_breeze.sh" ] && source "/Users/oli/.scm_breeze/scm_breeze.sh"
eval "$(scmpuff init -s)"
eval "$(zoxide init zsh --cmd c)"

# Profiling zsh startup (see beginning)
# zprof
