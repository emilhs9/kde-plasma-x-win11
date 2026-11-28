#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing Windows 11 Clipboard Manager..."
sudo cp "$DIR/win11-clipboard.py" /usr/local/bin/win11-clipboard
sudo chmod +x /usr/local/bin/win11-clipboard

# Udev rule for ydotool uinput access
echo 'KERNEL=="uinput", MODE="0666"' | sudo tee /etc/udev/rules.d/99-uinput.rules > /dev/null
sudo chmod 0666 /dev/uinput 2>/dev/null || true

# User services
systemctl --user daemon-reload
systemctl --user enable --now ydotool.service
systemctl --user enable --now copyq.service

# Desktop entry
mkdir -p ~/.local/share/applications
cat << 'DESK' > ~/.local/share/applications/copyq-toggle.desktop
[Desktop Entry]
Name=Clipboard
Comment=Windows 11 Style Clipboard
Exec=/usr/local/bin/win11-clipboard
Icon=klipper
Type=Application
Terminal=false
Categories=Utility;
StartupNotify=false
DESK

update-desktop-database ~/.local/share/applications

# Shortcut Win+V (Meta+V)
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group "services" --group "copyq-toggle.desktop" --key "_launch" "Meta+V"
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group "plasmashell" --key "show-on-mouse-pos" "none,none,Show Clipboard Items at Mouse Position"

echo "==> Done! Press Win+V to open Windows 11 Clipboard."
