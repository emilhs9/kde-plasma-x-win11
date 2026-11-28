#!/bin/bash
# ==============================================================================
# Script: KDE Plasma 6 Frosted Mirror Glass Taskbar (Ayna effekti + KWin Blur)
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
        'Description': 'Breeze with Frosted Mirror Glass taskbar and KWin blur',
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
    elif elem_id == 'rect4138' or elem_id == 'center':
        elem.attrib['style'] = 'fill:#ffffff;fill-opacity:0.14;opacity:1;'
        if 'class' in elem.attrib: del elem.attrib['class']
    elif elem_id == 'path1337':
        elem.attrib['style'] = 'fill:#ffffff;fill-opacity:0.48;opacity:1;'
        if 'class' in elem.attrib: del elem.attrib['class']
    elif elem_id == 'rect4152' or elem_id == 'top':
        elem.attrib['style'] = 'fill:#ffffff;fill-opacity:0.16;opacity:1;'
        if 'class' in elem.attrib: del elem.attrib['class']
    elif elem_id in ['rect4148', 'rect4144', 'rect4140', 'path1671', 'path1785', 'path1902']:
        elem.attrib['style'] = 'fill:#ffffff;fill-opacity:0.22;opacity:1;'
        if 'class' in elem.attrib: del elem.attrib['class']
    elif elem_id in ['path3115', 'path3118', 'path3124', 'path3121', 'topleft', 'topright', 'bottomleft', 'bottomright']:
        elem.attrib['style'] = 'fill:#ffffff;fill-opacity:0.25;opacity:1;'
        if 'class' in elem.attrib: del elem.attrib['class']
    elif 'shadow' in elem_id and not elem_id.startswith('shadow-hint'):
        if 'style' in elem.attrib:
            elem.attrib['style'] = 'opacity:0.35;'

xml_out = ET.tostring(root, encoding='unicode')
with open(os.path.join(widgets_dir, 'panel-background.svg'), 'w') as f:
    f.write(xml_out)

print('[✓] Mirror Glass panel-background.svg generated')
"

# Configure KWin Blur
kwriteconfig6 --file kwinrc --group Effect-blur --key BlurStrength 14
kwriteconfig6 --file kwinrc --group Effect-blur --key NoiseStrength 2
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.reconfigureEffect blur || true

# Apply Theme and restart plasma
kwriteconfig6 --file plasmarc --group Theme --key name Breeze-Transparent
kwriteconfig6 --file plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --key opacity 2
kwriteconfig6 --file plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --key floating 1
systemctl --user restart plasma-plasmashell.service

echo "[✓] Taskbar tam ayna / frosted glass effekti ilə yeniləndi!"
