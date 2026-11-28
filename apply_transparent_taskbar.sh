#!/bin/bash
# ==============================================================================
# Script: Black Translucent Taskbar (Qara, arxası görünən)
# ==============================================================================
set -e

THEME_DIR="$HOME/.local/share/plasma/desktoptheme/Breeze-Transparent"
WIDGETS_DIR="$THEME_DIR/widgets"
mkdir -p "$WIDGETS_DIR"

python3 -c "
import os, gzip, xml.etree.ElementTree as ET, json

theme_dir = os.path.expanduser('~/.local/share/plasma/desktoptheme/Breeze-Transparent')
widgets_dir = os.path.join(theme_dir, 'widgets')
os.makedirs(widgets_dir, exist_ok=True)

metadata = {
    'KPlugin': {
        'Authors': [{'Name': 'KDE Visual Design Group'}],
        'Category': '',
        'Description': 'Breeze with Black Translucent taskbar',
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
    xml_str = f.read().decode('utf-8', errors='ignore')

root = ET.fromstring(xml_str)

for elem in root.iter():
    elem_id = elem.attrib.get('id', '')
    if 'mask' in elem_id:
        elem.attrib['style'] = 'fill:#000000;fill-opacity:1;opacity:1;'
        if 'class' in elem.attrib: del elem.attrib['class']
    elif elem_id in ['rect4138', 'center', 'rect4152', 'top', 'rect4148', 'bottom', 'rect4144', 'left', 'rect4140', 'right', 'topleft', 'topright', 'bottomleft', 'bottomright', 'path3115', 'path3118', 'path3124', 'path3121']:
        elem.attrib['style'] = 'fill:#000000;fill-opacity:0.50;opacity:1;'
        if 'class' in elem.attrib: del elem.attrib['class']
    elif elem_id in ['path1337', 'path1671', 'path1785', 'path1902']:
        elem.attrib['style'] = 'fill:#000000;fill-opacity:0.50;opacity:1;'
        if 'class' in elem.attrib: del elem.attrib['class']
    elif 'shadow' in elem_id and not elem_id.startswith('shadow-hint'):
        elem.attrib['style'] = 'opacity:0;fill:none;'

xml_out = ET.tostring(root, encoding='unicode')
with open(os.path.join(widgets_dir, 'panel-background.svg'), 'w') as f:
    f.write(xml_out)

print('[✓] Black translucent panel-background.svg generated')
"

kwriteconfig6 --file plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --key floating 0
kwriteconfig6 --file plasmarc --group Theme --key name Breeze-Transparent
systemctl --user restart plasma-plasmashell.service

echo "[✓] Qara, arxası görünən taskbar tətbiq edildi!"
