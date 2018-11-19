#!/bin/bash
sudo apt install inotify-tools build-essential libssl-dev libcrypto++-dev pkg-config libtool python-dev automake autoconf
git clone https://github.com/facebook/watchman.git
cd watchman
git checkout v4.9.0  # the latest stable release
./autogen.sh
./configure
make
sudo make install
