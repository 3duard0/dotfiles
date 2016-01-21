echo "Installing i3 and i3status"

apt-get install i3 i3status

cp -i .i3 ~
cp -i i3status.conf /etc/i3status.conf
