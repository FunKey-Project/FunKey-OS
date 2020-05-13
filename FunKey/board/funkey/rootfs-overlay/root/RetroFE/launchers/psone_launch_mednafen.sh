#!/bin/sh
#echo $1

#mednafen -sound 1 -soundrate 22050 -soundbufsize 100 -vdriver sdl -psx.xscale 0.625 -psx.yscale 0.625 -fs 0 "$1"

#mednafen -sound 1 -soundrate 22050 -soundbufsize 100 -vdriver sdl -psx.xscale 0.625 -psx.yscale 0.834 -fs 0 "$1"

pcsx -frameskip -cdfile "$1"
