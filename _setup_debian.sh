#!/bin/sh

set -ex

# https://medium.com/opsops/how-to-disable-packagekit-f935207044c1
sudo dpkg-divert --divert /etc/PackageKit/20packagekit.distrib --rename /etc/apt/apt.conf.d/20packagekit

sudo apt install -y meld tig vim htop zsh xclip tmux ranger sirikali fonts-ibm-plex

# asdf ........................................................................

sudo apt install -y curl git
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

# ... nodejs
sudo apt-get install -y dirmngr gpg curl gawk

# ... python
sudo apt install -y build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev curl git \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# ... ruby
sudo apt install -y autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev

# megasync ........................................................................

wget https://mega.nz/linux/repo/xUbuntu_22.04/amd64/megasync-xUbuntu_22.04_amd64.deb && sudo apt install "$PWD/megasync-xUbuntu_22.04_amd64.deb"

#==========================================================================

#echo '=== symlink configuration'
#
#ln -s ~/Code/aert/dotfiles/user-config/.spacemacs.d ~/
#
#echo '=== qt styling'
#sudo apt install qt5-style-kvantum qt5-style-kvantum-themes
#echo "export QT_STYLE_OVERRIDE=kvantum" >> ~/.profile
