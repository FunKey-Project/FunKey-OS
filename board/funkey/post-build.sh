#!/bin/sh
BOARD_DIR="$( dirname "${0}" )"
MKIMAGE="${HOST_DIR}/bin/mkimage"
MKSWAP="${HOST_DIR}/sbin/mkswap"
BOOT_CMD="${BOARD_DIR}/boot.cmd"
BOOT_CMD_H="${BINARIES_DIR}/boot.scr"

# U-Boot script
"${MKIMAGE}" -C none -A arm -T script -d "${BOOT_CMD}" "${BOOT_CMD_H}"

# Swap
sed -i '/^\/swap/d' "${TARGET_DIR}/etc/fstab"
echo "/swap		none		swap	defaults	0	0" >> "${TARGET_DIR}/etc/fstab"
