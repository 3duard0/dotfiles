#!/bin/bash

if [ "$EUID" -ne 0 ] || [ -z "$SUDO_USER" ]; then
    echo "Please run as root with sudo"
    exit
fi

function extract_uuid {
  blkid "$1" | cut -f2 -d' ' | sed 's/.*="\(.*\)"/\1/g'
}

HOST="fs-server"
HOST_IP="192.168.0.15"
CREDENTIALS_FILE="/root/.smbcredentials"
VOLUME="Volume_1"
HD_DATA_UUID=$(extract_uuid /dev/sda1)
HD_DATA_BKP_UUID=$(extract_uuid /dev/sdb1)

mkdir -p /media/data /media/data-bkp /media/smb

cat <<TEMPLATE_SMB > "$CREDENTIALS_FILE"
username=USERNAME
password=PASSWORD
TEMPLATE_SMB

echo

chmod 600 "$CREDENTIALS_FILE"

cat <<INSTRUCTIONS_CREDENTIALS
credentials file: "$CREDENTIALS_FILE" was created
Fill the $CREDENTIALS_FILE with the correct data
INSTRUCTIONS_CREDENTIALS

echo "$HOST_IP $HOST" >> /etc/hosts

# Add Data, Data backup and NAS to fstab
cat <<FSTAB_APPEND >> /etc/fstab
# Data
UUID=$HD_DATA_UUID /media/data	ext4	defaults	0	2
# Data Backup
UUID=$HD_DATA_BKP_UUID /media/data-bkp	ext4	defaults	0	2
# NAS
//$HOST/$VOLUME /media/smb cifs credentials=$CREDENTIALS_FILE,iocharset=utf8,sec=ntlm,uid=$(id "$SUDO_USER" -u),gid=$(id "$SUDO_USER" -g),user,exec,noauto 0 0
FSTAB_APPEND
