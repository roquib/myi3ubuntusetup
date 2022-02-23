sudo apt install git vim tmux fonts-font-awesome lm-sensors sysstat i3 i3blocks i3status i3lock i3-wm youtube-dl zsh volumeicon-alsa mpv feh lxappearance nitrogen python3-pip rofi compton dunst
# for vim
# download vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
cd myi3ubuntusetup
cp -rf colors ~/.vim/
cp -rf syntax ~/.vim/
pip3 install powerline-status
cp -rf .i3 ~/.i3
cp -rf vimrc ~/.vimrc
cp -rf zshrc ~/.zshrc
cp -rf gemrc ~/.gemrc
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
chsh -s /bin/zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# install spaceship to oh my zsh folder
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1

# create a symlink
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# install vscode 
sudo apt install software-properties-common apt-transport-https wget
# Import the Microsoft GPG key
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
# add repository

sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
# install vs-code
sudo apt install code


# add php pppa
echo "adding php ppa ondrej/php"
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update

echo "installing php"
sudo apt install -y php curl php-mbstring php-zip php-gd php-json php-curl php-xml php-sqlite3 php-mysql php-pgsql

echo "installing composer"
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

echo 'installing mysql server'

sudo apt install -y mysql-server

sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';FLUSH PRIVILEGES;"


echo "installing laravel"
composer global require laravel/installer
echo "laravel valet"
composer global require cpriego/valet-linux

echo "Installing dependency of valet "
sudo apt-get install network-manager libnss3-tools jq xsel
valet install

echo "installing phpmyadmin"
echo "switching to bash"

bash

DATA="$(wget https://www.phpmyadmin.net/home_page/version.txt -q -O-)"
URL="$(echo $DATA | cut -d ' ' -f 3)"
VERSION="$(echo $DATA | cut -d ' ' -f 1)"
wget https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.tar.gz

tar xvf phpMyAdmin-${VERSION}-all-languages.tar.gz
echo "switching to zsh"
zsh

mkdir ~/Sites
mkdir ~/Sites/phpmyadmin
mv phpMyAdmin-*/ ~/Sites/phpmyadmin

cd ~/Sites && valet park && cd

curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

echo "installing node"
nvm install 16
nvm use 16
nvm alias default 16

echo "installing protonvpn "
wget https://protonvpn.com/download/protonvpn-stable-release_1.0.1-1_all.deb
sudo apt update
sudo apt-get install protonvpn
sudo apt install gnome-shell-extension-appindicator gir1.2-appindicator3-0.1

echo "activate vpn after that press any key to start"
read -k1 -s

npm install -g yarn

echo "installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "installing expo"
npm install -g expo-cli
