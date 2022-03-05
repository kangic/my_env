#/bin/bash

# options
src_path=$PWD	# do not change
target_path=$HOME
tmp_path=$HOME/temp
platform_env=0	# {"linuxde":0, "wsl":1}
passwd=""

##########################################################
## parsing arguments
### check the number of agrs
if [[ $1 = "-h" || $1 = "--help" ]]; then
	echo "Usage:  $0 -t <input> [options]" >&2
	echo "        -t | --target   	%  (set target path ...)" >&2
	echo "        -e | --platform_env 	%  (set target platform {0:linuxde, 1:wsl})" >&2
	echo "        -p | --password 	%  (input password for echo $passwd | sudo -S)" >&2
	exit 0
fi

### get options
while (( "$#" )); do
    case "$1" in
        -t|--target)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                target_path=$2
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
            ;;
        -e|--platform_env)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                platform_env=$2
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
            ;;
        -p|--password)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                passwd=$2
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
            ;;
	esac
done

if [[ $passwd = "" ]]; then
	echo "You should input the sudo password."
	exit 1
fi

echo "target path : $target_path"
echo "source path : $src_path"
if [ $platform_env -eq 0 ]; then
	echo "target platform env : linuxde"
else
	echo "target platform env : wsl"
fi


##########################################################
## make temp directory for downloading
if [ -d "$tmp_path" ]; then
	echo "temp is already exists."
else
	mkdir $tmp_path
fi

##########################################################
## make config directory for downloading
if [ -d "$HOME/.config" ]; then
	echo ".config is already exists."
else
	mkdir $HOME/.config
fi



##########################################################
## General Packages
# git, curl
echo ">>> install git, curl..."
echo $passwd | sudo -S apt install git curl -y

# build essential, gdb
echo ">>> install build-essential, gdb, cgdb..."
echo $passwd | sudo -S apt install build-essential gdb cgdb -y

##########################################################
## Desktop Environments
if [ $platform_env -eq 0 ]; then
	# i3-gaps
	echo ">>> install i3-gaps..."
	echo $passwd | sudo -S add-apt-repository ppa:kgilmer/speed-ricer
	echo $passwd | sudo -S apt update
	echo $passwd | sudo -S apt install i3-gaps -y

	# i3lock-fancy
	echo ">>> install i3lock-fancy..."
	echo $passwd | sudo -S apt install i3lock-fancy -y

	# compton for i3 window's transparency
	echo ">>> install compton..."
	echo $passwd | sudo -S apt install compton -y

	# feh for setting the background image
	echo ">>> install feh..."
	echo $passwd | sudo -S apt install feh -y

	# rofi
	echo ">>> install rofi..."
	echo $passwd | sudo -S apt install rofi -y

	# make a symlink i3 config files
	ln -s $src_path/i3_config/i3 ${HOME}/.config/.
	ln -s $src_path/i3_config/i3status ${HOME}/.config/.
fi

##########################################################
## Terminal Env
# nvim
echo ">>> install nvim..."
echo $passwd | sudo -S add-apt-repository ppa:neovim-ppa/unstable -y
echo $passwd | sudo -S apt update
echo $passwd | sudo -S apt install neovim -y
ln -s $src_path/nvim ${HOME}/.config/.

echo ">>> install nvim plugins..."
nvim --headless +PlugInstall +qall

# tmux
echo ">>> install tmux..."
echo $passwd | sudo -S apt install tmux -y
ln -s $src_path/tmux.conf ${HOME}/.tmux.conf 

# tmux plugin
echo ">>> install tmux plugins..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# install tmux plugin 
$HOME/.tmux/plugins/tpm/bin/install_plugins

# fonts
echo ">>> install fonts..."
#git clone https://github.com/ryanoasis/nerd-fonts --depth 1 $HOME/temp
if [ $platform_env -eq 0 ]; then
	mkdir $HOME/.fonts
	cp -r $HOME/temp/nerd-fonts/patched-fonts/Meslo $HOME/.fonts/.
	echo $passwd | sudo -S fc-cache -vf $HOME/.fonts
fi

# scm_breeze
echo ">>> install scm_breeze..."
git clone git://github.com/scmbreeze/scm_breeze.git $HOME/.scm_breeze
$HOME/.scm_breeze/install.sh

##########################################################
## update 
echo "It's Done. Update .bashrc!"
rm $HOME/.bashrc
ln -s $src_path/bashrc $HOME/.bashrc
source ~/.bashrc
