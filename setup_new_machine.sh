#!/bin/sh

# packages ....................................................................

sudo dnf install -y --allowerasing vim-default-editor
sudo dnf install -y libpq-devel dconf-editor git-delta tig fd-find exa gcc g++ \
                    ripgrep cmake editorconfig powerline-fonts \
                    lsd ShellCheck shfmt \
                    aspell-ar aspell-fr aspell-en \
                    mysql-devel ImageMagick ImageMagick-devel
# for asdf python
sudo dnf install make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel

# latex
sudo dnf install python3-sphinx-latex

# kde settings ..............................................................

kwriteconfig5 --file ~/.config/kwinrc --group Windows --key BorderlessMaximizedWindows true
qdbus org.kde.KWin /KWin reconfigure

# disable gnome packagekit ....................................................

sudo systemctl stop packagekit.service
sudo systemctl disable packagekit.service
sudo systemctl mask packagekit.service
sudo systemctl stop packagekit-offline-update.service
sudo systemctl disable packagekit-offline-update.service
sudo systemctl mask packgekit-offline-update.service

# dev tools ...................................................................

# neovim plugins
pip install neovim
gem install neovim
yarn global add neovim
npm install -g neovim

# language servers
npm install -g typescript-language-server typescript
npm install -g eslint prettier prettier-eslint prettier-eslint-cli typescript javascript-typescript-langserver
gem install solargraph rubocop rubocop-rails rubocop-performance
pip install wheel python-language-server prospector black

# org-mode: sql

gem install sqlint
wget -q -O - https://github.com/mjibson/sqlfmt/releases/latest/download/sqlfmt_0.4.0_linux_amd64.tar.gz | tar -xpvzf - --directory "$HOME/bin/"
sudo sudo apt install mysql-client
