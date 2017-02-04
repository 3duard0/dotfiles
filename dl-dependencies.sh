#!/bin/bash

# This script has not been tested yet, to be used when computer is formated

BIN_FOLDER="$HOME/bin"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

apt update
apt install gcc\
                 emacs vim xclip\
                 python-pip\
                 sshpass\
                 fish\
                 git\
                 tmux\
                 dmenu i3 i3status i3lock xbacklight feh\
                 vlc mpg123 ffmpeg\
                 gdb wireshark radare2\
                 pavucontrol\
                 htop\
                 redshift\
                 ranger w3m caca-utils\
                 evince\
                 cloc

apt purge xserver-xorg-video-ati xserver-xorg-video-radeon
./$DIR/fix-intel.sh

if [ ! -d $BIN_FOLDER ]; then
    mkdir -p $BIN_FOLDER
fi

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -P "$BIN_FOLDER"
chmod +x "$BIN_FOLDER/lein"
wget https://raw.githubusercontent.com/slimm609/checksec.sh/master/checksec -P "$BIN_FOLDER"
chmod +x "$BIN_FOLDER/checksec"

sudo pip install --upgrade youtube_dl

git clone https://github.com/longld/peda.git "$HOME/peda"
echo "source ~/peda/peda.py" >> ~/.gdbinit

