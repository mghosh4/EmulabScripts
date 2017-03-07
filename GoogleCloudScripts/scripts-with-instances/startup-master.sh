#!/bin/bash
sudo mount /dev/sdb1 /mnt/
apt-get update
apt-get -y install vim git
git clone https://github.com/mghosh4/EmulabScripts
