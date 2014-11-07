# Update package repositories
echo 'Updating package repositories...'
sudo apt-add-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
sudo apt-get update
echo 'Done updating package repositories'

# Install git
echo 'Installing git...'
sudo apt-get install -y git
echo 'Done installing git'

# Install GNOME GUI
echo 'Installing GNOME...'
sudo apt-get install -y xorg gnome-core gnome-system-tools gnome-app-install
echo 'Done installing GNOME'

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

# Set up Student database for application
echo 'Setting up Student db...'
mysqladmin --user root --password=acmrocks create Student
echo 'Done setting up Student db'

# Install PHP extensions
echo 'Installing some PHP extensions...'
sudo apt-get install -y php5-curl
echo 'Done installing PHP extensions'

# Set up apache server to serve /vagrant/web
echo 'Setting up apache server to serve /vagrant/web...'

# Create virtual host for /vagrant/web
sudo cat <<EOF > /etc/apache2/sites-available/student.dev.conf
<VirtualHost *:80>
DocumentRoot /vagrant/web
ServerName student.dev
ServerAlias www.student.dev
ErrorLog ${APACHE_LOG_DIR}/student.dev.error.log
</VirtualHost>
EOF

# Set permissions for /vagrant/web
sudo cat <<EOF >> /etc/apache2/apache2.conf
<Directory "/vagrant/web">
Options Indexes FollowSymLinks
AllowOverride All
Require all granted
</Directory>
EOF

chmod -R 755 /vagrant/web
# Disable default host
sudo a2dissite 000-default.conf
# Enable new host
sudo a2ensite student.dev.conf
# Restart Apache
sudo service apache2 restart

echo 'Done setting up apache server'

# Set www.student.dev in host file
echo 'Setting up host file...'
sudo echo '127.0.0.1 www.student.dev' >> /etc/hosts
sudo echo '127.0.0.1 student.dev' >> /etc/hosts
echo 'Done setting up host file'

# 

# Install composer
echo 'Installing Composer...'
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
echo 'Done installing Composer'
