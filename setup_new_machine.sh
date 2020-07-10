#!/bin/sh

# sudo dnf install libpq-devel

# neovim plugins
pip install neovim python-language-server
gem install neovim
yarn global add neovim

# language servers
yarn global add eslint prettier prettier-eslint prettier-eslint-cli typescript javascript-typescript-langserver
yarn global add import-js
gem install solargraph rubocop rubocop-rails rubocop-performance
pip install python-language-server prospector
