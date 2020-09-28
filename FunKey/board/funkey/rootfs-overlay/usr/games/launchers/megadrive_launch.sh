#!/bin/sh
#echo $1

#mednafen -sound 1 -soundrate 22050 -soundbufsize 100 -vdriver sdl -frameskip 1 -force_module md -md.xscale 0.822 -md.yscale 0.822 -fs 0 "$1"

PicoDrive "$1"
