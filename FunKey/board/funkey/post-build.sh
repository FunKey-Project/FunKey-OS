#!/bin/sh

# Swap
sed -i '/^\/swap/d' "${TARGET_DIR}/etc/fstab"
echo "/swap		none		swap	defaults	0	0" >> "${TARGET_DIR}/etc/fstab"
