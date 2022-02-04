#/bin/bash

# global variables
root_path=$HOME

# check the arguments
if [ $# -ne 0 ]; then
    root_path=$1
fi
echo "root_path : $root_path"

# install git
sudo apt install git -y

# create workspace & clone my git repos
mkdir ~/worksapce/github
cd ~/workspace/github
git clone https://github.com/kangic/dot_files
git clone https://github.com/kangic/dot_vimrc

# zsh
sudo apt install zsh -y

# entry point
echo $1
echo $2

# i3-gaps
sudo add-apt-repository ppa:kgilmer/speed-ricer
sudo apt update
sudo apt install i3-gaps -y

# tmux
sudo apt install tmux -y
ln -s ${HOME}/github.com/kangic/dot_files/

# tmux plugin
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# install tmux plugin 

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

# update 
#source ~/.zshrc
