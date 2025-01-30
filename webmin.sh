if [[ $EUID -ne 0 ]]; then
    echo "Este script debe ejecutarse como root o con sudo."
    exit 1
fi
apt install -y software-properties-common apt-transport-https
wget -q http://www.webmin.com/jcameron-key.asc -O- | apt-key add -
add-apt-repository "deb [arch=amd64] http://download.webmin.com/download/repository sarge contrib"
apt install -y webmin
systemctl status webmin