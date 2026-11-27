#!/bin/bash
# ==============================================================================
# Script: Windows (434 GB) bölməsini silib tam Arch Linux yaddaşına çevirmək
# ==============================================================================
set -e

if [ "$EUID" -ne 0 ]; then
    echo "[!] Zəhmət olmasa bu skripti sudo ilə işə salın: sudo ./setup_storage.sh"
    exit 1
fi

TARGET_PART="/dev/nvme0n1p2"
MOUNT_POINT="/data"
USER_NAME="sir"

echo "[*] 1. Windows bölməsi unmount edilir..."
umount $TARGET_PART 2>/dev/null || true

echo "[*] 2. $TARGET_PART format edilir (ext4 - Linux fayl sistemi)..."
mkfs.ext4 -F -L "Storage" $TARGET_PART

echo "[*] 3. Yeni qovluq yaradılır: $MOUNT_POINT"
mkdir -p $MOUNT_POINT

echo "[*] 4. /etc/fstab faylına daimi qoşulma əlavə edilir..."
PART_UUID=$(blkid -s UUID -o value $TARGET_PART)
# Əvvəlki qeyd varsa təmizləyirik
sed -i "\|/dev/nvme0n1p2\|d" /etc/fstab
sed -i "\|$MOUNT_POINT\|d" /etc/fstab
echo "UUID=$PART_UUID  $MOUNT_POINT  ext4  defaults,noatime  0  2" >> /etc/fstab

echo "[*] 5. Bölmə mount edilir..."
mount $MOUNT_POINT

echo "[*] 6. İstifadəçi hüquqları ($USER_NAME) təyin edilir..."
chown -R $USER_NAME:$USER_NAME $MOUNT_POINT
chmod 775 $MOUNT_POINT

# Dolphin / İstifadəçi üçün rahat qısayol (Symlink)
USER_HOME="/home/$USER_NAME"
if [ -d "$USER_HOME" ]; then
    ln -sfn $MOUNT_POINT "$USER_HOME/Storage_434GB"
    chown -h $USER_NAME:$USER_NAME "$USER_HOME/Storage_434GB"
fi

echo ""
echo "=================================================================="
echo "[✓] UĞURLA TAMAMLANDI!"
echo "Windows tamamilə silindi və 434 GB təmiz Linux yaddaşı kimi qoşuldu."
echo "Qovluq yolu: $MOUNT_POINT (və ev qovluğunuzda: ~/Storage_434GB)"
echo "Dolphin fayl menecerində dərhal görünəcək və tam istifadəyə hazırdır."
echo "=================================================================="
