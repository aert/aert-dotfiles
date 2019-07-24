#!/bin/sh

youtube-dl --extract-audio --audio-format mp3 -f 'worstaudio' -o '%(title)s.%(ext)s' --restrict-filenames $1
