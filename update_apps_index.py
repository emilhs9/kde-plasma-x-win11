#!/usr/bin/env python3
import os, glob, json, sys

home = os.path.expanduser("~")
search_db_path = os.path.join(home, ".local/share/plasma/plasmoids/org.kde.plasma.win11startmenu/contents/ui/search_db.js")
repo_db_path = os.path.join(home, "Projects/win11-startmenu/package/contents/ui/search_db.js")

dirs = [
    "/usr/share/applications",
    os.path.join(home, ".local/share/applications"),
    "/var/lib/flatpak/exports/share/applications"
]

apps = []
seen_names = set()
for d in dirs:
    if os.path.exists(d):
        for f in glob.glob(os.path.join(d, "*.desktop")):
            try:
                name, icon, exec_cmd, comment, nodisplay, cats = "", "", "", "", False, "Utilities"
                with open(f, "r", errors="ignore") as fp:
                    for line in fp:
                        line = line.strip()
                        if line.startswith("Name=") and not name:
                            name = line[5:].strip()
                        elif line.startswith("Icon=") and not icon:
                            icon = line[5:].strip()
                        elif line.startswith("Exec=") and not exec_cmd:
                            exec_cmd = line[5:].strip()
                        elif line.startswith("Comment=") and not comment:
                            comment = line[8:].strip()
                        elif line.startswith("Categories=") and cats == "Utilities":
                            c_line = line[11:]
                            if "Audio" in c_line or "Video" in c_line or "Media" in c_line: cats = "Multimedia"
                            elif "Network" in c_line or "Web" in c_line: cats = "Internet"
                            elif "Development" in c_line: cats = "Development"
                            elif "System" in c_line: cats = "System"
                            elif "Settings" in c_line: cats = "Settings"
                        elif line == "NoDisplay=true":
                            nodisplay = True
                if not nodisplay and name and exec_cmd and name.lower() not in seen_names:
                    seen_names.add(name.lower())
                    clean_exec = exec_cmd.split("%")[0].strip()
                    apps.append({
                        "name": name,
                        "icon": icon or "application-x-executable",
                        "cmd": clean_exec,
                        "desc": comment or f"{cats} • Application",
                        "category": cats,
                        "desktop": f,
                        "type": "app"
                    })
            except Exception:
                pass

# Real user files
scan_paths = [
    (os.path.join(home, "Desktop"), "Desktop"),
    (os.path.join(home, "Desktop/ops"), "Desktop/ops"),
    (os.path.join(home, "Downloads"), "Downloads"),
    (os.path.join(home, "Pictures/Screenshots"), "Pictures/Screenshots"),
    (os.path.join(home, "Pictures"), "Pictures"),
    (os.path.join(home, "Documents"), "Documents")
]

file_list = []
for p, rel in scan_paths:
    if os.path.exists(p):
        try:
            for item in os.listdir(p):
                full = os.path.join(p, item)
                ext = item.split('.')[-1].lower() if '.' in item else ""
                icon = "text-plain"
                if os.path.isdir(full): icon = "folder"
                elif ext in ["png", "jpg", "jpeg", "svg", "webp"]: icon = "image-x-generic"
                elif ext in ["pdf"]: icon = "application-pdf"
                elif ext in ["zip", "rar", "tar", "gz", "7z"]: icon = "package-x-generic"
                elif ext in ["mp4", "mkv", "wmv", "avi"]: icon = "video-x-generic"
                elif ext in ["json", "xml", "yaml", "yml"]: icon = "application-json"
                elif ext in ["pem", "key", "cert", "crt"]: icon = "security-high"
                elif ext in ["qml", "js", "ts", "py", "sh", "cpp", "c", "h"]: icon = "text-x-script"
                
                file_list.append({
                    "name": item,
                    "icon": icon,
                    "path": full,
                    "location": rel,
                    "cmd": f'xdg-open "{full}"',
                    "desc": f"{rel} • {ext.upper() if ext else ('Folder' if os.path.isdir(full) else 'File')}",
                    "type": "file"
                })
        except Exception:
            pass

