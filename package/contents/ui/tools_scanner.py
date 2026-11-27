#!/usr/bin/env python3
import os
import sys
import glob
import json
import shutil
import re

home = os.path.expanduser("~")

def get_places():
    return [
        {"name": "Home", "desc": "~/ (Personal Folder)", "icon": "user-home-symbolic", "path": home},
        {"name": "Documents", "desc": "~/Documents", "icon": "folder-documents-symbolic", "path": os.path.join(home, "Documents")},
        {"name": "Downloads", "desc": "~/Downloads", "icon": "folder-download-symbolic", "path": os.path.join(home, "Downloads")},
        {"name": "Pictures", "desc": "~/Pictures", "icon": "folder-pictures-symbolic", "path": os.path.join(home, "Pictures")},
        {"name": "Music", "desc": "~/Music", "icon": "folder-music-symbolic", "path": os.path.join(home, "Music")},
        {"name": "Videos", "desc": "~/Videos", "icon": "folder-videos-symbolic", "path": os.path.join(home, "Videos")}
    ]

# Curated security tools definition with fallback launcher
KNOWN_SECURITY_TOOLS = [
    {
        "bin": "nmap",
        "name": "Nmap Scanner",
        "desc": "Network Recon & Port Audit",
        "icon": "security-high",
        "cmd": "konsole -e bash -c 'if command -v nmap &>/dev/null; then nmap --help; else echo \"[*] Nmap is not installed. Press Enter to install...\"; read; sudo pacman -S --needed nmap; fi; bash'",
        "pkg": "nmap"
    },
    {
        "bin": "wireshark",
        "name": "Wireshark",
        "desc": "Packet Analysis & Sniffer",
        "icon": "network-wired",
        "cmd": "wireshark",
        "pkg": "wireshark-qt"
    },
    {
        "bin": "burpsuite",
        "name": "Burp Suite",
        "desc": "Web Application Security",
        "icon": "security-medium",
        "cmd": "burpsuite",
        "pkg": "burpsuite"
    },
    {
        "bin": "msfconsole",
        "name": "Metasploit",
        "desc": "Exploit Framework & Console",
        "icon": "utilities-terminal",
        "cmd": "konsole -e bash -c 'if command -v msfconsole &>/dev/null; then msfconsole; else echo \"[*] Metasploit is not installed. Press Enter to install...\"; read; yay -S --needed metasploit; fi; bash'",
        "pkg": "metasploit"
    },
    {
        "bin": "aircrack-ng",
        "name": "Aircrack-ng",
        "desc": "Wireless Security & 802.11 Audit",
        "icon": "network-wireless",
        "cmd": "konsole -e aircrack-ng --help",
        "pkg": "aircrack-ng"
    },
    {
        "bin": "tcpdump",
        "name": "Tcpdump",
        "desc": "Command-line Packet Analyzer",
        "icon": "utilities-terminal",
        "cmd": "konsole -e sudo tcpdump -h",
        "pkg": "tcpdump"
    },
    {
        "bin": "john",
        "name": "John the Ripper",
        "desc": "Password Cracker & Security Audit",
        "icon": "security-low",
        "cmd": "konsole -e john",
        "pkg": "john"
    },
    {
        "bin": "hydra",
        "name": "Hydra",
        "desc": "Network Login Brute-Forcer",
        "icon": "security-low",
        "cmd": "konsole -e hydra -h",
        "pkg": "hydra"
    },
    {
        "bin": "sqlmap",
        "name": "SQLmap",
        "desc": "Automatic SQL Injection Engine",
        "icon": "security-medium",
        "cmd": "konsole -e sqlmap -h",
        "pkg": "sqlmap"
    },
    {
        "bin": "hashcat",
        "name": "Hashcat",
        "desc": "Advanced Password Recovery",
        "icon": "security-high",
        "cmd": "konsole -e hashcat --help",
        "pkg": "hashcat"
    },
    {
        "bin": "ghidra",
        "name": "Ghidra",
        "desc": "Software Reverse Engineering",
        "icon": "system-run",
        "cmd": "ghidra",
        "pkg": "ghidra"
    },
    {
        "bin": "r2",
        "name": "Radare2",
        "desc": "Disassembler & Binary Analysis",
        "icon": "utilities-terminal",
        "cmd": "konsole -e r2 -h",
        "pkg": "radare2"
    },
    {
        "bin": "ettercap",
        "name": "Ettercap",
        "desc": "Network MitM Suite & Sniffer",
        "icon": "security-medium",
        "cmd": "ettercap -G",
        "pkg": "ettercap"
    },
    {
        "bin": "nikto",
        "name": "Nikto",
        "desc": "Web Server Vulnerability Scanner",
        "icon": "security-medium",
        "cmd": "konsole -e nikto -H",
        "pkg": "nikto"
    },
    {
        "bin": "gobuster",
        "name": "Gobuster",
        "desc": "Directory & DNS Bruteforcing",
        "icon": "utilities-terminal",
        "cmd": "konsole -e gobuster -h",
        "pkg": "gobuster"
    },
    {
        "bin": "ffuf",
        "name": "FFUF",
        "desc": "Fast Web Fuzzer",
        "icon": "utilities-terminal",
        "cmd": "konsole -e ffuf -h",
        "pkg": "ffuf"
    }
]

