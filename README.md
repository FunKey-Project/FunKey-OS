
# FunKey-OS

## Intro
This repository contains all the sources required to build FunKey-OS, the Open-Source firmware at the heart of the [FunKey S retro-gaming console](https://www.funkey-project.com/).

As the FunKey-S console is based on a sophisticated [Allwinner V3s ARM Cortex-A7 1.2GHz CPU](http://www.allwinnertech.com/index.php?c=product&a=index&id=38), an Operating System is mandatory in order to access all the hardware resources without re-inventing the wheel.

FunKey-OS is based on Linux, and is built from scratch using the [buildroot](http://nightly.buildroot.org/) tool that simplifies and automates the process of building a complete Linux system for an embedded system like this.

Technically, Funkey-OS is a [buildroot (v2) based external tree](https://buildroot.org/downloads/manual/manual.html#outside-br-custom) for building the bootloader, the Linux kernel and user utilities, as well as the optimized retro-game launcher and console emulators.

## Build host requirements
Even if the resulting disk image and firmware update files are relatively small (202 MB and 55MB, respectively), the size of the corresponding sources and the compilation by-products tend to be rather large, such that an available disk space of at least 12GB is required during the build.

And even if the resulting FunKey-OS boots in less than 5s, it still requires a considerable amount of time to compile: please account for 1 1/2 hour on a modern multi-core CPU with SSD drives and a decent Internet bandwidth.

As the target CPU is probably different from the one running on your build host machine, a process known as [_cross-compilation_](https://en.wikipedia.org/wiki/Cross_compiler) is required for the build, and as the target system will eventually be Linux, this is much better handled on hosts running a Linux-based operating system too.

As a matter of fact, the FunKey-OS is meant to be built on a native Ubuntu or Debian Linux host machine (Ubuntu 20.04 LTS in our case, but this should also work with other versions, too). And with only a few changes to the prerequisites, it can certainly be adapted to build on other common Linux distros.

However, if your development machine does not match this setup, there are still several available solutions:
 -  use a lightweight container system such as [Docker](https://www.docker.com/) and run an Ubuntu or Debian Linux container in it
 - use a VM (Virtual Machine) , such as provided by [VirtualBox](https://www.virtualbox.org/) and run an Ubuntu or Debian Linux in it
 - for Windows 10 users, use the [WSL2](https://docs.microsoft.com/en-us/windows/wsl/install-win10) (Windows System for Linux 2) subsystem and run an Ubuntu Linux distro in it

In order to install one of these virtualized environments on your machine, please refer to the corresponding documentation.

## Build on a Physical/Virtual Machine

### Prerequisites
While Buildroot itself will build most host packages it needs for the compilation, some standard Linux utilities are expected to be already installed on the host system. If not already present, you will need to install the following packages beforehand:
 - bash
 - bc
 - binutils
 - build-essential
 - bzip2
 - ca-certificates
 - cpio
 - cvs
 - expect
 - file
 - g++
 - gcc
 - git
 - gzip
 - liblscp-dev
 - libncurses5-dev
 - locales
 - make
 - mercurial
 - openssh-client
 - patch
 - perl
 - procps
 - python
 - python-dev
 - python3
 - python3-dev
 - python3-distutils
 - python3-setuptools
 - rsync
 - rsync
 - sed
 - subversion
 - sudo
 - tar
 - unzip
 - wget
 - which
 - xxd

On Ubuntu/Debian Linux, this is achieved by running the following command:
```bash
$ sudo apt install bash bc binutils build-essential bzip2 ca-certificates cpio cvs expect file g++ gcc git gzip liblscp-dev libncurses5-dev locales make mercurial openssh-client patch perl procps python python-dev python3 python3-dev python3-distutils python3-setuptools rsync rsync sed subversion sudo tar unzip wget which xxd
```

### How to get the sources
When using either physical or virtual Linux machines, you must clone the FunKey OS repository from Github:

```bash
$ git clone https://github.com/FunKey-Project/FunKey-OS.git <FunKey directory>
```

Then enter into the created directory:

```bash
$ cd <FunKey directory>
```

### Build the disk image & firmware update files
You may now build your FunKey with:

```bash
$ make
```
This may take a while, consider getting yourself a cup or glass of your favorite beverage ;-)

<ins>Note</ins>: you will need to have access to the network, since buildroot will download the package sources.

### Result of the build
After building, you should obtain the SD Card image `sdcard.img` and the firmware update file `FunKey-rootfs-X.Y.fwu` in the `image` directory.

## Build in a container

### Prerequisites
When using a Docker container, all the prerequisites are automatically installed.

### How to get the sources
When using a Docker container, you must first get the FunKey-OS [Dockerfile](https://raw.githubusercontent.com/Michel-FK/FunKey-Project/master/docker/Dockerfile) and Debian [apt-sources.list](https://raw.githubusercontent.com/Michel-FK/FunKey-Project/master/docker/apt-sources.list) and put them into a separate directory:

```bash
$ mkdir <FunKey directory>
$ cd <FunKey directory>
$ wget https://raw.githubusercontent.com/FunKey-Project/FunKey-OS/master/docker/Dockerfile
$ wget https://raw.githubusercontent.com/FunKey-Project/FunKey-OS/master/docker/apt-sources.list
```
You must then build the docker image (don't forget the final dot!):
```bash
$ docker build -t funkey-project/funkey-os .
```

You are now ready to run interactively a new container based on this docker image:
```bash
$ docker run -d -it --name funkey-os funkey-project/funkey-os
```
You can then clone the FunKey OS repository from Github in this brand new container:

```bash
$ git clone https://github.com/FunKey-Project/FunKey-OS.git <FunKey directory>
```
Then enter into the created directory:

```bash
$ cd <FunKey directory>
```

### Build the disk image & firmware update files
You may now build your FunKey with:

```bash
$ make
```
This may take a while, consider getting yourself a cup or glass of your favorite beverage ;-)

<ins>Note</ins>: you will need to have access to the network, since buildroot will download the package sources.

### Result of the build
After building, you can exit the container by typing Ctrl+D.

You can copy the SD Card image `sdcard.img` and the firmware update file `FunKey-rootfs-X.Y.fwu` from the container into the host current directory:
```bash
$ docker cp funkey-os:/home/funkey/<FunKey directory>/images/sdcard.img ./
$ docker cp funkey-os:/home/funkey/<FunKey directory>/images/FunKey-rootfs-X.Y.fwu ./
```

## How to write to the SD card
You can copy the bootable "sdcard.img" onto an SD card using "dd":

```bash
$ sudo dd if=sdcard.img of=/dev/sdX
```
<ins>Warning</ins>: Please make sure that */dev/sdX* device corresponds to your SD Card, otherwise you may wipe out one of your hard drive partitions!

Alternatively, you can use the Balena-Etcher graphical tool to burn the image
to the SD card safely and on any platform:

https://www.balena.io/etcher/

Once the SD card is burnt, insert it into your FunKey S console slot, and
power it up. Your new system should come up now and start a console on
the UART0 serial port and display the retro game launcher on the graphical screen.
