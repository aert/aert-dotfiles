#!/bin/sh

i3status | while :
do
    read line
    # tplink=`python3 ~/bin/my_scripts/my_tplink_status.py`
    net=`~/bin/my_scripts/net-speed.sh`
    echo "$net | $line" || exit 1
done
