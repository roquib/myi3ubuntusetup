sudo apt install git vim tmux terminator fonts-font-awesome lm-sensors sysstat i3 i3blocks i3status i3lock i3-wm zsh volumeicon-alsa mpv feh lxappearance nitrogen python3-pip rofi compton dunst

git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

cp -rf .i3 ~/.i3
cp -rf zshrc ~/.zshrc

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

chsh -s /usr/bin/zsh

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

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

echo "Installing defualt php"
sudo apt install -y php curl php-mbstring php-zip php-gd php-curl php-xml php-sqlite3 php-mysql php-pgsql
sudo apt install -y php8.0 php8.0-mbstring php8.0-zip php8.0-gd php8.0-curl php8.0-xml php8.0-sqlite3 php8.0-mysql php8.0-pgsql
sudo apt install -y php8.1 php8.1-mbstring php8.1-zip php8.1-gd php8.1-curl php8.1-xml php8.1-sqlite3 php8.1-mysql php8.1-pgsql
sudo apt install -y php8.2 php8.2-mbstring php8.2-zip php8.2-gd php8.2-curl php8.2-xml php8.2-sqlite3 php8.2-mysql php8.2-pgsql

echo "installing composer"
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

echo 'Installing mysql server'

sudo apt install -y mysql-server

sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';FLUSH PRIVILEGES;"

echo "Installing laravel valet"
composer global require cpriego/valet-linux

echo "Installing dependency of valet "
sudo apt-get install network-manager libnss3-tools jq xsel
valet install

echo "Installing phpmyadmin"

DATA="$(wget https://www.phpmyadmin.net/home_page/version.txt -q -O-)"
URL="$(echo $DATA | cut -d ' ' -f 3)"
VERSION="$(echo $DATA | cut -d ' ' -f 1)"
wget https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.tar.gz

tar xvf phpMyAdmin-${VERSION}-all-languages.tar.gz

mkdir ~/Sites
mkdir ~/Sites/phpmyadmin
mv phpMyAdmin-*/* ~/Sites/phpmyadmin

cd ~/Sites && valet park && cd

curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

echo "installing node"
nvm install 20
nvm use 20
nvm alias default 20

sudo apt install gnome-shell-extension-appindicator gir1.2-appindicator3-0.1

npm install -g yarn expo-cli pnpm live-server 

echo "installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "installing github desktop"
cd ~/Downloads && wget https://github.com/shiftkey/desktop/releases/download/release-3.3.12-linux2/GitHubDesktop-linux-amd64-3.3.12-linux2.deb
sudo dpkg -i GitHubDesktop-linux-amd64-3.3.12-linux2.deb
rm -rf GitHubDesktop-linux-amd64-3.3.12-linux2.deb

echo "installing bitwarden"

wget https://github.com/bitwarden/desktop/releases/download/v2022.5.1/Bitwarden-2022.5.1-amd64.deb
sudo dpkg -i Bitwarden-2022.5.1-amd64.deb
rm -rf Bitwarden-2022.5.1-amd64.deb

echo "installing slack"
wget https://downloads.slack-edge.com/releases/linux/4.23.0/prod/x64/slack-desktop-4.23.0-amd64.deb
sudo dpkg -i slack-desktop-4.23.0-amd64.deb
rm -rf slack-desktop-4.23.0-amd64.deb

echo "installing skype"
wget https://repo.skype.com/latest/skypeforlinux-64.deb
sudo dpkg -i skypeforlinux-64.deb
rm -rf skypeforlinux-64.deb

echo "installing jopline"
sudo apt install libfuse2
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash


echo "Installing github cli"
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

gh auth login

gh repo clone neovim/neovim

sudo apt-get install ninja-build gettext cmake unzip curl build-essential

cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install && cd 

echo "Installing lazyvim"
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

git clone https://github.com/LazyVim/starter ~/.config/nvim

echo "Installing nerd fonts"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Inconsolata/InconsolataNerdFont-Regular.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Ubuntu/Regular/UbuntuNerdFont-Regular.ttf

fc-cache -vf ~/.local/share/fonts && cd 