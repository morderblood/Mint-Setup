# Download the NAPS2 public key
curl -fsSL https://www.naps2.com/naps2-public.pgp | sudo gpg --dearmor -o /etc/apt/keyrings/naps2.gpg

# Add NAPS2 as an Apt source
echo "deb [signed-by=/etc/apt/keyrings/naps2.gpg] https://downloads.naps2.com ./" | sudo tee /etc/apt/sources.list.d/naps2.list >/dev/null

# Install NAPS2
sudo apt update
sudo apt install naps2

DESKTOP_DIR=$(xdg-user-dir DESKTOP)

cat > "$DESKTOP_DIR/Naps2.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=Naps2
Exec=naps2
Icon=naps2
Terminal=false
EOF
