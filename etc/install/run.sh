# Update package repositories
echo 'Updating package repositories...'
sudo apt-add-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
sudo apt-get update
echo 'Done updating package repositories'

# Configure mysql package with root password so the installer
# doesn't prompt for one during installation
echo 'Configuring mysql package with root password...'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password acmrocks'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password acmrocks'
echo 'Done configuring mysql package'

# Install LAMP stack
echo 'Installing Apache, MySql, and PHP...'
sudo apt-get install -y lamp-server^
echo 'Done installing Apache, MySql, and PHP'

# Install PHP extensions
echo 'Installing some PHP extensions...'
sudo apt-get install -y php5-curl
echo 'Done installing PHP extensions'

# Install composer
echo 'Installing Composer...'
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
echo 'Done installing Composer'