tools_list = [
    {"name": "Nmap Scanner", "icon": "security-high", "cmd": "konsole -e nmap --help", "desc": "Network Exploration & Security Auditing", "category": "Security", "type": "tool"},
    {"name": "Wireshark Packet Analyzer", "icon": "security-medium", "cmd": "wireshark", "desc": "Network Traffic & Protocol Analyzer", "category": "Security", "type": "tool"},
    {"name": "Burp Suite", "icon": "security-low", "cmd": "burpsuite", "desc": "Web Application Security Testing", "category": "Security", "type": "tool"},
    {"name": "Metasploit Framework", "icon": "utilities-terminal", "cmd": "konsole -e msfconsole", "desc": "Penetration Testing Platform", "category": "Security", "type": "tool"},
    {"name": "System Settings", "icon": "preferences-system", "cmd": "systemsettings", "desc": "Configure KDE Plasma Desktop", "category": "Settings", "type": "tool"},
    {"name": "Display Configuration", "icon": "preferences-desktop-display", "cmd": "systemsettings kcm_kscreen", "desc": "Manage monitors and resolution", "category": "Settings", "type": "tool"},
    {"name": "Audio & Volume Settings", "icon": "audio-card", "cmd": "systemsettings kcm_pulseaudio", "desc": "Manage sound devices & streams", "category": "Settings", "type": "tool"},
    {"name": "Network Connections", "icon": "network-wired", "cmd": "systemsettings kcm_networkmanagement", "desc": "Wi-Fi and Ethernet configuration", "category": "Settings", "type": "tool"},
    {"name": "Bluetooth Settings", "icon": "preferences-system-bluetooth", "cmd": "systemsettings kcm_bluetooth", "desc": "Pair and manage Bluetooth devices", "category": "Settings", "type": "tool"},
    {"name": "Users & Accounts", "icon": "user-identity", "cmd": "systemsettings kcm_users", "desc": "Manage user accounts and passwords", "category": "Settings", "type": "tool"},
    {"name": "Power Management", "icon": "preferences-system-power-management", "cmd": "systemsettings kcm_powerdevilprofilesconfig", "desc": "Energy saving and battery management", "category": "Settings", "type": "tool"},
    {"name": "Color Scheme & Theme", "icon": "preferences-desktop-theme", "cmd": "systemsettings kcm_colors", "desc": "Appearance, dark mode & accent colors", "category": "Settings", "type": "tool"},
    {"name": "Firewall Configuration", "icon": "security-high", "cmd": "systemsettings kcm_firewall", "desc": "UFW / iptables security rules", "category": "Security", "type": "tool"},
    {"name": "Package Manager (Pacman)", "icon": "system-software-install", "cmd": "konsole -e sudo pacman -Syu", "desc": "System Updates & Package Management", "category": "System", "type": "tool"},
    {"name": "Disk & Storage Partitions", "icon": "drive-harddisk", "cmd": "systemsettings kcm_disks", "desc": "Drives and partition manager", "category": "System", "type": "tool"},
    {"name": "Terminal Superuser (Root)", "icon": "utilities-terminal", "cmd": "konsole -e sudo -i", "desc": "Root administrative shell", "category": "System", "type": "tool"}
]

search_db = {
    "apps": sorted(apps, key=lambda x: x["name"].lower()),
    "files": file_list,
    "tools": tools_list
}

js_content = ".pragma library\n\nvar searchDb = " + json.dumps(search_db, indent=2) + ";\n"

for target in [search_db_path, repo_db_path]:
    try:
        os.makedirs(os.path.dirname(target), exist_ok=True)
        with open(target, "w") as f:
            f.write(js_content)
    except Exception as e:
        print("Error writing target:", target, e)

print("Updated search_db.js with", len(apps), "dynamically discovered applications")
