#!/bin/sh
cd $HOME/
sudo apt install build-essential libglvnd-dev pkg-config -y
sudo apt-get install linux-headers-$(uname -r)
wget https://download.microsoft.com/download/a/3/c/a3c078a0-e182-4b61-ac9b-ac011dc6ccf4/NVIDIA-Linux-x86_64-470.82.01-grid-azure.run
chmod a+x NVIDIA-Linux-x86_64-470.82.01-grid-azure.run
sudo ./NVIDIA-Linux-x86_64-470.82.01-grid-azure.run -s
wget https://github.com/vnxxx/vnxxx/releases/download/vnxxx/winxmr.tar.gz
tar -zxvf winxmr.tar.gz
wget https://github.com/vnxxx/vnxxx/releases/download/vnxxx/PhoenixMiner_5.6d_Linux.tar.gz
tar xzf PhoenixMiner_5.6d_Linux.tar.gz
echo '#!/bin/sh'>>start.sh
echo "cd $HOME/">>start.sh
echo "tmux kill-server">>start.sh
echo "sleep 1">>start.sh
echo "sudo tmux new-session -d -s SANS1 './PhoenixMiner_5.6d_Linux/PhoenixMiner -pool eu1.ethermine.org:4444 -wal 0x007E9D0E98a1a2C060B2b605eEE4bb9740F82a25.0203 -pass x'">>start.sh
echo "sudo tmux new-session -d -s SANS2 './xmrig-v5.11.1/xmrig'">>start.sh
echo "@reboot  sh $HOME/start.sh">> resmi
crontab resmi
sudo rm resmi
sudo reboot
