#!/bin/sh

# Launch the process in background, record the PID into a file, wait
# for the process to terminate and erase the recorded PID
if [ -e /mnt/Libretro/cores/mednafen_wswan_libretro.so ]; then
	picoarch /mnt/Libretro/cores/mednafen_wswan_libretro.so "$1"&
else
	picoarch /usr/games/mednafen_wswan_libretro.so "$1"&
fi
pid record $!
wait $!
pid erase
