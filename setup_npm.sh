#!/bin/bash
set -e

curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get install -y nodejs
echo Successfully installed Node and NPM

npm install bower -g
echo Successfully installed Bower

npm install octopus-deploy -g
echo Successfully installed Octopus Deploy Helpers
