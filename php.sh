if [[ $EUID -ne 0 ]]; then
    echo "Este script debe ejecutarse como root o con sudo."
    exit 1
fi
apt install php php-cli php-cgi php-fpm php-mysql php-pqsql #php-mbstring php-curl php-zip php-gd php-imagick php-redis php-memcached php-mongodb php-sqlite3 php-xdebug php-pear php-dev
php -v
sleep 5
php -m
sleep 5
php -i
sleep 5
systemctl start php-fpm
systemctl restart nginx.service
systemctl enable php-fpm nginx.service
systemctl status php-fpm
# php -S localhost:8000
sleep 3
systemctl status nginx.service
sleep 3
echo '<?php phpinfo(); ?>' > /usr/share/nginx/html/index.php
##
#/etc/nginx/nginx.conf - nginx configuración principal
#/etc/nginx/conf.d/php-fpm.conf - Configuración de FPM para nginx
#/etc/php-fpm.conf - Configuración principal del FPM
#/etc/php-fpm.d/www.conf - configuración por defecto de la piscina www
#
#
#
#
# php -S localhost:8000 -t /var/www/html
# php -S localhost:8000 -t /var/www/html -d display_errors=1
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log -d memory_limit=128M
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log -d memory_limit=128M -d max_execution_time=60
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log -d memory_limit=128M -d max_execution_time=60 -d post_max_size=8M
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log -d memory_limit=128M -d max_execution_time=60 -d post_max_size=8M -d upload_max_filesize=2M
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log -d memory_limit=128M -d max_execution_time=60 -d post_max_size=8M -d upload_max_filesize=2M -d max_input_time=60
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log -d memory_limit=128M -d max_execution_time=60 -d post_max_size=8M -d upload_max_filesize=2M -d max_input_time=60 -d max_input_vars=1000
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log -d memory_limit=128M -d max_execution_time=60 -d post_max_size=8M -d upload_max_filesize=2M -d max_input_time=60 -d max_input_vars=1000 -d session.gc_maxlifetime=1440
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log -d memory_limit=128M -d max_execution_time=60 -d post_max_size=8M -d upload_max_filesize=2M -d max_input_time=60 -d max_input_vars=1000 -d session.gc_maxlifetime=1440 -d session.cookie_lifetime=0  # 0 means "until the browser is closed"
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log -d memory_limit=128M -d max_execution_time=60 -d post_max_size=8M -d upload_max_filesize=2M -d max_input_time=60 -d max_input_vars=1000 -d session.gc_maxlifetime=1440 -d session.cookie_lifetime=0 -d session.cookie_secure=1  # 1 means "only over HTTPS"
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log -d memory_limit=128M -d max_execution_time=60 -d post_max_size=8M -d upload_max_filesize=2M -d max_input_time=60 -d max_input_vars=1000 -d session.gc_maxlifetime=1440 -d session.cookie_lifetime=0 -d session.cookie_secure=1 -d session.cookie_httponly=1  # 1 means "only over HTTP"
# php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log -d memory_limit=128M -d max_execution_time=60 -d post_max_size=8M -d upload_max_filesize=2M -d max_input_time=60 -d max_input_vars=1000 -d session.gc_maxlifetime=1440 -d session.cookie_lifetime=0 -d session.cookie_secure=1 -d session.cookie_httponly=1 -d session.use_strict_mode=1  # 1 means "only over HTTP"
#php -S localhost:8000 -t /var/www/html -d display_errors=1 -d error_reporting=E_ALL -d log_errors=1 -d error_log=/var/log/php_errors.log -d memory_limit=128M -d max_execution_time=60 -d post_max_size=8M -d upload_max_filesize=2M -d max_input_time=60 -d max_input_vars=1000 -d session.gc_maxlifetime=1440 -d session.cookie_lifetime=0 -d session.cookie_secure=1 -d session.cookie_httponly=1 -d session.use_strict_mode=1 -d session.use_cookies=1  # 1 means "only over HTTP"