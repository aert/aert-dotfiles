#!/bin/sh

# sudo dnf install libpq-devel

# disable gnome packagekit ....................................................

sudo systemctl stop packagekit.service
sudo systemctl disable packagekit.service
sudo systemctl mask packagekit.service
sudo systemctl stop packagekit-offline-update.service
sudo systemctl disable packagekit-offline-update.service
sudo systemctl mask packgekit-offline-update.service

# dev tools ...................................................................

# neovim plugins
pip install neovim python-language-server
gem install neovim
yarn global add neovim

# language servers
yarn global add eslint prettier prettier-eslint prettier-eslint-cli typescript javascript-typescript-langserver
yarn global add import-js
gem install solargraph rubocop rubocop-rails rubocop-performance
pip install python-language-server prospector
