#/bin/bash

# global variables
root_path=$HOME

# check the arguments
if [ $# -ne 0 ]; then
    root_path=$1
fi
echo "root_path : $root_path"

# zsh
sudo apt install zsh -y

# entry point
echo $1
echo $2

# update 
#source ~/.zshrc
