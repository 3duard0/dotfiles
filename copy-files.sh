#!/bin/bash

BIN_FOLDER="$HOME/bin"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p $BIN_FOLDER
cp -R $DIR/bin/* "$BIN_FOLDER"
cp -R "$DIR/fish/config.fish" "$HOME/.config/fish"
cp -R "$DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
cp -R $DIR/vim/.vim/* "$HOME/.vim"
cp -R "$DIR/vim/.vimrc" "$HOME/.vimrc"

cp -R "$DIR/i3/.i3" "$HOME/.config/i3"
sudo cp "$DIR/i3/i3status.conf" "/etc/i3status.conf"
