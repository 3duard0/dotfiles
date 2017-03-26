#!/bin/bash

sudo echo "options iwlwifi bt_coex_active=0 swcrypto=1 11n_disable=8" > /etc/modprobe.d/iwlwifi.conf
