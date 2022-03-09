#!/bin/sh 
sudo apt update 
sudo apt upgrade -y 
sudo apt-get install -y tmux 
cd /tmp 
wget https://raw.githubusercontent.com/winttr89/2022/main/start1.sh
sudo -H -u azureuser bash -c 'tmux new-session -d -s install "bash /tmp/start.sh"'
