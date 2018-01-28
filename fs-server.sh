#!/bin/bash
# RUN AS ROOT PLEASE :)

HOST="fs-server"
HOST_IP="192.0.0.2"
CREDENTIALS_FILE="/root/.smbcredentials"
VOLUME="Volume_1"

mkdir -p /media/smb

cat <<TEMPLATE_SMB > "$CREDENTIALS_FILE"
username=REPLACE_USERNAME_HERE
password=REPLACE_PASSWORD_HERE
TEMPLATE_SMB

echo

chmod 600 "$CREDENTIALS_FILE"

cat <<INSTRUCTIONS_CREDENTIALS
credentials file: "$CREDENTIALS_FILE" was created
Fill the $CREDENTIALS_FILE with the correct data
INSTRUCTIONS_CREDENTIALS

echo "$HOST_IP $HOST" >> /etc/hosts
echo "//$HOST/$VOLUME /media/smb cifs credentials=$CREDENTIALS_FILE,iocharset=utf8,sec=ntlm 0 0" >> /etc/fstab
