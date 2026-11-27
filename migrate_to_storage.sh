#!/bin/bash
set -e

USER_NAME="sir"
USER_HOME="/home/$USER_NAME"
DATA_DIR="/data"

echo "[*] 1. /data qovluğunda struktur yaradılır..."
mkdir -p "$DATA_DIR/Downloads"
mkdir -p "$DATA_DIR/Pictures/Screenshots"
mkdir -p "$DATA_DIR/Videos"
mkdir -p "$DATA_DIR/Music"
mkdir -p "$DATA_DIR/Projects"
mkdir -p "$DATA_DIR/Games"
mkdir -p "$DATA_DIR/Documents"
mkdir -p "$DATA_DIR/Antigravity"
mkdir -p "$DATA_DIR/user_var"
mkdir -p "$DATA_DIR/system/flatpak"
mkdir -p "$DATA_DIR/system/pacman_cache"

echo "[*] 2. Mövcud istifadəçi faylları /data-ya köçürülür..."

# Downloads
if [ -d "$USER_HOME/Downloads" ] && [ ! -L "$USER_HOME/Downloads" ]; then
    cp -a "$USER_HOME/Downloads/." "$DATA_DIR/Downloads/" || true
    rm -rf "$USER_HOME/Downloads"
fi
ln -sfn "$DATA_DIR/Downloads" "$USER_HOME/Downloads"

# Pictures
if [ -d "$USER_HOME/Pictures" ] && [ ! -L "$USER_HOME/Pictures" ]; then
    cp -a "$USER_HOME/Pictures/." "$DATA_DIR/Pictures/" || true
    rm -rf "$USER_HOME/Pictures"
fi
ln -sfn "$DATA_DIR/Pictures" "$USER_HOME/Pictures"

# Videos
if [ -d "$USER_HOME/Videos" ] && [ ! -L "$USER_HOME/Videos" ]; then
    cp -a "$USER_HOME/Videos/." "$DATA_DIR/Videos/" || true
    rm -rf "$USER_HOME/Videos"
fi
ln -sfn "$DATA_DIR/Videos" "$USER_HOME/Videos"

# Music
if [ -d "$USER_HOME/Music" ] && [ ! -L "$USER_HOME/Music" ]; then
    cp -a "$USER_HOME/Music/." "$DATA_DIR/Music/" || true
    rm -rf "$USER_HOME/Music"
fi
ln -sfn "$DATA_DIR/Music" "$USER_HOME/Music"

# Projects
if [ -d "$USER_HOME/Projects" ] && [ ! -L "$USER_HOME/Projects" ]; then
    cp -a "$USER_HOME/Projects/." "$DATA_DIR/Projects/" || true
    rm -rf "$USER_HOME/Projects"
fi
ln -sfn "$DATA_DIR/Projects" "$USER_HOME/Projects"

# Antigravity
if [ -d "$USER_HOME/Antigravity" ] && [ ! -L "$USER_HOME/Antigravity" ]; then
    cp -a "$USER_HOME/Antigravity/." "$DATA_DIR/Antigravity/" || true
    rm -rf "$USER_HOME/Antigravity"
fi
ln -sfn "$DATA_DIR/Antigravity" "$USER_HOME/Antigravity"

# ~/.var (Flatpak apps user data - 1.3 GB)
if [ -d "$USER_HOME/.var" ] && [ ! -L "$USER_HOME/.var" ]; then
    cp -a "$USER_HOME/.var/." "$DATA_DIR/user_var/" || true
    rm -rf "$USER_HOME/.var"
fi
ln -sfn "$DATA_DIR/user_var" "$USER_HOME/.var"

echo "[*] 3. Sistem səviyyəli böyük yaddaşlar (Flatpak & Pacman) /data-ya köçürülür..."

# Flatpak system apps (6.2 GB)
if [ -d "/var/lib/flatpak" ]; then
    if ! mountpoint -q /var/lib/flatpak; then
        cp -a /var/lib/flatpak/. "$DATA_DIR/system/flatpak/" || true
        rm -rf /var/lib/flatpak/*
        mount --bind "$DATA_DIR/system/flatpak" /var/lib/flatpak
        if ! grep -q "$DATA_DIR/system/flatpak" /etc/fstab; then
            echo "$DATA_DIR/system/flatpak  /var/lib/flatpak  none  bind  0  0" >> /etc/fstab
        fi
    fi
fi

# Pacman pkg cache (2.8 GB)
if [ -d "/var/cache/pacman/pkg" ]; then
    if ! mountpoint -q /var/cache/pacman/pkg; then
        cp -a /var/cache/pacman/pkg/. "$DATA_DIR/system/pacman_cache/" || true
        rm -rf /var/cache/pacman/pkg/*
        mount --bind "$DATA_DIR/system/pacman_cache" /var/cache/pacman/pkg
        if ! grep -q "$DATA_DIR/system/pacman_cache" /etc/fstab; then
            echo "$DATA_DIR/system/pacman_cache  /var/cache/pacman/pkg  none  bind  0  0" >> /etc/fstab
        fi
    fi
fi

echo "[*] 4. Bütün hüquqlar sir istifadəçisinə verilir..."
chown -R $USER_NAME:$USER_NAME "$DATA_DIR/Downloads" "$DATA_DIR/Pictures" "$DATA_DIR/Videos" "$DATA_DIR/Music" "$DATA_DIR/Projects" "$DATA_DIR/Games" "$DATA_DIR/Documents" "$DATA_DIR/Antigravity" "$DATA_DIR/user_var"
chown -h $USER_NAME:$USER_NAME "$USER_HOME/Downloads" "$USER_HOME/Pictures" "$USER_HOME/Videos" "$USER_HOME/Music" "$USER_HOME/Projects" "$USER_HOME/Antigravity" "$USER_HOME/.var"

echo "[*] 5. Spectacle screenshot sazlamaları yoxlanılır..."
mkdir -p "$DATA_DIR/Pictures/Screenshots"
chown -R $USER_NAME:$USER_NAME "$DATA_DIR/Pictures"

echo "[✓] UĞURLA TAMAMLANDI!"
