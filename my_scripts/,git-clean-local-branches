#!/bin/sh

set -ex

git fetch -p
git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -d
