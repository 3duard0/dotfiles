#!/bin/bash

echo "Type root password to install sudo and add $USER to sudo group"
su -c "apt install sudo;\
       echo 'Adding sudo group to \"$USER\"';\
       usermod -aG sudo,wheel,docker \"$USER\"" root

echo "Type $USER password to get a shell with the new sudo group"
su - "$USER"
