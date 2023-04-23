#!/bin/bash

# This script has not been tested yet, to be used when computer is formated

BIN_FOLDER="$HOME/bin"

# make user folders
mkdir -p "$BIN_FOLDER" \
         "$GO_BIN_FOLDER" \
         2>/dev/null

function video_driver {
  if lspci | grep -qi "nvidia" ; then
      if uname -a | grep -qi "ubuntu" ; then
          echo "nvidia-driver-390"
      else
          echo "nvidia-driver"
      fi
  fi
}

# Install dependencies
sudo apt update
sudo apt upgrade
sudo apt install gcc\
            cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 \
            stow\
            curl fish\
            emacs vim vim-gtk xclip\
            python-pip python3-pip\
            sshpass\
            cifs-utils ecryptfs-utils\
            cowsay fonts-hack-ttf\
            git\
            "$(video-driver)"\
            tmux\
            dmenu i3 i3status i3lock xbacklight feh\
            vlc mpg123\
            gdb wireshark\
            pavucontrol\
            htop\
            redshift\
            ranger w3m caca-utils\
            youtube-dl\
            evince\
            openjdk-8-jdk\
            wine-development\
            shellcheck\
            lm-sensors\
            cloc

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#Neovim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -zxvf nvim-linux64.tar.gz
mv nvim-linux64 ~/bin/nvim-app
ln -s ~/bin/nvim-app/bin/nvim ~/bin/nvim

#Lunarvim
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

#Alacritty
cargo install alacritty

# OMF (oh-my-fish: add custom theme to fish)
curl -L https://get.oh-my.fish | fish
