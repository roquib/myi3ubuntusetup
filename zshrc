# export functions
export FPATH=/usr/share/zsh/5.8.1/functions:$FPATH
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-auto-fetch git-escape-magic git-extras git-flow git-flow-avh git-hubflow git-prompt gitignore git-lfs history laravel minikube node npm nvm tmux yarn yum zsh-interactive-cd zsh-navigation-tools docker docker-compose dnf flutter fzf kubectl zsh-syntax-highlighting zsh-autosuggestions cp gitfast vim-interaction vi-mode)
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export EDITOR="nvim"
export TERMINAL="gnome-terminal"
export BROWSER="google-chrome-stable"

# ZSH iterm word jump
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

export PATH="/usr/local/bin:$PATH"

export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
alias sail='bash vendor/bin/sail'

function stopService()
{
  echo "Stopping mysql, apache2, nginx, redis\n"
  sudo systemctl stop mysql.service
  sudo systemctl stop apache2.service
  sudo systemctl stop nginx.service
  sudo systemctl stop redis-server.service
}

function startService()
{
  echo "Starting mysql, nginx, redis\n"
  sudo systemctl start mysql.service
  sudo systemctl start nginx.service
  sudo systemctl start redis-server.service
}

function stopDocker()
{
  echo "stopping docker"
  sudo systemctl stop docker.service
  sudo systemctl stop docker.socket
}

JAVA_HOME=/usr/lib/jvm/java-17-openjdk-17.0.2.0.8-6.fc36.x86_64
PATH=$PATH:$JAVA_HOME/bin
#export=$PATH:$HOME/.local/bin
export JAVA_HOME


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# PHP
alias phpunit="vendor/bin/phpunit"
alias phpunitw="phpunit-watcher watch"
alias a="php artisan"
alias ar="php artisan remote"
alias c="composer"
alias cu="composer update"
alias cr="composer require"
alias ci="composer install"
alias cda="composer dump-autoload -o"
alias larastan="vendor/bin/phpstan analyse"
alias hostfile="sudo vi /etc/hosts"
alias deploy='envoy run deploy'
alias deploy-code='envoy run deploy-code'
alias mfs='php artisan migrate:fresh --seed'
alias nah='git reset --hard;git clean -df'

alias pp="php artisan test --parallel"
alias d="php artisan dusk"
alias sshconfig="vi ~/.ssh/config"
alias copykey='command cat ~/.ssh/id_rsa.public | pbcopy'
alias sail='./vendor/bin/sail'
alias tunnel='valet share -subdomain=freekmurze -region=eu'

# JavaScript
alias jest="./node_modules/.bin/jest"

# Git
alias gc="git checkout"
alias gpo="git push origin"
alias gm="git merge"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# List all files colorized in long format
alias l="ls -laF"

#export http_proxy=http://103.147.163.93:80
#export https_proxy=http://103.147.163.93:80
export no_proxy=localhost,127.0.0.1

# android config
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# flutter sdk path
export PATH="$PATH:$HOME/.config/flutter/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
