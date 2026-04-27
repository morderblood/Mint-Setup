# System
sudo apt update && sudo apt upgrade -y
sudo apt install -y firefox gzip gunzip vlc clamtk gimp git

# Language
sudo apt install -y language-pack-ru language-pack-gnome-ru
sudo locale-gen ru_RU.UTF-8
sudo update-locale LANG=ru_RU.UTF-8
setxkbmap -layout "de,ru" -option "grp:alt_shift_toggle" 
gsettings set org.cinnamon.desktop.input-sources sources "[('xkb', 'de'), ('xkb', 'de')]"
gsettings set org.cinnamon.desktop.wm.keybindings switch-input-source "['<Alt>Shift_L']"
# gsettings set org.gnome.desktop.input-sources xkb-options "['grp:alt_shift_toggle']"

# wallpaper
tar -xzf 'Windows-10.tar.gz' -C /home/iork/.themes/

gsettings set org.cinnamon.desktop.interface 'Windows-10'

# user config
cp user /home/iork/.config/dconf/

URL="https://github.com/luisrguerra/fluent11-icon-theme/archive/refs/tags/0.6.tar.gz"

mkdir -p ~/.icons

wget -O /tmp/fluent.tar.gz "$URL" &&
tar -xzf /tmp/fluent.tar.gz -C ~/.icons --strip-components=1 &&
rm /tmp/fluent.tar.gz

gsettings set org.cinnamon.desktop.interface icon-theme "fluent11"
