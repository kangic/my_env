#/bin/bash

# global variables
target_path=$HOME
myenv_path=$PWD

# check the arguments
if [ $# -ne 0 ]; then
    target_path=$1
fi
echo "target path : $target_path"
echo "current path : $myenv_path"

# entry point
echo $1
echo $2

exit 0

##########################################################
## Install packages

# install git, curl
echo "install git, curl..."
sudo apt install git curl -y

# i3-gaps
echo "install i3-gaps..."
sudo add-apt-repository ppa:kgilmer/speed-ricer
sudo apt update
sudo apt install i3-gaps -y

# i3lock-fancy
echo "install i3lock-fancy..."
sudo apt install i3lock-fancy -y

# compton for i3 window's transparency
echo "install compton..."
sudo apt install compton -y

# feh for setting the background image
echo "install feh..."
sudo apt install feh -y

# tmux
echo "install tmux..."
sudo apt install tmux -y
ln -s ${HOME}/

# rofi
echo "install rofi..."
sudo apt install rofi -y

# nvim

# fonts
git clone https://github.com/ryanoasis/nerd-fonts --depth 1 ~/Downloads
cd ~/Downloads
mkdir ~/.fonts
cp -r nerd-fonts/patched-fonts/Meslo ~/.fonts/.
sudo fc-cache -vf ~/.fonts

# scm_breeze
git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
~/.scm_breeze/install.sh
source ~/.bashrc


##########################################################
## Settings

# update 
source ~/.bashrc
