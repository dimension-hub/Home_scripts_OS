#!/bin/zsh

# Getting from special variables
user=$USER
path=$PATH
home=$HOME
myhost=localhost
mygtw="8.8.8.8"


cd ~; clear


read -p "Update the folder apt and file sources.list? Enter [y/n]:" choice
if   [ $choice == y ]; then
        sudo mv $home/Home_script_OS/apt/sources.list /etc/apt/sources.list

elif [ $choice == n ]; then
        echo "Warning this can negatively affect other processes!"

else echo "Parameter Unknown, sorry!" && sleep 2 && exit
fi


read -p "Check your internet connection? Enter [y/n]:" choice
case $choice in
            y) ping -c 4 $myhost && ping -c 4 $mygtw;;
            n) sleep 2;;
            *) echo "Parameter Unknown, sorry!"
esac


sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y
sudo apt-get install -y apt-transport-https ca-certificates curl openssh-server git vim net-tools zsh tree mc \
    software-properties-common make open-vm-tools-desktop fuse linux-headers-$(uname -r) dkms telegram-desktop \
    htop gnome-disk-utility

