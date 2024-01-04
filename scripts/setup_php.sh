# Add php repository

sudo apt update
sudo apt upgrade
sudo apt install ca-certificates apt-transport-https software-properties-common lsb-release -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt upgrade

# Install php
sudo apt install php8.3 php8.3-fpm php8.3-cli

# Install required php extensions for Laravel
sudo apt install \
	php8.3-common \
	php8.3-bcmath \
	php8.3-curl \
	php8.3-mbstring \
	php8.3-mysql \
	php8.3-sqlite3 \
	php8.3-xml

# Install required php extensions for Laravel Fillament package
sudo apt install \
	php8.3-intl

# Install required tools for Laravel
sudo apt install openssl

# Start php fpm
sudo systemctl start php8.3-fpm

# Swich php versions
# sudo update-alternatives --set php /usr/bin/php7.4
# TODO: create fn to set version, e.g: usephp 8.1

# Install php lsp
curl -Lo phpactor.phar https://github.com/phpactor/phpactor/releases/latest/download/phpactor.phar
chmod a+x phpactor.phar
mv phpactor.phar ~/.local/bin/phpactor

# Install composer package manager
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
