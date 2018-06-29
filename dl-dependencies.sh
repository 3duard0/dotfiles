#!/bin/bash

# This script has not been tested yet, to be used when computer is formated

BIN_FOLDER="$HOME/bin"
GO_BIN_FOLDER="$HOME/go/bin"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt update
sudo apt install gcc\
            stow\
            curl fish\
            emacs vim xclip\
            python-pip\
            sshpass\
            cifs-utils ecryptfs-utils\
            cowsay fonts-hack-ttf\
            git\
	        nvidia-driver\
            tmux\
            dmenu i3 i3status i3lock xbacklight feh\
            vlc mpg123 \
            gdb wireshark radare2\
            pavucontrol\
            htop\
            redshift\
            ranger w3m caca-utils\
            youtube-dl\
            evince\
            openjdk-8-jdk\
            wine-development\
            cloc

if [ ! -d $BIN_FOLDER ]; then
    mkdir -p $BIN_FOLDER
fi

if [ ! -d $GO_BIN_FOLDER ]; then
    mkdir -p $GO_BIN_FOLDER
fi

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -P "$BIN_FOLDER"
chmod +x "$BIN_FOLDER/lein"
wget https://raw.githubusercontent.com/slimm609/checksec.sh/master/checksec -P "$BIN_FOLDER"
chmod +x "$BIN_FOLDER/checksec"

git clone https://github.com/longld/peda.git "$HOME/peda"
echo "source ~/peda/peda.py" >> ~/.gdbinit

# Fish
curl -L https://get.oh-my.fish | fish
omf install bobthefish
