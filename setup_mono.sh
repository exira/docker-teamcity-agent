#!/bin/bash
set -e

apt-get update && apt-get install -y mono-complete
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list
apt-get update && apt-get install -y mono-devel mono-complete ca-certificates-mono mono-4.0-service libmono-cil-dev
echo Successfully installed Mono
