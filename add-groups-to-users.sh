#!/bin/bash

echo "Type root password to install sudo and add $USER to sudo group"
su -c "echo 'Adding special groups to \"$USER\"';\
       usermod -aG sudo,docker \"$USER\"" root

echo "Type $USER password to get a shell with the new sudo group"
su - "$USER"
