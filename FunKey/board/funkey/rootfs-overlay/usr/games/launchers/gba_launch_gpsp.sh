#!/bin/sh

# Launch the process in background, record the PID into a file, wait
# for the process to terminate and erase the recorded PID
# Do not use asound.conf to avoid saturated sound
rw
mv -f /etc/asound.conf /etc/asound.conf.BAK
if [ -e /mnt/Libretro/cores/gpsp_libretro.so ]; then
	picoarch /mnt/Libretro/cores/gpsp_libretro.so "$1"&
else
	picoarch /usr/games/gpsp_libretro.so "$1"&
fi
pid record $!
wait $!
pid erase
mv -f /etc/asound.conf.BAK /etc/asound.conf
ro
