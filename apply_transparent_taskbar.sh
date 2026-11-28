#!/bin/bash
# ==============================================================================
# Script: 100% Clear Invisible Taskbar (Exact TranslucentTB Clear style)
# Windows 11 ayna kimi tam şəffaf (Blur yoxdur, arxası 100% aydın və net görünür)
# ==============================================================================
set -e

THEME_DIR="$HOME/.local/share/plasma/desktoptheme/Breeze-Transparent"
WIDGETS_DIR="$THEME_DIR/widgets"
mkdir -p "$WIDGETS_DIR"

python3 -c "
import os, gzip, re, json
import xml.etree.ElementTree as ET

theme_dir = os.path.expanduser('~/.local/share/plasma/desktoptheme/Breeze-Transparent')
widgets_dir = os.path.join(theme_dir, 'widgets')
os.makedirs(widgets_dir, exist_ok=True)

metadata = {
    'KPlugin': {
        'Authors': [{'Name': 'KDE Visual Design Group'}],
        'Category': '',
        'Description': 'Breeze with 100% Clear Invisible taskbar like Windows 11 TranslucentTB',
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
    svg_raw = f.read().decode('utf-8', errors='ignore')

# Set all styles to completely transparent & no fill
svg_clear = re.sub(r'style=\"[^\"]*(?:opacity|fill)[^\"]*\"', 'style=\"opacity:0;fill:none;\"', svg_raw)

root = ET.fromstring(svg_clear)

# KWin blur effekti mask-* elementlərini oxuyub arxasını dumanlı/bulanıq edir.
# Tam ayna kimi kristal şəffaflıq üçün mask-* elementlərini tam silirik:
for el in root.iter():
    for child in list(el):
        child_id = child.attrib.get('id', '')
        if child_id.startswith('mask-'):
            el.remove(child)

tree = ET.ElementTree(root)
tree.write(os.path.join(widgets_dir, 'panel-background.svg'), encoding='utf-8', xml_declaration=True)

print('[✓] 100% Clear panel-background.svg generated (no blur masks, no fills, no shadows)')
"

# Set flat bottom dock (not floating, zero gap)
kwriteconfig6 --file plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --key floating 0

# Set panelVisibility=3 (WindowsGoBelow - pəncərələr panelin tam altına keçir, kəsilmə olmur)
kwriteconfig6 --file plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --key panelVisibility 3

# Apply Breeze-Transparent theme
kwriteconfig6 --file plasmarc --group Theme --key name Breeze-Transparent

# Clear plasma SVG cache
rm -f "$HOME/.cache/plasma_theme_"*.kcache

# Restart plasma shell
systemctl --user restart plasma-plasmashell.service

echo "[✓] Taskbar şəkildəki kimi 100% tam şəffaf və ayna kimi edildi!"
