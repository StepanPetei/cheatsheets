if [[ $EUID -ne 0 ]]; then
    echo "Este script debe ejecutarse como root o con sudo."
    exit 1
fi
apt install -y zsh
chsh -s $(which zsh)
echo $SHELL
sleep(5)
zsh --version
sleep(5)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"