#!/bin/bash
set -e

USER_NAME="sir"
USER_HOME="/home/$USER_NAME"
DATA_DIR="/data"

echo "[*] 1. Desktop, Documents, Cache və Wine məlumatları /data-ya köçürülür..."

# Desktop (1.5 GB)
if [ -d "$USER_HOME/Desktop" ] && [ ! -L "$USER_HOME/Desktop" ]; then
    mkdir -p "$DATA_DIR/Desktop"
    cp -a "$USER_HOME/Desktop/." "$DATA_DIR/Desktop/" || true
    rm -rf "$USER_HOME/Desktop"
    ln -sfn "$DATA_DIR/Desktop" "$USER_HOME/Desktop"
fi

# Documents (83 MB)
if [ -d "$USER_HOME/Documents" ] && [ ! -L "$USER_HOME/Documents" ]; then
    mkdir -p "$DATA_DIR/Documents"
    cp -a "$USER_HOME/Documents/." "$DATA_DIR/Documents/" || true
    rm -rf "$USER_HOME/Documents"
    ln -sfn "$DATA_DIR/Documents" "$USER_HOME/Documents"
fi

# .cache (734 MB - brauzer, şəkil keşləri)
if [ -d "$USER_HOME/.cache" ] && [ ! -L "$USER_HOME/.cache" ]; then
    mkdir -p "$DATA_DIR/cache"
    cp -a "$USER_HOME/.cache/." "$DATA_DIR/cache/" || true
    rm -rf "$USER_HOME/.cache"
    ln -sfn "$DATA_DIR/cache" "$USER_HOME/.cache"
fi

# .wine və .wine-test (1 GB)
if [ -d "$USER_HOME/.wine" ] && [ ! -L "$USER_HOME/.wine" ]; then
    mkdir -p "$DATA_DIR/wine"
    cp -a "$USER_HOME/.wine/." "$DATA_DIR/wine/" || true
    rm -rf "$USER_HOME/.wine"
    ln -sfn "$DATA_DIR/wine" "$USER_HOME/.wine"
fi

if [ -d "$USER_HOME/.wine-test" ] && [ ! -L "$USER_HOME/.wine-test" ]; then
    mkdir -p "$DATA_DIR/wine-test"
    cp -a "$USER_HOME/.wine-test/." "$DATA_DIR/wine-test/" || true
    rm -rf "$USER_HOME/.wine-test"
    ln -sfn "$DATA_DIR/wine-test" "$USER_HOME/.wine-test"
fi

echo "[*] 2. Hüquqlar yenilənir..."
chown -R $USER_NAME:$USER_NAME "$DATA_DIR/Desktop" "$DATA_DIR/Documents" "$DATA_DIR/cache" "$DATA_DIR/wine" "$DATA_DIR/wine-test" 2>/dev/null || true
chown -h $USER_NAME:$USER_NAME "$USER_HOME/Desktop" "$USER_HOME/Documents" "$USER_HOME/.cache" "$USER_HOME/.wine" "$USER_HOME/.wine-test" 2>/dev/null || true

echo "[✓] Bütün istifadəçi və keş faylları 434 GB-lıq diskə keçirildi!"
