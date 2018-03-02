#!/bin/bash

PACKAGES_DIR="config"

for package in `ls $PACKAGES_DIR`;
do
    echo "installing package: $package"
    stow -d $PACKAGES_DIR -t $HOME --verbose=1 $package
done

