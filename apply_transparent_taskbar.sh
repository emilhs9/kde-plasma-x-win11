#!/bin/bash
# ==============================================================================
# Script: KDE Plasma 6 100% Transparent Taskbar (TranslucentTB style)
# ==============================================================================
set -e

THEME_DIR="$HOME/.local/share/plasma/desktoptheme/Breeze-Transparent"
WIDGETS_DIR="$THEME_DIR/widgets"
mkdir -p "$WIDGETS_DIR"

python3 -c "
import os, gzip, re, json

theme_dir = os.path.expanduser('~/.local/share/plasma/desktoptheme/Breeze-Transparent')
widgets_dir = os.path.join(theme_dir, 'widgets')
os.makedirs(widgets_dir, exist_ok=True)

metadata = {
    'KPlugin': {
        'Authors': [{'Name': 'KDE Visual Design Group'}],
        'Category': '',
        'Description': 'Breeze with 100% transparent taskbar',
        'EnabledByDefault': True,
        'Id': 'Breeze-Transparent',
        'License': 'LGPL',
        'Name': 'Breeze Transparent',
        'Version': '6.30.0',
        'Website': 'https://www.kde.org/'
    },
    'X-Plasma-API': '5.0'
}
with open(os.path.join(theme_dir, 'metadata.json'), 'w') as f:
    json.dump(metadata, f, indent=4)

with gzip.open('/usr/share/plasma/desktoptheme/default/widgets/panel-background.svgz', 'rb') as f:
    svg = f.read().decode('utf-8', errors='ignore')

svg_trans = re.sub(r'style=\"[^\"]*(?:opacity|fill)[^\"]*\"', 'style=\"opacity:0;fill:none;\"', svg)

with open(os.path.join(widgets_dir, 'panel-background.svg'), 'w') as f:
    f.write(svg_trans)

print('[✓] Breeze-Transparent theme ready')
"

kwriteconfig6 --file plasmarc --group Theme --key name Breeze-Transparent
systemctl --user restart plasma-plasmashell.service

echo "[✓] Taskbar 100% şəffaf edildi!"
