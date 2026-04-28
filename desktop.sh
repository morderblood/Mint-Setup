#!/bin/bash
set -e

sudo apt install -y jq libreoffice firefox

DESKTOP_DIR="$(xdg-user-dir DESKTOP)"
DOWNLOADS_DIR="$(xdg-user-dir DOWNLOAD)"
DOCUMENTS_DIR="$(xdg-user-dir DOCUMENTS)"

mkdir -p "$DESKTOP_DIR"

# Panel layout:
# left: weather + menu
# center: pinned apps
# right: tray/clock/sound/etc
gsettings set org.cinnamon enabled-applets "[
'panel1:left:0:weather@mockturtl:0',
'panel1:center:0:menu@cinnamon.org:1',
'panel1:center:1:grouped-window-list@cinnamon.org:2',
'panel1:right:0:systray@cinnamon.org:3',
'panel1:right:1:xapp-status@cinnamon.org:4',
'panel1:right:2:notifications@cinnamon.org:5',
'panel1:right:3:keyboard@cinnamon.org:6',
'panel1:right:4:sound@cinnamon.org:7',
'panel1:right:5:calendar@cinnamon.org:8'
]"

# Install Cinnamon weather applet
mkdir -p ~/.local/share/cinnamon/applets
TMP_DIR="$(mktemp -d)"
cd "$TMP_DIR"

wget -O applets.tar.gz https://github.com/linuxmint/cinnamon-spices-applets/archive/refs/heads/master.tar.gz
tar -xzf applets.tar.gz

if [ -d "cinnamon-spices-applets-master/weather@mockturtl/files/weather@mockturtl" ]; then
  rm -rf ~/.local/share/cinnamon/applets/weather@mockturtl
  cp -r cinnamon-spices-applets-master/weather@mockturtl/files/weather@mockturtl ~/.local/share/cinnamon/applets/
fi

cd ~
rm -rf "$TMP_DIR"

# Center pinned apps
mkdir -p ~/.config/cinnamon/spices/grouped-window-list@cinnamon.org

cat > ~/.config/cinnamon/spices/grouped-window-list@cinnamon.org/2.json <<'EOF'
{
  "pinned-apps": {
    "type": "generic",
    "default": [],
    "value": [
      "firefox.desktop",
      "nemo.desktop",
      "libreoffice-writer.desktop",
      "libreoffice-calc.desktop",
      "libreoffice-impress.desktop"
    ]
  }
}
EOF

# Replace Cinnamon menu icon with Windows-like distributor logo
mkdir -p ~/.config/cinnamon/spices/menu@cinnamon.org

cat > ~/.config/cinnamon/spices/menu@cinnamon.org/1.json <<'EOF'
{
  "menu-icon": {
    "type": "iconfilechooser",
    "default": "cinnamon-symbolic",
    "value": "distributor-logo-windows"
  },
  "use-custom-icon": {
    "type": "checkbox",
    "default": false,
    "value": true
  }
}
EOF

# Desktop icons
cat > "$DESKTOP_DIR/Downloads.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Downloads
Name[ru]=Загрузки
Exec=nemo "$DOWNLOADS_DIR"
Icon=folder-download
Terminal=false
EOF

cat > "$DESKTOP_DIR/Documents.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Documents
Name[ru]=Документы
Exec=nemo "$DOCUMENTS_DIR"
Icon=folder-documents
Terminal=false
EOF

cat > "$DESKTOP_DIR/LibreOffice Writer.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=Word
Exec=libreoffice --writer
Icon=libreoffice-writer
Terminal=false
EOF

cat > "$DESKTOP_DIR/LibreOffice Calc.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=Excel
Exec=libreoffice --calc
Icon=libreoffice-calc
Terminal=false
EOF

cat > "$DESKTOP_DIR/LibreOffice Impress.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=PowerPoint
Exec=libreoffice --impress
Icon=libreoffice-impress
Terminal=false
EOF

cat > "$DESKTOP_DIR/Firefox.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=Firefox
Exec=firefox
Icon=firefox
Terminal=false
EOF

cat > "$DESKTOP_DIR/Trash.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=Trash
Name[ru]=Корзина
Exec=nemo trash:///
Icon=user-trash
Terminal=false
EOF

chmod +x "$DESKTOP_DIR"/*.desktop

# Enable desktop icons in Nemo
gsettings set org.nemo.desktop show-desktop-icons true
gsettings set org.nemo.desktop trash-icon-visible true
gsettings set org.nemo.desktop home-icon-visible false
gsettings set org.nemo.desktop computer-icon-visible false

# Restart Cinnamon
nohup cinnamon --replace >/dev/null 2>&1 &


echo "Desktop look applied. Лучше перелогиниться."
