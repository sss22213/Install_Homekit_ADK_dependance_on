#!/bin/bash

PACKAGE_MANAGER=opkg

DEP_PKGS="libnss-mdns \
    libnss-mdns-dev \
    hostapd \
    dnsmasq \
    avahi-autoipd \
    avahi-daemon \
    avahi-dev  \
    avahi-dnsconfd \
    qrencode \
    openssl-dev \
    sqlite3"

BLD_PKGS="clang \
    cmake \
    git \
    vim"

${PACKAGE_MANAGER} update
${PACKAGE_MANAGER} install ${DEP_PKGS}
${PACKAGE_MANAGER} install ${BLD_PKGS}

# Install mDNSResponder. Dependency for Service Discovery.
echo "================================================================================"
echo "Installing mDNSResponder."
echo "================================================================================"
# https://opensource.apple.com
VERSION="1310.100.10"
wget "https://opensource.apple.com/tarballs/mDNSResponder/mDNSResponder-${VERSION}.tar.gz"
tar zxvf mDNSResponder-${VERSION}.tar.gz
rm mDNSResponder-${VERSION}.tar.gz
rm -rf mDNSResponder-${VERSION}.tar.gz
make -C mDNSResponder-${VERSION}/mDNSPosix os=linux
make -C mDNSResponder-${VERSION}/mDNSPosix install os=linux

# Install libnfc. Dependency for accessory setup programmable NFC tag.
echo "================================================================================"
echo "Installing libnfc."
echo "================================================================================"
VERSION="1.8.0"
wget https://github.com/nfc-tools/libnfc/releases/download/libnfc-${VERSION}/libnfc-${VERSION}.tar.bz2
tar xjf libnfc-${VERSION}.tar.bz2
rm libnfc-${VERSION}.tar.bz2
cd libnfc-${VERSION}
./configure --sysconfdir=/etc --prefix=/usr
make -j2
make install
cd ..
rm -r libnfc-${VERSION}