# Scan desktop files
desktop_dirs = [
    "/usr/share/applications",
    os.path.join(home, ".local/share/applications"),
    "/var/lib/flatpak/exports/share/applications"
]

all_desktop_apps = []
seen_desktop_names = set()

for d in desktop_dirs:
    if not os.path.exists(d): continue
    for f in glob.glob(os.path.join(d, "*.desktop")):
        try:
            name, icon, exec_cmd, comment, nodisplay, cats = "", "", "", "", False, ""
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
                    elif line.startswith("Categories=") and not cats:
                        cats = line[11:].strip()
                    elif line == "NoDisplay=true":
                        nodisplay = True
            if not nodisplay and name and exec_cmd:
                clean_cmd = exec_cmd.split("%")[0].strip()
                n_key = name.lower()
                if n_key not in seen_desktop_names:
                    seen_desktop_names.add(n_key)
                    all_desktop_apps.append({
                        "name": name,
                        "icon": icon or "application-x-executable",
                        "cmd": clean_cmd,
                        "desc": comment or name,
                        "cats": cats,
                        "file": f
                    })
        except Exception:
            pass

def get_base_exec(cmd):
    parts = cmd.split()
    if not parts: return ""
    base = os.path.basename(parts[0])
    if base in ["flatpak", "konsole", "kitty", "bash", "sh", "sudo"] and len(parts) > 1:
        # find the actual command
        for p in parts[1:]:
            if not p.startswith("-"):
                return os.path.basename(p)
    return base

seen_binaries = set()
seen_normalized_names = set()

def normalize_key(name, cmd):
    b = get_base_exec(cmd).lower()
    clean_name = re.sub(r'[^a-zA-Z0-9]', '', name.lower())
    return b, clean_name

# 1. Gather Security & Network
security_items = []

for tool in KNOWN_SECURITY_TOOLS:
    bin_path = shutil.which(tool["bin"])
    # Include primary 4 guaranteed, or any tool whose binary exists on the system
    if bin_path or tool["bin"] in ["nmap", "wireshark", "burpsuite", "msfconsole"]:
        b, n = normalize_key(tool["name"], tool["cmd"])
        seen_binaries.add(b)
        seen_normalized_names.add(n)
        security_items.append({
            "name": tool["name"],
            "desc": tool["desc"],
            "icon": tool["icon"],
            "cmd": tool["cmd"],
            "installed": bool(bin_path)
        })

