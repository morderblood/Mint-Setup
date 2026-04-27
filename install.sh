# System
sudo apt update && sudo apt upgrade -y
sudo apt install -y firefox vlc clamtk gimp

# Language
sudo apt install -y language-pack-ru language-pack-gnome-ru
sudo locale-gen ru_RU.UTF-8
sudo update-locale LANG=ru_RU.UTF-8
setxkbmap -layout "de,ru" -option "grp:alt_shift_toggle" 
gsettings set org.cinnamon.desktop.input-sources sources "[('xkb', 'de'), ('xkb', 'de')]"
gsettings set org.cinnamon.desktop.wm.keybindings switch-input-source "['<Alt>Shift_L']"
# gsettings set org.gnome.desktop.input-sources xkb-options "['grp:alt_shift_toggle']"

# wallpaper
