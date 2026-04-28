#!/bin/bash
AVATAR1="$(pwd)/avatar.png"
AVATAR2="/usr/share/pixmaps/faces/user.png"

# выбираем файл
if [ -f "$AVATAR1" ]; then
  SRC="$AVATAR1"
elif [ -f "$AVATAR2" ]; then
  SRC="$AVATAR2"
else
  echo "No avatar found"
  exit 1
fi

# ставим аватар
sudo mkdir -p /var/lib/AccountsService/icons
sudo cp "$SRC" "/var/lib/AccountsService/icons/$USER"

sudo bash -c "cat > /var/lib/AccountsService/users/$USER" <<EOF
[User]
Icon=/var/lib/AccountsService/icons/$USER
EOF

# применить
sudo systemctl restart accounts-daemon
