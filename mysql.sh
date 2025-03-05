if [[ $EUID -ne 0 ]]; then
    echo "Este script debe ejecutarse como root o con sudo."
    exit 1
fi
apt install -y mysql-server mysql-client
systemctl start mysql
systemctl enable mysql
systemctl status mysql
sleep 3
mysql -V
mysql -u root -p
# mysql> wordpress.sql
#cat wordpress.sql | sudo mysql --defaults-extra-file=/etc/mysql/debian.cnf