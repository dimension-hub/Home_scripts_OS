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
        sudo cp $home/Home_scripts_OS/apt/sources.list /etc/apt/sources.list

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

clear
echo "
        ##############################################################################
             Beginning update, upgrade and installing the necessary applications!
        ##############################################################################
" && sleep 2

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y
sudo apt-get install -y apt-transport-https ca-certificates curl openssh-server git vim net-tools zsh tree mc \
    software-properties-common make open-vm-tools-desktop fuse linux-headers-$(uname -r) dkms telegram-desktop \
    htop gnome-disk-utility neofetch

clear
echo "
             ##############################################
                        Installing Virtualbox!
             ###############################################
" && sleep 2
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/virtualbox-archive-keyring.gpg && clear

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/virtualbox-archive-keyring.gpg] http://download.virtualbox.org/virtualbox/debian buster contrib" \
  | sudo tee /etc/apt/sources.list.d/virtualbox.list

sudo apt update && sudo apt install -y virtualbox virtualbox-ext-pack && sleep 1 && clear

echo "
             ##############################################
                    Installing Visual Studio Code!
             ###############################################
" && sleep 2
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

sudo apt update && sudo apt install -y code && sleep 1 && clear

echo "
             ##############################################
                      Installing Chrome browser!
             ###############################################
" && sleep 2
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

sudo apt update && sudo apt install -y google-chrome-stable && sleep 1 && clear

echo "
             ##############################################
                  Installing Docker and Docker-compose!
             ###############################################
" && sleep 2
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" | sudo tee  /etc/apt/sources.list.d/docker.list

sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io && sleep 1 && clear

sudo apt-get install -y docker-compose && sleep 1 && clear && sudo chmod +x /usr/bin/docker-compose
echo "
             ########################################################
                  The process of adding Docker in a group sudo!
             ########################################################
" && sleep 2
sudo usermod -aG docker ${USER} && id -nG && sudo usermod -aG docker $user && clear
sudo systemctl start docker && sudo systemctl enable docker && clear
docker-compose --version && sleep 3
