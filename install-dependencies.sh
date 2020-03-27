#!/bin/bash

# This script has not been tested yet, to be used when computer is formated

BIN_FOLDER="$HOME/bin"
GO_BIN_FOLDER="$HOME/dev/go/bin"

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

# Wal (terminal theme)
pip3 install wal

# Vundle (vim plugins manager)
git clone "https://github.com/VundleVim/Vundle.vim.git" ~/.vim/bundle/Vundle.vim

# Leiningen (clojure build tools)
wget --show-progress "https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein" -P "$BIN_FOLDER"
chmod +x "$BIN_FOLDER/lein"

# Golang
GO_VERSION="1.12.1"
wget --show-progress "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz" -O /tmp/go.tar.gz
sudo tar -C /usr/local -zxf /tmp/go.tar.gz
rm /tmp/go.tar.gz

# Tmuxinator
sudo gem install tmuxinator

# Cat highlight replacement
BAT_VERSION="0.9.0"
curl -L "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb" > "/tmp/bat.deb"
sudo dpkg -i /tmp/bat.deb
rm /tmp/bat.deb

# OMF (oh-my-fish: add custom theme to fish)
curl -L https://get.oh-my.fish | fish
