.pragma library

var toolsDb = {
  "places": [
    {
      "name": "Home",
      "desc": "~/ (Personal Folder)",
      "icon": "user-home-symbolic",
      "path": "/home/sir"
    },
    {
      "name": "Documents",
      "desc": "~/Documents",
      "icon": "folder-documents-symbolic",
      "path": "/home/sir/Documents"
    },
    {
      "name": "Downloads",
      "desc": "~/Downloads",
      "icon": "folder-download-symbolic",
      "path": "/home/sir/Downloads"
    },
    {
      "name": "Pictures",
      "desc": "~/Pictures",
      "icon": "folder-pictures-symbolic",
      "path": "/home/sir/Pictures"
    },
    {
      "name": "Music",
      "desc": "~/Music",
      "icon": "folder-music-symbolic",
      "path": "/home/sir/Music"
    },
    {
      "name": "Videos",
      "desc": "~/Videos",
      "icon": "folder-videos-symbolic",
      "path": "/home/sir/Videos"
    }
  ],
  "categories": [
    {
      "title": "SECURITY & NETWORK",
      "color": "#22d3ee",
      "items": [
        {
          "name": "Nmap Scanner",
          "desc": "Network Recon & Port Audit",
          "icon": "security-high",
          "cmd": "konsole -e bash -c 'if command -v nmap &>/dev/null; then nmap --help; else echo \"[*] Nmap is not installed. Press Enter to install...\"; read; sudo pacman -S --needed nmap; fi; bash'",
          "installed": false
        },
        {
          "name": "Wireshark",
          "desc": "Packet Analysis & Sniffer",
          "icon": "network-wired",
          "cmd": "wireshark",
          "installed": false
        },
        {
          "name": "Burp Suite",
          "desc": "Web Application Security",
          "icon": "security-medium",
          "cmd": "burpsuite",
          "installed": false
        },
        {
          "name": "Metasploit",
          "desc": "Exploit Framework & Console",
          "icon": "utilities-terminal",
          "cmd": "konsole -e bash -c 'if command -v msfconsole &>/dev/null; then msfconsole; else echo \"[*] Metasploit is not installed. Press Enter to install...\"; read; yay -S --needed metasploit; fi; bash'",
          "installed": false
        },
        {
          "name": "Ente Auth",
          "desc": "2FA Authenticator by Ente",
          "icon": "/home/sir/.local/share/ente-auth/ente-auth.png",
          "cmd": "/home/sir/.local/share/ente-auth/ente-auth-v4.4.27-x86_64.AppImage",
          "installed": true
        }
      ]
    },
    {
      "title": "SYSTEM & TOOLS",
      "color": "#38bdf8",
      "items": [
        {
          "name": "System Settings",
          "desc": "Hardware & Display",
          "icon": "systemsettings",
          "cmd": "systemsettings",
          "installed": true
        },
        {
          "name": "About System",
          "desc": "OS & Kernel Info",
          "icon": "help-about-symbolic",
          "cmd": "kinfocenter",
          "installed": true
        },
        {
          "name": "System Monitor",
          "desc": "Process & Resource Usage",
          "icon": "utilities-system-monitor",
          "cmd": "plasma-systemmonitor",
          "installed": true
        },
        {
          "name": "Konsole Terminal",
          "desc": "KDE Command Line Shell",
          "icon": "utilities-terminal",
          "cmd": "konsole",
          "installed": true
        },
        {
          "name": "Kitty GPU Terminal",
          "desc": "Fast GPU-accelerated Terminal",
          "icon": "kitty",
          "cmd": "kitty",
          "installed": true
        },
        {
          "name": "Htop Monitor",
          "desc": "Interactive Process Viewer",
          "icon": "htop",
          "cmd": "konsole -e htop",
          "installed": true
        },
        {
          "name": "Package Manager",
          "desc": "Discover & Software Updates",
          "icon": "package-x-generic",
          "cmd": "plasma-discover",
          "installed": true
        },
        {
          "name": "Disk Partitions",
          "desc": "Storage & Drive Health",
          "icon": "drive-harddisk",
          "cmd": "systemsettings kcm_disks",
          "installed": true
        },
        {
          "name": "Firewall Config",
          "desc": "UFW & Network Security Rules",
          "icon": "security-high",
          "cmd": "systemsettings kcm_firewall",
          "installed": true
        },
        {
          "name": "Hardware Locality",
          "desc": "CPU & Hardware Topology",
          "icon": "hwloc",
          "cmd": "lstopo",
          "installed": true
        },
        {
          "name": "Crashed Processes",
          "desc": "Inspect Crash Reports & Dumps",
          "icon": "tools-report-bug",
          "cmd": "drkonqi-coredump-gui",
          "installed": true
        },
        {
          "name": "Print Settings",
          "desc": "Local & Network Printers",
          "icon": "printer",
          "cmd": "system-config-printer",
          "installed": true
        },
        {
          "name": "Menu Editor",
          "desc": "Edit how applications are prese...",
          "icon": "kmenuedit",
          "cmd": "kmenuedit",
          "installed": true
        },
        {
          "name": "Manage Printing",
          "desc": "CUPS Web Interface",
          "icon": "cups",
          "cmd": "xdg-open http://localhost:631/",
          "installed": true
        },
        {
          "name": "uuctl",
          "desc": "Select and perform actions on u...",
          "icon": "applications-system",
          "cmd": "uuctl",
          "installed": true
        }
      ]
    },
    {
      "title": "DEVELOPMENT & UTILITIES",
      "color": "#818cf8",
      "items": [
        {
          "name": "Visual Studio Code",
          "desc": "Code Editing Redefined",
          "icon": "com.visualstudio.code",
          "cmd": "flatpak run com.visualstudio.code",
          "installed": true
        },
        {
          "name": "Google Antigravity",
          "desc": "AI Coding IDE & Workspace",
          "icon": "antigravity",
          "cmd": "antigravity",
          "installed": true
        },
        {
          "name": "CMake GUI",
          "desc": "Cross-Platform Build System",
          "icon": "CMakeSetup",
          "cmd": "cmake-gui",
          "installed": true
        },
        {
          "name": "Qt Designer",
          "desc": "Qt GUI Layout Designer",
          "icon": "designer",
          "cmd": "designer6",
          "installed": true
        },
        {
          "name": "Qt Assistant",
          "desc": "Qt Documentation Browser",
          "icon": "assistant",
          "cmd": "assistant6",
          "installed": true
        },
        {
          "name": "Qt D-Bus Viewer",
          "desc": "D-Bus Introspection Debugger",
          "icon": "qdbusviewer",
          "cmd": "qdbusviewer6",
          "installed": true
        },
        {
          "name": "GDB Debugger",
          "desc": "GNU Project Debugger",
          "icon": "utilities-terminal",
          "cmd": "konsole -e gdb",
          "installed": true
        },
        {
          "name": "Vim Editor",
          "desc": "Advanced Terminal Text Editor",
          "icon": "gvim",
          "cmd": "konsole -e vim",
          "installed": true
        },
        {
          "name": "Qt V4L2 video capture utility",
          "desc": "Viewer for video capture",
          "icon": "qvidcap",
          "cmd": "qvidcap",
          "installed": true
        },
        {
          "name": "Qt Linguist",
          "desc": "Add translations to Qt applicat...",
          "icon": "linguist",
          "cmd": "linguist6",
          "installed": true
        },
        {
          "name": "Qt V4L2 test Utility",
          "desc": "Allow testing Video4Linux devices",
          "icon": "qv4l2",
          "cmd": "qv4l2",
          "installed": true
        }
      ]
    }
  ]
};
