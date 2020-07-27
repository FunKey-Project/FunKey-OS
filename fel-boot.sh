#!/bin/sh
cd PCBA/output/images
sudo ~/sunxi-tools/sunxi-fel -v -p uboot u-boot-sunxi-with-spl.bin \
     write 0x41000000 uImage \
     write 0x41800000 sun8i-v3s-funkey.dtb \
     write 0x41900000 boot.scr \
     write 0x41B00000 rootfs.cpio.uboot
cd -
