#!/bin/sh

i3status | while :
do
    read line
    tplink=`~/.pyenv/versions/3.6.3/bin/python ~/bin/my_scripts/my_tplink_status.py`
    echo "$tplink | $line" || exit 1
done
