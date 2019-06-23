#!/bin/sh

youtube-dl -o '%(title)s.%(ext)s' --restrict-filenames -f 18 $1
