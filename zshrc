ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git git-auto-fetch git-escape-magic git-extras git-flow git-flow-avh git-hubflow git-prompt gitignore git-lfs history laravel minikube node npm nvm tmux yarn yum zsh-interactive-cd zsh-navigation-tools docker docker-compose dnf flutter fzf kubectl zsh-syntax-highlighting zsh-autosuggestions cp gitfast vim-interaction vi-mode)
source $ZSH/oh-my-zsh.sh

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

echo "install java 17"
sudo apt install openjdk-17-jdk

JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
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
#export no_proxy=localhost,127.0.0.1

# android config
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# flutter sdk path
export PATH="$PATH:$HOME/.config/flutter/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
