if [[ $EUID -ne 0 ]]; then
    echo "Este script debe ejecutarse como root o con sudo."
    exit 1
fi
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
mv wordpress /var/www/html/
chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress
mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
#sed -i 's/database_name_here/wordpress/g' /var/www/html/wordpress/wp-config.php
#sed -i 's/username_here/wordpress/g' /var/www/html/wordpress/wp-config.php
#sed -i 's/password_here/wordpress/g' /var/www/html/wordpress/wp-config.php
#sed -i 's/localhost/wordpress/g' /var/www/html/wordpress/wp-config.php
#sed -i 's/utf8/utf8mb4/g' /var/www/html/wordpress/wp-config.php
systemctl restart php-fpm
systemctl restart nginx.service
systemctl enable php-fpm nginx.service
systemctl status php-fpm
sleep 3
systemctl status nginx.service
sleep 3
# mysql -u root -p
#a2ensite wordpress
#systemctl reload nginx.service