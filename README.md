# FunKey

Intro
=====

This directory contains a buildroot-based external configuration for
building the FunKey.

How to get it
===============

Clone the FunKey OS repository from Github:

  $ git clone https://github.com/FunKey-Project/FunKey-OS.git <Funkey directory>

Then enter into the created directory:

  $ cd <Funkey directory>

How to build it
===============

Build the disk image & firmware update files
--------------------------------------------

Note: you will need to have access to the network, since buildroot
will download the packages' sources.

You may now build your FunKey with:

  $ make

(This may take a while, consider getting yourself a coffee ;-) )

Result of the build
-------------------

After building, you should obtain this tree:

    images/
    +-- FunKey-rootfs-X.Y.fwu
    `-- sdcard.img

How to write the SD card
========================

Once the build process is finished you will have an image called
"sdcard.img" in the images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=<Funkey directory>/images/sdcard.img of=/dev/sdX

Alternatively, you can use the Etcher graphical tool to burn the image
to the SD card safely and on any platform:

https://etcher.io/

Once the SD card is burned, insert it into your FunKey board, and
power it up. Your new system should come up now and start a console on
the UART0 serial port.
