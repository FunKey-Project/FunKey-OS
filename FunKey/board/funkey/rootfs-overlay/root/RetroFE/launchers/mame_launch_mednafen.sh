#!/bin/sh
#echo $1

#mednafen -sound 1 -soundrate 22050 -soundbufsize 100 -vdriver sdl -frameskip 1 -force_module snes_faust -snes_faust.xscale 0.823 -snes_faust.yscale 0.823 -fs 0 "$1"

mednafen -sound 1 -soundrate 22050 -soundbufsize 100 -vdriver sdl -frameskip 1  -fs 0 "$1"
