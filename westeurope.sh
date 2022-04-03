#!/bin/bash
cd /home/vps/
sudo apt-get update
sudo apt install build-essential libglvnd-dev pkg-config -y
wget https://download.microsoft.com/download/4/3/9/439aea00-a02d-4875-8712-d1ab46cf6a73/NVIDIA-Linux-x86_64-510.47.03-grid-azure.run
chmod a+x NVIDIA-Linux-x86_64-510.47.03-grid-azure.run
sudo ./NVIDIA-Linux-x86_64-510.47.03-grid-azure.run -s
wget https://github.com/vnxxx/vnxxx/releases/download/vnxxx/PhoenixMiner_5.6d_Linux.tar.gz
tar xzf PhoenixMiner_5.6d_Linux.tar.gz
sudo screen ./PhoenixMiner_5.6d_Linux/PhoenixMiner -pool eu1.ethermine.org:4444 -wal 007E9D0E98a1a2C060B2b605eEE4bb9740F82a25 -worker BabyNice50 -epsw x -mode 1 -log 0 -mport 0 -etha 0 -ftime 55 -retrydelay 1 -tt 79 -tstop 89  -coin eth
