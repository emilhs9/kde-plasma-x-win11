#!/bin/bash
# ==============================================================================
# Arch Linux KDE Plasma 6 - Windows 11 Start Menyu və Görünüş Quraşdırıcısı
# ==============================================================================

set -e

echo "=========================================================="
echo "  Arch Linux & KDE Plasma 6: Windows 11 Quraşdırma Köməkçisi"
echo "=========================================================="

# AUR köməkçisi yoxlanışı
if command -v yay &> /dev/null; then
    AUR_HELPER="yay"
elif command -v paru &> /dev/null; then
    AUR_HELPER="paru"
else
    echo "[-] AUR köməkçisi (yay və ya paru) tapılmadı!"
    exit 1
fi

echo "[+] Aşkar edilən AUR köməkçisi: $AUR_HELPER"

echo ""
echo "Seçimlər:"
echo "1) Win 11 İkon paketini quraşdır (win11-icon-theme)"
echo "2) Fluent / Windows 11 Kvantum və KWin Temalarını quraşdır"
echo "3) Hamısını birdən quraşdır (İkonlar, Kursor, Temalar)"
echo "4) Çıxış"
echo ""

read -p "Seçiminizi daxil edin [1-4]: " choice

case $choice in
    1)
        echo "[*] Windows 11 İkonları yüklənir..."
        $AUR_HELPER -S --needed win11-icon-theme
        ;;
    2)
        echo "[*] Fluent / Win 11 temaları yüklənir..."
        $AUR_HELPER -S --needed fluent-kde-theme-git fluent-cursor-theme
        ;;
    3)
        echo "[*] Bütün zəruri Windows 11 elementləri yüklənir..."
        $AUR_HELPER -S --needed win11-icon-theme fluent-kde-theme-git fluent-cursor-theme kvantum
        ;;
    *)
        echo "Ləğv edildi."
        exit 0
        ;;
esac

echo ""
echo "[✓] Quraşdırma tamamlandı!"
echo "[i] KDE Ayarlarından (System Settings -> Colors & Themes) mövzunu aktiv edin."
