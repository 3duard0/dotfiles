echo "Copying bin files"

if [ ! -d "$HOME/bin" ]; then
    mkdir "$HOME/bin"

fi

cp -i battery "$HOME/bin/"
