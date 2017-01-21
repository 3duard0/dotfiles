#!/bin/bash

sudo rm /usr/share/X11/xorg.conf.d/10-amdgpu.conf

cat > /usr/share/X11/xorg.conf.d/10-intel.conf <<INTEL
Section "Device"
    Identifier "Intel Graphics"
    Driver     "intel"
EndSection
INTEL


