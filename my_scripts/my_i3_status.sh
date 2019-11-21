#!/bin/sh

i3status | while :
do
    read line
    tplink=`python3 ~/bin/my_scripts/my_tplink_status.py`
    echo "$tplink | $line" || exit 1
done
