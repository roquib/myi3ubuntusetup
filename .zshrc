export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="sammy"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions ruby rails python archlinux cp gem gitfast go pip sudo tmux vim-interaction vi-mode)

source $ZSH/oh-my-zsh.sh
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export EDITOR="vim"
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
export BROWSER=/usr/bin/google-chrome-stable
alias con='vim $HOME/.i3/config'
alias comp='vim $HOME/.config/compton.conf'
alias fixit='sudo rm -f /var/lib/pacman/db.lck'
#alias inst='sudo apt install '
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias mirrors='sudo pacman-mirrors -g'
alias printer='system-config-printer'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias pacman='sudo pacman'
alias pip='sudo pip'
alias bpy='bpython2'
alias bp='bpython'
alias irb='irb --simple-prompt'
alias i3b="vim ~/.i3/i3blocks.conf"

