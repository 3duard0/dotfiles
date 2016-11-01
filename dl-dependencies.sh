#!/bin/bash

# This script has not been tested yet, to be used when computer is formated

BIN_FOLDER="$HOME/bin"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt-get update
sudo apt install gcc\
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
                 cloc

cp "$DIR/bin/*" "$BIN_FOLDER"

git clone https://raw.githubusercontent.com/slimm609/checksec.sh/master/checksec "$BIN_FOLDER"
git clone https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein "$BIN_FOLDER"

sudo pip install --upgrade youtube_dl

git clone https://github.com/longld/peda.git "$HOME/peda"
echo "source ~/peda/peda.py" >> ~/.gdbinit
echo "DONE! debug your program with gdb and enjoy"
