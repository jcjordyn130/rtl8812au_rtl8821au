#!/bin/bash

# root check
if [  "$(id -u)" != "0" ]
then
 echo "Must be root."
 exit 1
fi

# install deps
apt install git linux-headers-$(uname -r) build-essential -y

# install driver
cd /tmp
mkdir wireless_driver
cd wireless_driver
git clone https://github.com/Grawp/rtl8812au_rtl8821au.git
cd rtl8812au_rtl8821au
nice make -j$(nproc)
make install
modprobe -v 8812au
echo '8812au' >> /etc/modules
cd
rm -rv /tmp/wireless_driver
