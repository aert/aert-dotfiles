#!/bin/sh

set -ex

git diff --name-only HEAD~5 HEAD
