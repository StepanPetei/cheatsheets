#Este script esta creado con el fin de facilitar y acelerar 
#el proceso de instalación de modulos necesarios para funcionamiento 
#del sistema como el servidor web
#Es necesario ejecutarlo con los derechos de superusuario o administrador.
#Es decir, para ejecutarlo hace falta empezar desde "sudo".
clear
#Aqui podras declarar necesarios puertos TCP e aplicaciones que hará falta abrir en cortafuegos
declare -a tcp_ports=(20 21 22 26 53 57 69 80 115 123 152 443 989 990 1000 1645 1646 3389 5432 5433 10000)
#declare -a apps=("HTTP" "HTTPS" "Apache" "Nginx" "OpenSSH")

#Aqui podras declarar la lista de paquetes que te pareceran útiles para
#empezar el trabajo con el sistema como con el servidor
declare -a packages=("gdebi" "neofetch" "net-tools" "htop" "btop" "git" "xrdp" "nginx" "apache2" "openssh-client" "openssh-server" "vsftpd" "curl" "docker.io" "docker-compose" "certbot" "python3-certbot-nginx" "nodejs" "npm")

#Aqui podrás declarar los servicios que hace falta iniciar
declare -a services=("ssh" "nginx" "docker")

if [[ $EUID -ne 0 ]]; then
    echo "Este script debe ejecutarse como root o con sudo."
    exit 1
fi

apt update && apt upgrade && apt dist-upgrade
#Primer paso: instalación de paquetes declarados en array "packages"
echo "Instalando paquetes..."
for package in "${packages[@]}"; do
    apt install -y $package
done
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

#Despues de instalar nvm lanza nodejsupdate.sh para que se actualize automaticamente mediante nvm instalado en la linea 29

#Segundo paso: inicialización del cortafuegos y
#apertura de los puertos TCP clave que se han declarado en array "tcp_ports"
ufw enable
ufw start
for port in "${tcp_ports[@]}"; do
    ufw allow "$port"/tcp
done
#Esta linea sirve para abrir puerto para peticiones DNS
ufw allow 53/udp
#Habilitamos excepciones para apps en cortafuegos/ Upd.: no es necesario pero dejo este trozo de codigo por si necesita proceder para otras apps que podeis declarar en array "apps"
#for app in "${apps[@]}"
#do
#    ufw allow from any to any $app
#done

echo "Configuración del firewall completada."

#Agregamos usuarios para protocolos con cifrado al grupo
usermod -aG docker $USER
adduser xrdp ssl-cert

#Tercer paso: lanzamiento de los servicios utilizando systemctl
for service in "${services[@]}"
do
    systemctl enable $service
    systemctl start $service
done

echo "Listo! Cerrando el terminal en 10 segundos. Para abortar el cierre pulsa Ctrl+C"
sleep 10
exit