for app in all_desktop_apps:
    cats_lower = app["cats"].lower()
    name_lower = app["name"].lower()
    desc_lower = app["desc"].lower()
    b, n = normalize_key(app["name"], app["cmd"])
    
    if b in seen_binaries or n in seen_normalized_names:
        continue

    is_sec = ("security" in cats_lower) or any(w in name_lower or w in desc_lower for w in ["firewall", "auth", "vpn", "wireshark", "nmap", "metasploit", "crypto", "sniffer", "recon"])
    is_net = ("network" in cats_lower or "remoteaccess" in cats_lower) and not any(b_name in name_lower for b_name in ["browser", "discord", "brave", "firefox", "chrome", "web"])
    
    if is_sec or is_net:
        if any(ex in name_lower for ex in ["menu editor", "emoji", "theme selector", "crashed"]):
            continue
        seen_binaries.add(b)
        seen_normalized_names.add(n)
        clean_desc = app["desc"]
        if len(clean_desc) > 34: clean_desc = clean_desc[:31] + "..."
        security_items.append({
            "name": app["name"],
            "desc": clean_desc,
            "icon": app["icon"],
            "cmd": app["cmd"],
            "installed": True
        })

# 2. Gather System & Tools
system_items = [
    {"name": "System Settings", "desc": "Hardware & Display", "icon": "systemsettings", "cmd": "systemsettings", "installed": True},
    {"name": "About System", "desc": "OS & Kernel Info", "icon": "help-about-symbolic", "cmd": "kinfocenter", "installed": True},
    {"name": "System Monitor", "desc": "Process & Resource Usage", "icon": "utilities-system-monitor", "cmd": "plasma-systemmonitor", "installed": True},
    {"name": "Konsole Terminal", "desc": "KDE Command Line Shell", "icon": "utilities-terminal", "cmd": "konsole", "installed": True},
    {"name": "Kitty GPU Terminal", "desc": "Fast GPU-accelerated Terminal", "icon": "kitty", "cmd": "kitty", "installed": bool(shutil.which("kitty"))},
    {"name": "Htop Monitor", "desc": "Interactive Process Viewer", "icon": "htop", "cmd": "konsole -e htop", "installed": bool(shutil.which("htop"))},
    {"name": "Package Manager", "desc": "Discover & Software Updates", "icon": "package-x-generic", "cmd": "plasma-discover", "installed": True},
    {"name": "Disk Partitions", "desc": "Storage & Drive Health", "icon": "drive-harddisk", "cmd": "systemsettings kcm_disks", "installed": True},
    {"name": "Firewall Config", "desc": "UFW & Network Security Rules", "icon": "security-high", "cmd": "systemsettings kcm_firewall", "installed": True},
    {"name": "Hardware Locality", "desc": "CPU & Hardware Topology", "icon": "hwloc", "cmd": "lstopo", "installed": bool(shutil.which("lstopo"))},
    {"name": "Crashed Processes", "desc": "Inspect Crash Reports & Dumps", "icon": "tools-report-bug", "cmd": "drkonqi-coredump-gui", "installed": True},
    {"name": "Print Settings", "desc": "Local & Network Printers", "icon": "printer", "cmd": "system-config-printer", "installed": True}
]

for s in system_items:
    b, n = normalize_key(s["name"], s["cmd"])
    seen_binaries.add(b)
    seen_normalized_names.add(n)

for app in all_desktop_apps:
    cats_lower = app["cats"].lower()
    name_lower = app["name"].lower()
    b, n = normalize_key(app["name"], app["cmd"])

    if b in seen_binaries or n in seen_normalized_names:
        continue
    
    # Exclude basic launchers that are not system tools
    if any(ex in name_lower for ex in ["discover", "dolphin", "logout", "restart", "shutdown", "vlc", "audio", "video"]):
        continue

    if any(k in cats_lower for k in ["system", "settings", "hardwaresettings", "monitor", "printing"]):
        seen_binaries.add(b)
        seen_normalized_names.add(n)
        clean_desc = app["desc"]
        if len(clean_desc) > 34: clean_desc = clean_desc[:31] + "..."
        system_items.append({
            "name": app["name"],
            "desc": clean_desc,
            "icon": app["icon"],
            "cmd": app["cmd"],
            "installed": True
        })

