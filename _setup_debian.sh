#!/bin/sh

# https://medium.com/opsops/how-to-disable-packagekit-f935207044c1
dpkg-divert --divert /etc/PackageKit/20packagekit.distrib --rename  /etc/apt/apt.conf.d/20packagekit

apt install -y meld tig
