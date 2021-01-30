# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"

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
plugins=(git zsh-syntax-highlighting zsh-autosuggestions ruby rails python archlinux cp gem gitfast golang pip sudo tmux vim-interaction vi-mode)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export EDITOR="vim -f"

# ZSH iterm word jump
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

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

JAVA_HOME=/usr/java/jre1.8.0_271
#PATH=$PATH:$JAVA_HOME/bin
#export=$PATH:$HOME/.local/bin
export JAVA_HOME


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source <(kubectl completion zsh)
alias k=kubectl
complete -F __start_kubectl k
