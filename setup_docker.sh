#!/bin/bash
set -e

#wget -P /tmp https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz
wget -P /tmp https://get.docker.com/builds/Linux/x86_64/docker-1.11.2.tgz
tar -xzf /tmp/docker-1.11.2.tgz -C / && rm /tmp/docker-1.11.2.tgz
ln -s /docker/docker /usr/local/bin/docker
echo Successfuly installed docker client
