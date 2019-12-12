# FunKey

Intro
=====

This directory contains a buildroot-based external configuration for
building the FunKey.

How to get it
===============

Clone the FunKey OS repository and the required submodules from
BitBucket:

  $ git clone --recurse-submodules git@bitbucket.org:keymu2/funkey-os.git <Funkey directory>

Then enter into the created directory:

  $ cd <Funkey directory>

How to build it
===============

Configure Buildroot
-------------------

There is only one Funkey defconfig files in Buildroot:

  $ ./fun funkey_defconfig

Build the rootfs
----------------

Note: you will need to have access to the network, since Buildroot
will download the packages' sources.

You may now build your FunKey with:

  $ ./have fun

(This may take a while, consider getting yourself a coffee ;-) )

Result of the build
-------------------

After building, you should obtain this tree:

    FunKey/output/images/
    +-- boot.scr
    +-- boot.vfat
    +-- rootfs.ext2
    +-- rootfs.ext4 -> rootfs.ext2
    +-- sdcard.img
    +-- sun8i-v3s-funkey.dtb
    +-- u-boot.bin
    +-- u-boot-sunxi-with-spl.bin
    `-- zImage

How to write the SD card
========================

Once the build process is finished you will have an image called
"sdcard.img" in the FunKey/output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=<Funkey directory>/FunKey/output/images/sdcard.img of=/dev/sdX

Alternatively, you can use the Etcher graphical tool to burn the image
to the SD card safely and on any platform:

https://etcher.io/

Once the SD card is burned, insert it into your FunKey board, and
power it up. Your new system should come up now and start a console on
the UART0 serial port.
