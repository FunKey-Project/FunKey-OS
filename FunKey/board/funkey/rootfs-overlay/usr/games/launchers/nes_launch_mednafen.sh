#!/bin/sh
#echo $1

#mednafen -sound 1 -soundrate 22050 -soundbufsize 100 -vdriver sdl -nes.xscale 0.94 -nes.yscale 0.94 -nes.special none -fs 0 "$1"

mednafen -sound 1 -soundrate 22050 -soundbufsize 100 -vdriver sdl -nes.xscale 0.94 -nes.yscale 1.075 -nes.special none -fs 0 "$1"
