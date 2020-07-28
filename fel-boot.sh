#!/bin/sh
cd PCBA/output/images
sudo ~/sunxi-tools/sunxi-fel -v -p uboot u-boot-sunxi-with-spl.bin \
     multi 3 \
     0x41000000 zImage \
     0x41800000 sun8i-v3s-funkey.dtb \
     0x41900000 boot.scr
cd -
