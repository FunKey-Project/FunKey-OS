# FunKey

Intro
=====

This directory contains a buildroot external configuration for
building the FunKey.

How to build it
===============

Configure Buildroot
-------------------

There is only one Funkey defconfig files in Buildroot:

  $ make BR2_EXTERNAL=<Funkey directory> O=<Funkey directory>/output
  funkey_defconfig

Build the rootfs
----------------

Note: you will need to have access to the network, since Buildroot
will download the packages' sources.

You may now build your rootfs with:

  $ make BR2_EXTERNAL=<Funkey directory> O=<Funkey directory>/output

(This may take a while, consider getting yourself a coffee ;-) )

Result of the build
-------------------

After building, you should obtain this tree:

    output/images/
    +-- boot.scr
    +-- boot.vfat
    +-- rootfs.ext2
    +-- rootfs.ext4 -> rootfs.ext2
    +-- sdcard.img
    +-- sun8i-v3s-licheepi-zero-dock.dtb
    +-- sun8i-v3s-licheepi-zero.dtb
    +-- u-boot.bin
    +-- u-boot-sunxi-with-spl.bin
    `-- zImage

How to write the SD card
========================

Once the build process is finished you will have an image called
"sdcard.img" in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=<Funkey directory>/output/images/sdcard.img of=/dev/sdX

Insert the SDcard into your Funkey board, and power it up. Your new
system should come up now and start two consoles: one on the serial
port on the P1 header, one on the LCD output where you can login using
a USB keyboard.
