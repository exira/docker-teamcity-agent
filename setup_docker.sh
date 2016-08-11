#!/bin/bash
set -e

wget -P /tmp https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz
tar -xzf /tmp/docker-latest.tgz -C / && rm /tmp/docker-latest.tgz
echo Successfuly installed docker client
