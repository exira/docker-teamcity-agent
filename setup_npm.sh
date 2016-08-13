#!/bin/bash
set -e

curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get install -y nodejs
#apt-get install -y nodejs npm
#ln -s /usr/bin/nodejs /usr/bin/node
echo Successfully installed Node and NPM

npm install bower -g
echo Successfully installed Bower