# 3. Gather Development & Utilities
dev_items = [
    {"name": "Visual Studio Code", "desc": "Code Editing Redefined", "icon": "com.visualstudio.code", "cmd": "flatpak run com.visualstudio.code", "installed": True},
    {"name": "Google Antigravity", "desc": "AI Coding IDE & Workspace", "icon": "antigravity", "cmd": "antigravity", "installed": True},
    {"name": "CMake GUI", "desc": "Cross-Platform Build System", "icon": "CMakeSetup", "cmd": "cmake-gui", "installed": bool(shutil.which("cmake-gui"))},
    {"name": "Qt Designer", "desc": "Qt GUI Layout Designer", "icon": "designer", "cmd": "designer6", "installed": bool(shutil.which("designer6") or shutil.which("designer"))},
    {"name": "Qt Assistant", "desc": "Qt Documentation Browser", "icon": "assistant", "cmd": "assistant6", "installed": bool(shutil.which("assistant6") or shutil.which("assistant"))},
    {"name": "Qt D-Bus Viewer", "desc": "D-Bus Introspection Debugger", "icon": "qdbusviewer", "cmd": "qdbusviewer6", "installed": bool(shutil.which("qdbusviewer6") or shutil.which("qdbusviewer"))},
    {"name": "GDB Debugger", "desc": "GNU Project Debugger", "icon": "utilities-terminal", "cmd": "konsole -e gdb", "installed": bool(shutil.which("gdb"))},
    {"name": "Vim Editor", "desc": "Advanced Terminal Text Editor", "icon": "gvim", "cmd": "konsole -e vim", "installed": bool(shutil.which("vim"))}
]

for d in dev_items:
    b, n = normalize_key(d["name"], d["cmd"])
    seen_binaries.add(b)
    seen_normalized_names.add(n)

for app in all_desktop_apps:
    cats_lower = app["cats"].lower()
    name_lower = app["name"].lower()
    b, n = normalize_key(app["name"], app["cmd"])

    if b in seen_binaries or n in seen_normalized_names:
        continue
    
    if any(ex in name_lower for ex in ["vlc", "player", "recorder", "audio", "video test"]):
        continue

    if any(k in cats_lower for k in ["development", "debugger", "building", "ide", "texteditor"]):
        seen_binaries.add(b)
        seen_normalized_names.add(n)
        clean_desc = app["desc"]
        if len(clean_desc) > 34: clean_desc = clean_desc[:31] + "..."
        dev_items.append({
            "name": app["name"],
            "desc": clean_desc,
            "icon": app["icon"],
            "cmd": app["cmd"],
            "installed": True
        })

