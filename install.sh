#!/bin/bash
set -e

# System
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt update

# Flatpak / Flathub
sudo apt install -y --fix-missing flatpak wget git
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install programs
sudo apt install -y --fix-missing firefox vlc gimp git clamtk
flatpak install -y flathub \
  org.telegram.desktop \
  com.anydesk.Anydesk \
  com.rustdesk.RustDesk \
  org.onlyoffice.desktopeditors

# Language
sudo apt install -y language-pack-ru language-pack-gnome-ru
sudo locale-gen ru_RU.UTF-8
sudo update-locale LANG=ru_RU.UTF-8

# Keyboard
gsettings set org.cinnamon.desktop.input-sources sources "[('xkb', 'de'), ('xkb', 'ru')]"
gsettings set org.cinnamon.desktop.wm.keybindings switch-input-source "['<Alt>Shift_L']"

# Icons
mkdir -p ~/.icons
TMP_DIR="$(mktemp -d)"
cd "$TMP_DIR"

wget -O fluent-icons.tar.gz https://github.com/luisrguerra/fluent11-icon-theme/archive/refs/tags/0.6.tar.gz
tar -xzf fluent-icons.tar.gz

cp -r fluent11-icon-theme-*/fluent11 "$HOME/.icons/"

cd ~
rm -rf "$TMP_DIR"

gsettings set org.cinnamon.desktop.interface icon-theme 'fluent11'

# Theme
THEME="Windows-10"
URL="https://github.com/linuxmint/cinnamon-spices-themes/archive/refs/heads/master.tar.gz"

mkdir -p ~/.themes
TMP_DIR="$(mktemp -d)"
cd "$TMP_DIR"

wget -O themes.tar.gz "$URL"
tar -xzf themes.tar.gz

rm -rf "$HOME/.themes/$THEME"
cp -r "cinnamon-spices-themes-master/$THEME/files/$THEME" "$HOME/.themes/"

cd ~
rm -rf "$TMP_DIR"

gsettings set org.cinnamon.theme name "Windows-10"
gsettings set org.cinnamon.desktop.wm.preferences theme "Windows-10"
gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-Y-Dark-Grey'

# Cursor
gsettings set org.cinnamon.desktop.interface cursor-theme 'DMZ-White'

# dconf settings
if [ -f "./user" ]; then
  dconf load / < ./user
fi

bash desktop.sh
bash wallpaper.sh
bash avatar.sh
