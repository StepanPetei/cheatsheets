if [[ $(node -v | cut -d'.' -f1 | tr -d 'v') -le $20 ]]; then
    nvm install 22
fi

npm install -g npm@latest