def get_activity_columns():
    # 1. Operations (Əvvəlki əməliyyatlar - 3 rows)
    ops = [
        {"name": "Pacman Update", "desc": "Sistem yeniləmə", "icon": "system-software-install", "cmd": "konsole -e sudo pacman -Syu"},
        {"name": "Git Status & Log", "desc": "Repo vəziyyəti", "icon": "vcs-git", "cmd": "konsole -e bash -c 'git status; git log -n 5; bash'"},
        {"name": "Plasma Yenilə", "desc": "KDE qabığını yenilə", "icon": "view-refresh", "cmd": "systemctl --user restart plasma-plasmashell.service"}
    ]

    # 2. Visited Places (Girilən yerlər - 3 rows)
    places = [
        {"name": "Downloads", "desc": "~/Downloads", "icon": "folder-download-symbolic", "path": os.path.join(home, "Downloads")},
        {"name": "Documents", "desc": "~/Documents", "icon": "folder-documents-symbolic", "path": os.path.join(home, "Documents")},
        {"name": "Desktop / Ops", "desc": "~/Desktop/ops", "icon": "folder", "path": os.path.join(home, "Desktop/ops") if os.path.exists(os.path.join(home, "Desktop/ops")) else os.path.join(home, "Desktop")}
    ]

    # 3. Downloads (Yüklənənlər - 3 rows)
    downloads = []
    down_dir = os.path.join(home, "Downloads")
    if os.path.exists(down_dir):
        all_d = sorted(glob.glob(os.path.join(down_dir, "*")), key=os.path.getmtime, reverse=True)
        for f in all_d:
            bname = os.path.basename(f)
            if bname.startswith("."): continue
            ext = bname.split(".")[-1].lower() if "." in bname else ""
            icon = "package-x-generic" if ext in ["tar", "gz", "zip", "xz"] else ("application-x-ms-dos-executable" if ext == "exe" else ("folder" if os.path.isdir(f) else "document-open"))
            clean_name = bname if len(bname) <= 18 else bname[:15] + "..."
            downloads.append({
                "name": clean_name,
                "desc": "Downloads • " + (ext.upper() if ext else ("Qovluq" if os.path.isdir(f) else "Fayl")),
                "icon": icon,
                "path": f
            })
            if len(downloads) >= 3: break

    # 4. Recent Files (Açılanlar - 3 rows)
    recent_files = []
    xbel = os.path.join(home, ".local/share/recently-used.xbel")
    seen = set()
    
    # Priority desktop / ops files if present
    curated = [
        (os.path.join(home, "Desktop/Emil_Suleymanli_CV_EN.pdf"), "Emil_CV.pdf", "Desktop • PDF", "application-pdf"),
        (os.path.join(home, "Desktop/ops/proxy.txt"), "proxy.txt", "Desktop/ops • Text", "text-plain"),
        (os.path.join(home, "Desktop/ops/antigravity-skills.md"), "skills.md", "Desktop/ops • MD", "text-markdown")
    ]
    for c_path, c_name, c_desc, c_icon in curated:
        if os.path.exists(c_path):
            seen.add(os.path.basename(c_path))
            recent_files.append({"name": c_name, "desc": c_desc, "icon": c_icon, "path": c_path})
            if len(recent_files) >= 2: break

    if os.path.exists(xbel):
        try:
            import xml.etree.ElementTree as ET
            import urllib.parse
            tree = ET.parse(xbel)
            for bm in reversed(tree.getroot().findall("bookmark")):
                href = bm.get("href", "")
                if href.startswith("file://"):
                    p = urllib.parse.unquote(href[7:])
                    if os.path.exists(p) and not os.path.isdir(p):
                        bname = os.path.basename(p)
                        if bname not in seen and not bname.endswith(".tmp") and not bname.startswith("."):
                            seen.add(bname)
                            ext = bname.split(".")[-1].lower() if "." in bname else ""
                            icon = "image-x-generic" if ext in ["png", "jpg", "jpeg", "svg"] else ("application-pdf" if ext == "pdf" else "text-plain")
                            clean_name = bname if len(bname) <= 18 else bname[:15] + "..."
                            rel_dir = os.path.dirname(p).replace(home, "~")
                            recent_files.append({
                                "name": clean_name,
                                "desc": rel_dir + " • " + (ext.upper() if ext else "Fayl"),
                                "icon": icon,
                                "path": p
                            })
                            if len(recent_files) >= 3: break
        except Exception:
            pass

    return [
        {"title": "Əməliyyatlar", "icon": "utilities-terminal", "color": "#38bdf8", "items": ops[:3]},
        {"title": "Girilən Yerlər", "icon": "folder-open", "color": "#00f2fe", "items": places[:3]},
        {"title": "Yüklənənlər", "icon": "folder-download", "color": "#a78bfa", "items": downloads[:3]},
        {"title": "Açılanlar", "icon": "document-open-recent", "color": "#34d399", "items": recent_files[:3]}
    ]

output_data = {
    "places": get_places(),
    "activity_columns": get_activity_columns(),
    "categories": [
        {
            "title": "SECURITY & NETWORK",
            "color": "#22d3ee",
            "items": security_items
        },
        {
            "title": "SYSTEM & TOOLS",
            "color": "#38bdf8",
            "items": system_items
        },
        {
            "title": "DEVELOPMENT & UTILITIES",
            "color": "#818cf8",
            "items": dev_items
        }
    ]
}

# Update static cache JS file
js_content = ".pragma library\n\nvar toolsDb = " + json.dumps(output_data, indent=2) + ";\n"

target_dirs = [
    os.path.join(home, ".local/share/plasma/plasmoids/org.kde.plasma.win11startmenu/contents/ui"),
    os.path.dirname(os.path.abspath(__file__))
]

for tdir in target_dirs:
    try:
        if os.path.exists(tdir):
            with open(os.path.join(tdir, "tools_db.js"), "w") as fp:
                fp.write(js_content)
    except Exception:
        pass

# Output JSON for QML
print(json.dumps(output_data))
