ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
HOMEPATH="/home/abdur-roquib-pramanik/laravel-docker"

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
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
alias sail='bash vendor/bin/sail'

function stopService()
{
  echo "Stopping mysql, apache2, nginx, redis\n"
  sudo systemctl stop mysql.service
  # sudo systemctl stop apache2.service
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

function status()
{
  sudo systemctl status $1.service
}

function is_active()
{
  sudo systemctl is-active $1.service
}


function server_status()
{
  mysql_active=$(is_active mysql)
  echo "mysql: $mysql_active\n"
  nginx_active=$(is_active nginx)
  echo "nginx: $nginx_active\n"
  redis_server_active=$(is_active mysql)
  echo "redis-server: $redis_server_active\n"
}



function stopDocker()
{
  echo "stopping docker"
  sudo systemctl stop docker.service
  sudo systemctl stop docker.socket
}

function startLaradock()
{
  echo "Starting laradock\n"
  current_dir=$(pwd)
  cd $HOMEPATH/laradock
  stopService

  echo "Stopping Services\n"
  mysql_active=$(is_active mysql)
  echo "mysql: $mysql_active\n"
  nginx_active=$(is_active nginx)
  echo "nginx: $nginx_active\n"
  redis_server_active=$(is_active mysql)
  echo "redis-server: $redis_server_active\n"
  echo "Starting Laradock\n"
  if ss -tuln | grep -q ':3306'; then
    docker compose up -d apache2 php-fpm workspace
  else
    docker compose up -d apache2 phpmyadmin php-fpm workspace
  fi
  docker compose stop mysql
  docker compose up -d mariadb
  docker compose ps
  cd $current_dir
}

function create_host()
{
  echo "Creating host $1\n"
  current_dir=$(pwd)
  ARGUMENT="$1"
  # Path to the Apache virtual host configuration file
  CONFIG_FILE="${HOMEPATH}/laradock/apache2/sites/${ARGUMENT}.conf"

  echo "Coping sample.conf.example\n"
  cp -rf $HOMEPATH/laradock/apache2/sites/sample.conf.example $CONFIG_FILE
  OLD_DOMAIN="sample.test"
  NEW_DOMAIN="${ARGUMENT}.test"

  OLD_DIR="/sample/public"
  NEW_DIR="/${ARGUMENT}"


  if [ -f $CONFIG_FILE ]; then
    sed -i "s|$OLD_DOMAIN|$NEW_DOMAIN|g" "$CONFIG_FILE"

    # Replace the directory path
    sed -i "s|$OLD_DIR|$NEW_DIR|g" "$CONFIG_FILE"
  fi

  echo "Replacements completed in $CONFIG_FILE."
  # Define the IP address and hostname you want to add
  IP_ADDRESS="127.0.0.1"
  HOSTNAME="${ARGUMENT}.test"
  hostname_entry="${IP_ADDRESS} ${HOSTNAME}"
  grepSearch=$(grep "${hostname_entry}$" /etc/hosts)

  if [[ "$hostname_entry" != "$grepSearch" ]]; then
    echo "$IP_ADDRESS $HOSTNAME" | sudo tee -a /etc/hosts > /dev/null
    echo "${ARGUMENT}.test added to /etc/hosts successfully."
  fi

  MYSQL_STATUS=$(systemctl is-active mysql) # active, inactive, failed
  DOCKER_CONTAINER_NAME="laradock-mariadb-1"
  DOCKER_MYSQL_STATUS=$(docker inspect -f '{{.State.Status}}' $DOCKER_CONTAINER_NAME) # running,exited

  if [[ "$MYSQL_STATUS" != "active" && "$DOCKER_MYSQL_STATUS" != "running" ]]; then
    echo "startLaradock\n"
    startLaradock
  else
    stopLaradock && startLaradock
  fi

  # Variables
  DB_NAME="${ARGUMENT}"
  DB_USER="root"
  DB_PASSWORD="root"

  cd "$HOMEPATH/laradock"

  # Check if the database exists
  DB_EXISTS=$(docker compose exec -T mariadb mariadb -u"$DB_USER" -p"$DB_PASSWORD" -e "SHOW DATABASES LIKE '$DB_NAME';" | grep "$DB_NAME" > /dev/null; echo "$?")

  if [ $DB_EXISTS -eq 0 ]; then
    echo "Database $DB_NAME already exists."
  else
    docker compose exec -T mariadb mariadb  -u$DB_USER -p$DB_PASSWORD -e "CREATE DATABASE $DB_NAME;"
    echo "Database $DB_NAME created successfully."
  fi

  HTACCESS_FILE="${HOMEPATH}/$ARGUMENT/.htaccess"
  if [ -f "${HOMEPATH}/$ARGUMENT/artisan" ]; then
    if [ ! -f $HTACCESS_FILE ]; then
      cat <<EOL >> "$HTACCESS_FILE"

# Rewrite rules to handle Laravel's public folder
RewriteEngine on
RewriteCond %{REQUEST_URI} !^public
RewriteRule ^(.*)$ public/$1 [L]
EOL
    fi

  PROJECT_PATH="$HOMEPATH/$ARGUMENT"
  cd $PROJECT_PATH
  ENV_FILE="${PROJECT_PATH}/.env"
  if [ -f $ENV_FILE ]; then
    sed -i "s/^APP_URL=.*/APP_URL=http:\/\/$ARGUMENT.test/" "$ENV_FILE"
    sed -i "s/^DB_CONNECTION=.*/DB_CONNECTION=mariadb/" "$ENV_FILE"
    sed -i "s/^DB_HOST=.*/DB_HOST=mariadb/" "$ENV_FILE"
    sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=root/" "$ENV_FILE"
  fi
  chmod -R 777 "${HOMEPATH}/$ARGUMENT/storage/"
  chmod -R 777 "${HOMEPATH}/$ARGUMENT/bootstrap/cache"
  composer install
  npm install
  fi


  cd $current_dir
}

function remove_host()
{
  echo "removing hostname $1\n"
  current_dir=$(pwd)
  ARGUMENT="$1"
  if [ -f "$HOMEPATH/laradock/apache2/sites/$ARGUMENT.conf" ]; then
    rm -rf $HOMEPATH/laradock/apache2/sites/$ARGUMENT.conf
    echo "removed config file\n"
  fi

  IP_ADDRESS="127.0.0.1"
  HOSTNAME="${ARGUMENT}.test"
  hostname_entry="${IP_ADDRESS} ${HOSTNAME}"
  grepSearch=$(grep "${hostname_entry}$" /etc/hosts)

  if [[ "$hostname_entry" == "$grepSearch" ]]; then
    sudo sed -i "/$HOSTNAME/d" /etc/hosts
    echo "removed hostname from /etc/hosts\n"
  fi
  HTACCESS_FILE="$HOMEPATH/$ARGUMENT/.htaccess"
  if [ -f "$HOMEPATH/$ARGUMENT/artisan" ]; then
    if [ -f $HTACCESS_FILE ]; then
      rm -rf $HTACCESS_FILE
      echo "removed $HTACCESS_FILE\n"
    fi
  fi

}

function stopLaradock()
{
  echo "Stopping laradock\n"
  current_dir=$(pwd)
  cd $HOMEPATH/laradock
  docker compose stop
  echo "Starting Services\n"
  startService
  server_status
  cd $current_dir
}



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
