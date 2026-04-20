#!/bin/sh

NUM_WORKSPACES=10

gsettings set org.gnome.Terminal.Legacy.Settings headerbar false
gsettings set org.gnome.desktop.wm.preferences num-workspaces "$NUM_WORKSPACES"

gsettings set "org.gnome.desktop.wm.keybindings" "close" "['<Super>q']"

for i in $(seq 1 "$NUM_WORKSPACES"); do
    key=$([ "$i" -eq 10 ] && echo 0 || echo "$i")
    [ "$i" -ne 10 ] && gsettings set "org.gnome.shell.keybindings" "switch-to-application-$i" "[]"
    gsettings set "org.gnome.desktop.wm.keybindings" "switch-to-workspace-$i" "['<Super>$key']"
    dconf write "/org/gnome/desktop/wm/keybindings/move-to-workspace-$i" "['<Super><Shift>$key']"
done
