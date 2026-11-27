# KDE Plasma x win11 — Start Menu Plasmoid

A modern, fluid, and highly customizable Windows 11-style Start Menu plasmoid designed for KDE Plasma 6 with deep Arch Linux and Wayland/X11 integration.

![Windows 11 Start Menu Preview](package/contents/ui/Arch_Linux__Crystal__icon.svg)

## ✨ Features

- **Docked Taskbar Alignment**: Automatically calculates screen geometry and panel offsets to dock directly above your centered taskbar.
- **Predictive Search Engine**: Real-time 3-column search (`Apps`, `Files`, `Tools`) with usage frequency scoring and inline ghost autocompletion.
- **Dynamic Application Auto-Discovery**: Seamless integration with KDE's KRunner engine and system desktop files (`/usr/share/applications`, Flatpaks, and user applications).
- **Smooth Windows 11 Animations**: Fast 110ms Quartic easing opening and 80ms exit transitions.
- **Context Menu & Drag-and-Drop**: Right-click to pin/unpin from Start, pin to panel, or create desktop shortcuts. Supports direct drag-and-drop reordering.
- **Category Filter**: Browse all installed applications categorized by Development, Internet, Multimedia, System, Settings, and Utilities.
- **Power Controls**: Quick access to Lock, Log Out, Sleep, Restart, and Shut Down options with automatic cleanup on close.

## 🚀 Installation

Run the automated installer script:

```bash
chmod +x install_plasmoid.sh
./install_plasmoid.sh
```

Or manually copy the plasmoid package to your local Plasma directory:

```bash
mkdir -p ~/.local/share/plasma/plasmoids/org.kde.plasma.win11startmenu
cp -r package/* ~/.local/share/plasma/plasmoids/org.kde.plasma.win11startmenu/
kbuildsycoca6
```

Then right-click your desktop panel -> **Add Widgets** -> search for **Windows 11 Start Menu** and add it to your taskbar.

## 📁 Project Structure

```text
├── package/
│   ├── metadata.json                 # Plasmoid metadata & plugin registration
│   └── contents/
│       └── ui/
│           ├── main.qml               # Main QML interface & dialog logic
│           ├── search_engine.js       # Predictive scoring & frequency engine
│           ├── search_db.js           # Fast in-memory application & file database
│           └── icons/                 # System & application SVG icons
├── install_plasmoid.sh                # Installation & deployment script
├── update_apps_index.py               # Dynamic XDG application indexer
├── win11_preview.html                 # Interactive browser preview
└── README.md                          # Documentation
```

## 📄 License

GPL-3.0 License
