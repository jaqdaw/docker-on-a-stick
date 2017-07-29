#! /bin/bash
set -x
cd

sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"

# Stop Services
sudo service lightdm stop
sudo service snapd stop
sudo service NetworkManager stop
sudo service ModemManager stop
sudo service whoopsie stop
sudo service upower stop
sudo service cups stop
sudo service cups-browsed stop

# Add Packages
sudo apt-get update
sudo apt-get install curl gfortran mc htop nmap nano ufw sysbench python3 w3m vlock vim tmux mutt git tig wicd-cli wicd-curses
sudo apt-get -y autoremove
sudo apt-get -y autoclean
sudo updatedb
sudo ldconfig -v

# Copy doasbuild/doas
cp /media/ubuntu/usbdata/doasbuild/bash/.bash_profile ~/.bash_profile
cp /media/ubuntu/usbdata/doasbuild/bash/.bashrc ~/.bashrc
cp /media/ubuntu/usbdata/doasbuild/bash/.profile ~/.profile
cp -fr /media/ubuntu/usbdata/doasbuild/codebase ~/codebase
cp -fr /media/ubuntu/usbdata/doasbuild/mutt ~/.mutt
cp -fr /media/ubuntu/usbdata/doasbuild/script ~/script
cp -fr /media/ubuntu/usbdata/doasbuild/ssh ~/.ssh
cp -fr /media/ubuntu/usbdata/doasbuild/tmux ~/.tmux
cp -fr /media/ubuntu/usbdata/doasbuild/vim ~/.vim
cp -fr /media/ubuntu/usbdata/docker-on-a-stick ~/docker-on-a-stick
sudo chown -R ubuntu:ubuntu ~/*

# Create file links
ln -s ~/.mutt/muttrc ~/.muttrc
ln -s ~/.tmux/tmux.conf ~/.tmux.conf
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/vimrc.local ~/.vimrc.local

# Get powershell
cd ~/Downloads
wget https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-alpha.17/powershell_6.0.0-alpha.17-1ubuntu1.16.04.1_amd64.deb
sudo dpkg -i powershell_6.0.0-alpha.17-1ubuntu1.16.04.1_amd64.deb
sudo apt-get install -f
cd

# Sort out wcid
sudo adduser ubuntu netdev
sudo service dbus reload
sudo service wicd stop
sudo service wicd start

# Kill unwanted services
sudo systemctl disable lightdm
sudo systemctl disable snapd
sudo systemctl disable NetworkManager
sudo systemctl disable ModemManager
sudo systemctl disable whoopsie
sudo systemctl disable upower
sudo systemctl disable cups
sudo systemctl disable cups-browsed

# Install Docker
cd ~/Downloads
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ubuntu
cd
rm ~/Downloads/*