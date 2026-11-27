.pragma library

var searchDb = {
  "apps": [
    {
      "name": "Ark",
      "icon": "ark",
      "cmd": "ark",
      "desc": "Work with file archives",
      "category": "Utilities",
      "desktop": "/usr/share/applications/org.kde.ark.desktop",
      "type": "app"
    },
    {
      "name": "Brave",
      "icon": "com.brave.Browser",
      "cmd": "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=brave --file-forwarding com.brave.Browser @@u",
      "desc": "Access the Internet",
      "category": "Internet",
      "desktop": "/var/lib/flatpak/exports/share/applications/com.brave.Browser.desktop",
      "type": "app"
    },
    {
      "name": "CMake",
      "icon": "CMakeSetup",
      "cmd": "cmake-gui",
      "desc": "Cross-platform buildsystem",
      "category": "Development",
      "desktop": "/usr/share/applications/cmake-gui.desktop",
      "type": "app"
    },
    {
      "name": "Crashed Processes Viewer",
      "icon": "tools-report-bug",
      "cmd": "drkonqi-coredump-gui",
      "desc": "Offers detailed view of past crashes",
      "category": "System",
      "desktop": "/usr/share/applications/org.kde.drkonqi.coredump.gui.desktop",
      "type": "app"
    },
    {
      "name": "Discord",
      "icon": "discord",
      "cmd": "/usr/bin/discord --url --",
      "desc": "All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.",
      "category": "Internet",
      "desktop": "/usr/share/applications/discord.desktop",
      "type": "app"
    },
    {
      "name": "Discover",
      "icon": "plasmadiscover",
      "cmd": "plasma-discover",
      "desc": "Install and remove apps and add-ons",
      "category": "System",
      "desktop": "/usr/share/applications/org.kde.discover.desktop",
      "type": "app"
    },
    {
      "name": "Dolphin",
      "icon": "org.kde.dolphin",
      "cmd": "dolphin",
      "desc": "Manage your files",
      "category": "System",
      "desktop": "/usr/share/applications/org.kde.dolphin.desktop",
      "type": "app"
    },
    {
      "name": "Emoji Selector",
      "icon": "preferences-desktop-emoticons",
      "cmd": "plasma-emojier",
      "desc": "Copy emojis to the clipboard",
      "category": "Utilities",
      "desktop": "/usr/share/applications/org.kde.plasma.emojier.desktop",
      "type": "app"
    },
    {
      "name": "Ente Auth",
      "icon": "/home/sir/.local/share/ente-auth/ente-auth.png",
      "cmd": "/home/sir/.local/share/ente-auth/ente-auth-v4.4.27-x86_64.AppImage",
      "desc": "2FA Authenticator by Ente",
      "category": "Utilities",
      "desktop": "/home/sir/.local/share/applications/ente-auth.desktop",
      "type": "app"
    },
    {
      "name": "Google Antigravity",
      "icon": "/home/sir/.local/share/icons/antigravity.png",
      "cmd": "/home/sir/Downloads/Antigravity-IDE/antigravity-ide --no-sandbox --disable-gpu --ozone-platform=x11",
      "desc": "AI Coding IDE",
      "category": "Development",
      "desktop": "/home/sir/.local/share/applications/antigravity.desktop",
      "type": "app"
    },
    {
      "name": "Hardware Locality lstopo",
      "icon": "hwloc",
      "cmd": "lstopo",
      "desc": "Show hardware topology",
      "category": "System",
      "desktop": "/usr/share/applications/lstopo.desktop",
      "type": "app"
    },
    {
      "name": "Htop",
      "icon": "htop",
      "cmd": "htop",
      "desc": "Show System Processes",
      "category": "System",
      "desktop": "/usr/share/applications/htop.desktop",
      "type": "app"
    },
    {
      "name": "Info Center",
      "icon": "hwinfo",
      "cmd": "kinfocenter",
      "desc": "Learn about the system's hardware and status",
      "category": "System",
      "desktop": "/usr/share/applications/org.kde.kinfocenter.desktop",
      "type": "app"
    },
    {
      "name": "KDE System Settings",
      "icon": "preferences-system",
      "cmd": "systemsettings",
      "desc": "Configure KDE Plasma\u2019s behavior and appearance",
      "category": "Settings",
      "desktop": "/usr/share/applications/kdesystemsettings.desktop",
      "type": "app"
    },
    {
      "name": "kitty",
      "icon": "kitty",
      "cmd": "kitty",
      "desc": "Fast, feature-rich, GPU based terminal",
      "category": "System",
      "desktop": "/usr/share/applications/kitty.desktop",
      "type": "app"
    },
    {
      "name": "Konsole",
      "icon": "utilities-terminal",
      "cmd": "konsole",
      "desc": "Use the command line",
      "category": "System",
      "desktop": "/usr/share/applications/org.kde.konsole.desktop",
      "type": "app"
    },
    {
      "name": "Manage Printing",
      "icon": "cups",
      "cmd": "xdg-open http://localhost:631/",
      "desc": "CUPS Web Interface",
      "category": "System",
      "desktop": "/usr/share/applications/cups.desktop",
      "type": "app"
    },
    {
      "name": "Menu Editor",
      "icon": "kmenuedit",
      "cmd": "kmenuedit",
      "desc": "Edit how applications are presented in app launchers",
      "category": "System",
      "desktop": "/usr/share/applications/org.kde.kmenuedit.desktop",
      "type": "app"
    },
    {
      "name": "Print Settings",
      "icon": "printer",
      "cmd": "system-config-printer",
      "desc": "Configure printers",
      "category": "System",
      "desktop": "/usr/share/applications/system-config-printer.desktop",
      "type": "app"
    },
    {
      "name": "Qt Assistant",
      "icon": "assistant",
      "cmd": "assistant6",
      "desc": "View documentation in Qt help file format",
      "category": "Development",
      "desktop": "/usr/share/applications/assistant.desktop",
      "type": "app"
    },
    {
      "name": "Qt D-Bus Viewer",
      "icon": "qdbusviewer",
      "cmd": "qdbusviewer6",
      "desc": "Debug D-Bus applications",
      "category": "Development",
      "desktop": "/usr/share/applications/qdbusviewer.desktop",
      "type": "app"
    },
    {
      "name": "Qt Linguist",
      "icon": "linguist",
      "cmd": "linguist6",
      "desc": "Add translations to Qt applications",
      "category": "Development",
      "desktop": "/usr/share/applications/linguist.desktop",
      "type": "app"
    },
    {
      "name": "Qt V4L2 test Utility",
      "icon": "qv4l2",
      "cmd": "qv4l2",
      "desc": "Allow testing Video4Linux devices",
      "category": "Multimedia",
      "desktop": "/usr/share/applications/qv4l2.desktop",
      "type": "app"
    },
    {
      "name": "Qt V4L2 video capture utility",
      "icon": "qvidcap",
      "cmd": "qvidcap",
      "desc": "Viewer for video capture",
      "category": "Multimedia",
      "desktop": "/usr/share/applications/qvidcap.desktop",
      "type": "app"
    },
    {
      "name": "Qt Widgets Designer",
      "icon": "designer",
      "cmd": "designer6",
      "desc": "Design GUIs for Qt applications",
      "category": "Development",
      "desktop": "/usr/share/applications/designer.desktop",
      "type": "app"
    },
    {
      "name": "Rofi",
      "icon": "rofi",
      "cmd": "rofi -show",
      "desc": "Utilities \u2022 Application",
      "category": "Utilities",
      "desktop": "/usr/share/applications/rofi.desktop",
      "type": "app"
    },
    {
      "name": "Rofi Theme Selector",
      "icon": "rofi",
      "cmd": "rofi-theme-selector",
      "desc": "Utilities \u2022 Application",
      "category": "Utilities",
      "desktop": "/usr/share/applications/rofi-theme-selector.desktop",
      "type": "app"
    },
    {
      "name": "Spectacle",
      "icon": "spectacle",
      "cmd": "/usr/bin/spectacle",
      "desc": "Take screenshots and screen recordings",
      "category": "Utilities",
      "desktop": "/usr/share/applications/org.kde.spectacle.desktop",
      "type": "app"
    },
    {
      "name": "System Monitor",
      "icon": "utilities-system-monitor",
      "cmd": "plasma-systemmonitor",
      "desc": "Monitor app and system resource usage",
      "category": "System",
      "desktop": "/usr/share/applications/org.kde.plasma-systemmonitor.desktop",
      "type": "app"
    },
    {
      "name": "System Settings",
      "icon": "preferences-system",
      "cmd": "systemsettings",
      "desc": "Configure the system\u2019s behavior and appearance",
      "category": "Settings",
      "desktop": "/usr/share/applications/systemsettings.desktop",
      "type": "app"
    },
    {
      "name": "uuctl",
      "icon": "applications-system",
      "cmd": "uuctl",
      "desc": "Select and perform actions on user systemd units",
      "category": "Settings",
      "desktop": "/usr/share/applications/uuctl.desktop",
      "type": "app"
    },
    {
      "name": "Vim",
      "icon": "gvim",
      "cmd": "vim",
      "desc": "Edit text files",
      "category": "Utilities",
      "desktop": "/usr/share/applications/vim.desktop",
      "type": "app"
    },
    {
      "name": "Visual Studio Code",
      "icon": "com.visualstudio.code",
      "cmd": "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=code --file-forwarding com.visualstudio.code @@",
      "desc": "Code Editing. Redefined.",
      "category": "Development",
      "desktop": "/var/lib/flatpak/exports/share/applications/com.visualstudio.code.desktop",
      "type": "app"
    },
    {
      "name": "VLC media player",
      "icon": "org.videolan.VLC",
      "cmd": "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/vlc --file-forwarding org.videolan.VLC --started-from-file @@u",
      "desc": "Read, capture, broadcast your multimedia streams",
      "category": "Multimedia",
      "desktop": "/var/lib/flatpak/exports/share/applications/org.videolan.VLC.desktop",
      "type": "app"
    },
    {
      "name": "Welcome Center",
      "icon": "start-here-kde-plasma",
      "cmd": "plasma-welcome",
      "desc": "Learn more about KDE Plasma",
      "category": "Utilities",
      "desktop": "/usr/share/applications/org.kde.plasma-welcome.desktop",
      "type": "app"
    },
    {
      "name": "Winetricks",
      "icon": "winetricks",
      "cmd": "winetricks --gui",
      "desc": "Work around problems and install applications under Wine",
      "category": "Utilities",
      "desktop": "/usr/share/applications/winetricks.desktop",
      "type": "app"
    }
  ],
  "files": [
    {
      "name": "trendo.pem",
      "icon": "security-high",
      "path": "/home/sir/Desktop/trendo.pem",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/trendo.pem\"",
      "desc": "Desktop \u2022 PEM",
      "type": "file"
    },
    {
      "name": "ops",
      "icon": "folder",
      "path": "/home/sir/Desktop/ops",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/ops\"",
      "desc": "Desktop \u2022 Folder",
      "type": "file"
    },
    {
      "name": "MegaMedusa-main.zip",
      "icon": "package-x-generic",
      "path": "/home/sir/Desktop/MegaMedusa-main.zip",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/MegaMedusa-main.zip\"",
      "desc": "Desktop \u2022 ZIP",
      "type": "file"
    },
    {
      "name": "ente-auth.desktop",
      "icon": "text-plain",
      "path": "/home/sir/Desktop/ente-auth.desktop",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/ente-auth.desktop\"",
      "desc": "Desktop \u2022 DESKTOP",
      "type": "file"
    },
    {
      "name": "New Folder",
      "icon": "folder",
      "path": "/home/sir/Desktop/New Folder",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/New Folder\"",
      "desc": "Desktop \u2022 Folder",
      "type": "file"
    },
    {
      "name": "games.json",
      "icon": "application-json",
      "path": "/home/sir/Desktop/games.json",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/games.json\"",
      "desc": "Desktop \u2022 JSON",
      "type": "file"
    },
    {
      "name": "Emil_Suleymanli_CV_EN.pdf",
      "icon": "application-pdf",
      "path": "/home/sir/Desktop/Emil_Suleymanli_CV_EN.pdf",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/Emil_Suleymanli_CV_EN.pdf\"",
      "desc": "Desktop \u2022 PDF",
      "type": "file"
    },
    {
      "name": "Wildlife.wmv",
      "icon": "video-x-generic",
      "path": "/home/sir/Desktop/Wildlife.wmv",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/Wildlife.wmv\"",
      "desc": "Desktop \u2022 WMV",
      "type": "file"
    },
    {
      "name": "MegaMedusa-main.rar",
      "icon": "package-x-generic",
      "path": "/home/sir/Desktop/MegaMedusa-main.rar",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/MegaMedusa-main.rar\"",
      "desc": "Desktop \u2022 RAR",
      "type": "file"
    },
    {
      "name": "Gallery",
      "icon": "folder",
      "path": "/home/sir/Desktop/Gallery",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/Gallery\"",
      "desc": "Desktop \u2022 Folder",
      "type": "file"
    },
    {
      "name": "Ignore gallery",
      "icon": "folder",
      "path": "/home/sir/Desktop/Ignore gallery",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/Ignore gallery\"",
      "desc": "Desktop \u2022 Folder",
      "type": "file"
    },
    {
      "name": ".directory",
      "icon": "text-plain",
      "path": "/home/sir/Desktop/.directory",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/.directory\"",
      "desc": "Desktop \u2022 DIRECTORY",
      "type": "file"
    },
    {
      "name": "M",
      "icon": "folder",
      "path": "/home/sir/Desktop/M",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/M\"",
      "desc": "Desktop \u2022 Folder",
      "type": "file"
    },
    {
      "name": "com.brave.Browser.desktop",
      "icon": "text-plain",
      "path": "/home/sir/Desktop/com.brave.Browser.desktop",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/com.brave.Browser.desktop\"",
      "desc": "Desktop \u2022 DESKTOP",
      "type": "file"
    },
    {
      "name": "win11 startmenu",
      "icon": "folder",
      "path": "/home/sir/Desktop/win11 startmenu",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/win11 startmenu\"",
      "desc": "Desktop \u2022 Folder",
      "type": "file"
    },
    {
      "name": "Emil_Suleymanli_CV_AZ.pdf",
      "icon": "application-pdf",
      "path": "/home/sir/Desktop/Emil_Suleymanli_CV_AZ.pdf",
      "location": "Desktop",
      "cmd": "xdg-open \"/home/sir/Desktop/Emil_Suleymanli_CV_AZ.pdf\"",
      "desc": "Desktop \u2022 PDF",
      "type": "file"
    },
    {
      "name": "README.md",
      "icon": "text-plain",
      "path": "/home/sir/Desktop/ops/README.md",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/README.md\"",
      "desc": "Desktop/ops \u2022 MD",
      "type": "file"
    },
    {
      "name": ".agent",
      "icon": "folder",
      "path": "/home/sir/Desktop/ops/.agent",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/.agent\"",
      "desc": "Desktop/ops \u2022 AGENT",
      "type": "file"
    },
    {
      "name": "ops.js",
      "icon": "text-x-script",
      "path": "/home/sir/Desktop/ops/ops.js",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/ops.js\"",
      "desc": "Desktop/ops \u2022 JS",
      "type": "file"
    },
    {
      "name": "scraper.js",
      "icon": "text-x-script",
      "path": "/home/sir/Desktop/ops/scraper.js",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/scraper.js\"",
      "desc": "Desktop/ops \u2022 JS",
      "type": "file"
    },
    {
      "name": "node_modules",
      "icon": "folder",
      "path": "/home/sir/Desktop/ops/node_modules",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/node_modules\"",
      "desc": "Desktop/ops \u2022 Folder",
      "type": "file"
    },
    {
      "name": ".git",
      "icon": "folder",
      "path": "/home/sir/Desktop/ops/.git",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/.git\"",
      "desc": "Desktop/ops \u2022 GIT",
      "type": "file"
    },
    {
      "name": "antigravity-skills.md",
      "icon": "text-plain",
      "path": "/home/sir/Desktop/ops/antigravity-skills.md",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/antigravity-skills.md\"",
      "desc": "Desktop/ops \u2022 MD",
      "type": "file"
    },
    {
      "name": "UI",
      "icon": "folder",
      "path": "/home/sir/Desktop/ops/UI",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/UI\"",
      "desc": "Desktop/ops \u2022 Folder",
      "type": "file"
    },
    {
      "name": "screenshot - powerproof",
      "icon": "folder",
      "path": "/home/sir/Desktop/ops/screenshot - powerproof",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/screenshot - powerproof\"",
      "desc": "Desktop/ops \u2022 Folder",
      "type": "file"
    },
    {
      "name": "installer.py",
      "icon": "text-x-script",
      "path": "/home/sir/Desktop/ops/installer.py",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/installer.py\"",
      "desc": "Desktop/ops \u2022 PY",
      "type": "file"
    },
    {
      "name": "favicon.png",
      "icon": "image-x-generic",
      "path": "/home/sir/Desktop/ops/favicon.png",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/favicon.png\"",
      "desc": "Desktop/ops \u2022 PNG",
      "type": "file"
    },
    {
      "name": "proxy.txt",
      "icon": "text-plain",
      "path": "/home/sir/Desktop/ops/proxy.txt",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/proxy.txt\"",
      "desc": "Desktop/ops \u2022 TXT",
      "type": "file"
    },
    {
      "name": "skills-lock.json",
      "icon": "application-json",
      "path": "/home/sir/Desktop/ops/skills-lock.json",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/skills-lock.json\"",
      "desc": "Desktop/ops \u2022 JSON",
      "type": "file"
    },
    {
      "name": "package.json",
      "icon": "application-json",
      "path": "/home/sir/Desktop/ops/package.json",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/package.json\"",
      "desc": "Desktop/ops \u2022 JSON",
      "type": "file"
    },
    {
      "name": ".vscode",
      "icon": "folder",
      "path": "/home/sir/Desktop/ops/.vscode",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/.vscode\"",
      "desc": "Desktop/ops \u2022 VSCODE",
      "type": "file"
    },
    {
      "name": ".agents",
      "icon": "folder",
      "path": "/home/sir/Desktop/ops/.agents",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/.agents\"",
      "desc": "Desktop/ops \u2022 AGENTS",
      "type": "file"
    },
    {
      "name": "scrape.js",
      "icon": "text-x-script",
      "path": "/home/sir/Desktop/ops/scrape.js",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/scrape.js\"",
      "desc": "Desktop/ops \u2022 JS",
      "type": "file"
    },
    {
      "name": "package-lock.json",
      "icon": "application-json",
      "path": "/home/sir/Desktop/ops/package-lock.json",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/package-lock.json\"",
      "desc": "Desktop/ops \u2022 JSON",
      "type": "file"
    },
    {
      "name": "ops_open.js",
      "icon": "text-x-script",
      "path": "/home/sir/Desktop/ops/ops_open.js",
      "location": "Desktop/ops",
      "cmd": "xdg-open \"/home/sir/Desktop/ops/ops_open.js\"",
      "desc": "Desktop/ops \u2022 JS",
      "type": "file"
    },
    {
      "name": "ente-auth-v4.4.27.tar.gz",
      "icon": "package-x-generic",
      "path": "/home/sir/Downloads/ente-auth-v4.4.27.tar.gz",
      "location": "Downloads",
      "cmd": "xdg-open \"/home/sir/Downloads/ente-auth-v4.4.27.tar.gz\"",
      "desc": "Downloads \u2022 GZ",
      "type": "file"
    },
    {
      "name": "Antigravity IDE.tar.gz",
      "icon": "package-x-generic",
      "path": "/home/sir/Downloads/Antigravity IDE.tar.gz",
      "location": "Downloads",
      "cmd": "xdg-open \"/home/sir/Downloads/Antigravity IDE.tar.gz\"",
      "desc": "Downloads \u2022 GZ",
      "type": "file"
    },
    {
      "name": "Antigravity-IDE",
      "icon": "folder",
      "path": "/home/sir/Downloads/Antigravity-IDE",
      "location": "Downloads",
      "cmd": "xdg-open \"/home/sir/Downloads/Antigravity-IDE\"",
      "desc": "Downloads \u2022 Folder",
      "type": "file"
    },
    {
      "name": "DiscordCanarySetup.exe",
      "icon": "text-plain",
      "path": "/home/sir/Downloads/DiscordCanarySetup.exe",
      "location": "Downloads",
      "cmd": "xdg-open \"/home/sir/Downloads/DiscordCanarySetup.exe\"",
      "desc": "Downloads \u2022 EXE",
      "type": "file"
    },
    {
      "name": "Screenshot-20261128-012550.png",
      "icon": "image-x-generic",
      "path": "/home/sir/Pictures/Screenshots/Screenshot-20261128-012550.png",
      "location": "Pictures/Screenshots",
      "cmd": "xdg-open \"/home/sir/Pictures/Screenshots/Screenshot-20261128-012550.png\"",
      "desc": "Pictures/Screenshots \u2022 PNG",
      "type": "file"
    },
    {
      "name": "Screenshot-20261128-012303.png",
      "icon": "image-x-generic",
      "path": "/home/sir/Pictures/Screenshots/Screenshot-20261128-012303.png",
      "location": "Pictures/Screenshots",
      "cmd": "xdg-open \"/home/sir/Pictures/Screenshots/Screenshot-20261128-012303.png\"",
      "desc": "Pictures/Screenshots \u2022 PNG",
      "type": "file"
    },
    {
      "name": "stable_position_test.png",
      "icon": "image-x-generic",
      "path": "/home/sir/Pictures/Screenshots/stable_position_test.png",
      "location": "Pictures/Screenshots",
      "cmd": "xdg-open \"/home/sir/Pictures/Screenshots/stable_position_test.png\"",
      "desc": "Pictures/Screenshots \u2022 PNG",
      "type": "file"
    },
    {
      "name": "Screenshots",
      "icon": "folder",
      "path": "/home/sir/Pictures/Screenshots",
      "location": "Pictures",
      "cmd": "xdg-open \"/home/sir/Pictures/Screenshots\"",
      "desc": "Pictures \u2022 Folder",
      "type": "file"
    },
    {
      "name": "Wallpapers",
      "icon": "folder",
      "path": "/home/sir/Pictures/Wallpapers",
      "location": "Pictures",
      "cmd": "xdg-open \"/home/sir/Pictures/Wallpapers\"",
      "desc": "Pictures \u2022 Folder",
      "type": "file"
    },
    {
      "name": "win11-startmenu",
      "icon": "folder",
      "path": "/home/sir/Documents/win11-startmenu",
      "location": "Documents",
      "cmd": "xdg-open \"/home/sir/Documents/win11-startmenu\"",
      "desc": "Documents \u2022 Folder",
      "type": "file"
    }
  ],
  "tools": [
    {
      "name": "Nmap Scanner",
      "icon": "security-high",
      "cmd": "konsole -e nmap --help",
      "desc": "Network Exploration & Security Auditing",
      "category": "Security",
      "type": "tool"
    },
    {
      "name": "Wireshark Packet Analyzer",
      "icon": "security-medium",
      "cmd": "wireshark",
      "desc": "Network Traffic & Protocol Analyzer",
      "category": "Security",
      "type": "tool"
    },
    {
      "name": "Burp Suite",
      "icon": "security-low",
      "cmd": "burpsuite",
      "desc": "Web Application Security Testing",
      "category": "Security",
      "type": "tool"
    },
    {
      "name": "Metasploit Framework",
      "icon": "utilities-terminal",
      "cmd": "konsole -e msfconsole",
      "desc": "Penetration Testing Platform",
      "category": "Security",
      "type": "tool"
    },
    {
      "name": "System Settings",
      "icon": "preferences-system",
      "cmd": "systemsettings",
      "desc": "Configure KDE Plasma Desktop",
      "category": "Settings",
      "type": "tool"
    },
    {
      "name": "Display Configuration",
      "icon": "preferences-desktop-display",
      "cmd": "systemsettings kcm_kscreen",
      "desc": "Manage monitors and resolution",
      "category": "Settings",
      "type": "tool"
    },
    {
      "name": "Audio & Volume Settings",
      "icon": "audio-card",
      "cmd": "systemsettings kcm_pulseaudio",
      "desc": "Manage sound devices & streams",
      "category": "Settings",
      "type": "tool"
    },
    {
      "name": "Network Connections",
      "icon": "network-wired",
      "cmd": "systemsettings kcm_networkmanagement",
      "desc": "Wi-Fi and Ethernet configuration",
      "category": "Settings",
      "type": "tool"
    },
    {
      "name": "Bluetooth Settings",
      "icon": "preferences-system-bluetooth",
      "cmd": "systemsettings kcm_bluetooth",
      "desc": "Pair and manage Bluetooth devices",
      "category": "Settings",
      "type": "tool"
    },
    {
      "name": "Users & Accounts",
      "icon": "user-identity",
      "cmd": "systemsettings kcm_users",
      "desc": "Manage user accounts and passwords",
      "category": "Settings",
      "type": "tool"
    },
    {
      "name": "Power Management",
      "icon": "preferences-system-power-management",
      "cmd": "systemsettings kcm_powerdevilprofilesconfig",
      "desc": "Energy saving and battery management",
      "category": "Settings",
      "type": "tool"
    },
    {
      "name": "Color Scheme & Theme",
      "icon": "preferences-desktop-theme",
      "cmd": "systemsettings kcm_colors",
      "desc": "Appearance, dark mode & accent colors",
      "category": "Settings",
      "type": "tool"
    },
    {
      "name": "Firewall Configuration",
      "icon": "security-high",
      "cmd": "systemsettings kcm_firewall",
      "desc": "UFW / iptables security rules",
      "category": "Security",
      "type": "tool"
    },
    {
      "name": "Package Manager (Pacman)",
      "icon": "system-software-install",
      "cmd": "konsole -e sudo pacman -Syu",
      "desc": "System Updates & Package Management",
      "category": "System",
      "type": "tool"
    },
    {
      "name": "Disk & Storage Partitions",
      "icon": "drive-harddisk",
      "cmd": "systemsettings kcm_disks",
      "desc": "Drives and partition manager",
      "category": "System",
      "type": "tool"
    },
    {
      "name": "Terminal Superuser (Root)",
      "icon": "utilities-terminal",
      "cmd": "konsole -e sudo -i",
      "desc": "Root administrative shell",
      "category": "System",
      "type": "tool"
    }
  ]
};
