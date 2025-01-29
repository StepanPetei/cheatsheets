#Este script esta creado con el fin de facilitar y acelerar 
#el proceso de instalación de modulos necesarios para funcionamiento 
#del sistema como el servidor web
#Es necesario ejecutarlo con los derechos de superusuario o administrador.
#Es decir, para ejecutarlo hace falta empezar desde "sudo".
clear
#Aqui podras declarar necesarios puertos TCP e aplicaciones que hará falta abrir en cortafuegos
declare -a tcp_ports=(21 22 53 57 80 123 443 1000 1645 1646 3389 5432 5433 10000)
declare -a apps=("HTTP" "HTTPS" "Apache" "Nginx" "OpenSSH")

#Aqui podras declarar la lista de paquetes que te pareceran útiles para
#empezar el trabajo con el sistema como con el servidor
declare -a packages=("gdebi" "neofetch" "net-tools" "htop" "git" "xrdp" "nginx" "apache2" "openssh-client" "openssh-server" "curl" "docker.io" "docker-compose" "certbot" "python3-certbot-nginx")

#Aqui podrás declarar los servicios que hace falta iniciar
declare -a services=("sshd" "apache2" "nginx" "docker")

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
# Verificar versión de Node.js e instalar si es necesario
if [[ $(node -v | cut -d'.' -f1 | tr -d 'v') -le 20 ]]; then
    nvm install 22
fi
apt update && apt upgrade && apt dist-upgrade

#Segundo paso: inicialización del cortafuegos y
#apertura de los puertos TCP clave que se han declarado en array "tcp_ports"
ufw start
ufw enable
for port in "${tcp_ports[@]}"; do
    ufw allow "$port"/tcp
done
#Habilitamos excepciones para apps en cortafuegos
for app in "${apps[@]}"
do
    ufw allow from any to any $app
done

echo "Configuración del firewall completada."

#Agregamos usuarios para protocolos con cifrado al grupo
usermod -aG docker $USER
adduser xrdp ssl-cert

#Tercer paso: lanzamiento de los servicios utilizando systemctl
for service in "${services[@]}"
do
    systemctl start $service
    systemctl enable $service
done



apt update && apt upgrade && apt dist-upgrade
clear
echo "Listo! Reiniciando el sistema para proceder a los ajustes particulares de cada paquete para personalizar el sistema en 10 segundos. Para abortar el reinicio pulsa Ctrl+C"
delay 10
reboot