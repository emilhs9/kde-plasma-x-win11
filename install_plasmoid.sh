#!/bin/bash
TARGET_DIR="$HOME/.local/share/plasma/plasmoids/org.kde.plasma.win11startmenu"
echo "[*] Creating target plasmoid directory: $TARGET_DIR"
mkdir -p "$TARGET_DIR"
cp -r "$(dirname "$0")/package/"* "$TARGET_DIR/"
echo "[✓] Successfully installed to Plasma plasmoids!"
echo "[i] Restarting plasma shell cache..."
kbuildsycoca6 2>/dev/null || true
echo "[✓] Done! You can now right-click your panel -> 'Add Widgets' -> search 'Windows 11 Start Menu' and add it to your taskbar."
