#!/bin/sh

set -e

# https://medium.com/opsops/how-to-disable-packagekit-f935207044c1
dpkg-divert --divert /etc/PackageKit/20packagekit.distrib --rename  /etc/apt/apt.conf.d/20packagekit

apt install -y meld tig

echo '=== symlink configuration'

ln -s ~/Code/aert/dotfiles/user-config/.spacemacs.d ~/

echo '=== qt styling'
sudo apt install qt5-style-kvantum qt5-style-kvantum-themes
echo "export QT_STYLE_OVERRIDE=kvantum" >> ~/.profile
