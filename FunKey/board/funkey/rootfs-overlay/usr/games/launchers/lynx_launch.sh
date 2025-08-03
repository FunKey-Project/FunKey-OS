#!/bin/sh

if [ ! -e /mnt/FunKey/.picoarch/system/lynxboot.img ]; then
	if [ ! -d /mnt/FunKey/.picoarch/system ]; then
		mkdir -p /mnt/FunKey/.picoarch/system
	fi
	cp /usr/games/lynxboot.img /mnt/FunKey/.picoarch/system
fi

# Launch the process in background, record the PID into a file, wait
# for the process to terminate and erase the recorded PID
if [ -e /mnt/Libretro/cores/mednafen_lynx_libretro.so ]; then
	picoarch /mnt/Libretro/cores/mednafen_lynx_libretro.so "$1"&
else
	picoarch /usr/games/mednafen_lynx_libretro.so "$1"&
fi
pid record $!
wait $!
pid erase
