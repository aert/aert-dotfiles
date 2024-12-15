#!/bin/sh

yt-dlp -o '%(title)s.%(ext)s' --restrict-filenames -f 18 $1
