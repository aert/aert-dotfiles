#!/bin/sh

# packages ....................................................................

sudo dnf install -y --allowerasing vim-default-editor
sudo dnf install -y libpq-devel dconf-editor git-delta tig fd-find exa gcc g++ \
                    ripgrep cmake editorconfig powerline-fonts \
                    lsd ShellCheck shfmt \
                    aspell-ar aspell-fr aspell-en \
                    mysql-devel ImageMagick ImageMagick-devel

# gnome settings ..............................................................

gsettings set org.gnome.Terminal.Legacy.Settings headerbar false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

gsettings set org.gnome.shell.keybindings switch-to-application-1  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-2  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-3  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-4  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-5  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-6  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-7  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-8  "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-9  "[]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>7']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Super>8']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Super>9']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>0']"

dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-1  "['<Super><Shift>1']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-2  "['<Super><Shift>2']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-3  "['<Super><Shift>3']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-4  "['<Super><Shift>4']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-5  "['<Super><Shift>5']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-6  "['<Super><Shift>6']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-7  "['<Super><Shift>7']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-8  "['<Super><Shift>8']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-9  "['<Super><Shift>9']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-10 "['<Super><Shift>0']"

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
yarn global add typescript-language-server typescript
yarn global add eslint prettier prettier-eslint prettier-eslint-cli typescript javascript-typescript-langserver
gem install solargraph rubocop rubocop-rails rubocop-performance
pip install python-language-server prospector black
