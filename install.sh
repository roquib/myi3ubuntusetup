sudo apt install git vim tmux fonts-font-awesome lm-sensors sysstat i3 i3blocks i3status i3lock i3-wm youtube-dl zsh volumeicon-alsa mpv feh lxappearance nitrogen python3-pip rofi compton dunst
# for vim
# download vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
cd myi3ubuntusetup
mv colors ~/.vim/
mv syntax ~/.vim/
pip3 install powerline-status
mv .i3 ~/.i3
mv .vimrc ~/.vimrc
mv .zshrc ~/.zshrc
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
chsh -s /bin/zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

