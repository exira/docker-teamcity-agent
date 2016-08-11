#!/bin/bash
set -e

apt-get install -y nodejs npm
ln -s /usr/bin/nodejs /usr/bin/node
echo Successfully installed Node and NPM

npm install bower -g
echo Successfully installed Bower
