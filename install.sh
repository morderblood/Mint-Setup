#!/bin/bash

# System
sudo apt update && sudo apt upgrade -y
sudo apt install -y firefox vlc gimp git clamtk

# Language
sudo apt install -y language-pack-ru language-pack-gnome-ru
sudo locale-gen ru_RU.UTF-8
sudo update-locale LANG=ru_RU.UTF-8
export LANG=ru_RU.UTF-8

# Keyboard
gsettings set org.cinnamon.desktop.input-sources sources "[('xkb', 'de'), ('xkb', 'ru')]"
gsettings set org.cinnamon.desktop.wm.keybindings switch-input-source "['<Alt>Shift_L']"

# Themes (global)
sudo cp -r fluent11 /usr/share/icons/
sudo cp -r Windows-10 /usr/share/themes/

gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-Y-Dark-Grey'
gsettings set org.cinnamon.desktop.interface icon-theme 'fluent11'
gsettings set org.cinnamon.desktop.wm.preferences theme "Windows-10"

# dconf settings
dconf load / < user
