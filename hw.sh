#! /bin/bash
sudo apt-get update
sudo apt-get install nginx php php-fpm php-mysql php-mysqli  -y
sudo apt-get install mariadb-server mariadb-client -y
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service
sudo mysql -u root << EOF
CREATE DATABASE wpdb;
CREATE USER 'wpdbuser'@'localhost' IDENTIFIED BY '1234';
GRANT ALL ON wpdb.* TO 'wpdbuser'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
sudo systemctl start nginx
sudo systemctl enable php7.4-fpm
sudo systemctl start php7.4-fpm
sudo systemctl stop apache2
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
sudo mv wordpress /var/www/wordpress
sudo chown -R www-data:www-data /var/www/wordpress
sudo chmod -R 777 /var/www/wordpress
sudo cp -R wp-config-sample.php /var/www/wordpress
sudo cp -R info.php /var/www/html
sudo cp -R index.html /var/www/html
sudo cp -R default /etc/nginx/sites-available
sudo systemctl enable nginx
sudo systemctl restart nginx
sudo systemctl status nginx
echo -e "\nvse ok :/"
