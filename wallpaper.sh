# Set wallpaper
WALL1="$(pwd)/wallpaper.jpg"
WALL2="/usr/share/backgrounds/linuxmint-wallpapers/porioni_dark.jpg"

if [ -f "$WALL1" ]; then
  WALL="$WALL1"
elif [ -f "$WALL2" ]; then
  WALL="$WALL2"
else
  echo "No wallpaper found"
  exit 1
fi

gsettings set org.cinnamon.desktop.background picture-uri "file://$WALL"
gsettings set org.cinnamon.desktop.background picture-options 'zoom'

