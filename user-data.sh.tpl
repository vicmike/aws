#!/bin/bash
apt-get update -y
apt-get upgrade -y
apt-get install -y build-essential curl nginx npm

useradd -m -s /bin/bash mikew
echo 'mikew ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
mkdir -p /home/mikew/.ssh
curl -o /home/mikew/.ssh/authorized_keys https://github.com/vicmike.keys
chown -R mikew:mikew /home/mikew/.ssh
chmod 700 /home/mikew/.ssh
chmod 600 /home/mikew/.ssh/authorized_keys

npm install -g nvm
npm install -g yarn
npm install -g typescript
npm install -g pm2

nvm install 12.15.0
nvm install 14.20.0
nvm use 14.20.0

mkdir -p /opt/docker
mkdir -p /opt/www