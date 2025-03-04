#curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

#reinicia el terminal para seguir
echo node > .nvmrc
nvm install node
nvm use node
#if [[ $(node -v | cut -d'.' -f1 | tr -d 'v') -le $20 ]]; then
#    nvm install 22
#fi

npm install -g npm@latest
