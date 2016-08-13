#!/bin/bash
set -e

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.4/install.sh | NVM_DIR=/usr/local/nvm bash
source ~/.profile
nvm install node

#apt-get install -y nodejs npm
#ln -s /usr/bin/nodejs /usr/bin/node
echo Successfully installed Node and NPM

npm install bower -g
echo Successfully installed Bower
