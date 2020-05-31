#!/bin/sh
#echo $1
#mednafen -sound 1 -soundrate 22050 -soundbufsize 100 -vdriver sdl -gb.xscale 1.5 -gb.yscale 1.5 -fs 0 "$1"
#mednafen -sound 1 -soundrate 22050 -soundbufsize 100 -vdriver sdl -gb.xscale 1.5 -gb.yscale 1.67 -fs 0 "$1"

#mednafen -sounddriver sdl -sound 1 -soundrate 22050 -soundbufsize 100 -vdriver sdl -gb.xres 240 -gb.yres 240 -gb.yscale 1 -gb.xscale 1 -gb.stretch full -fs 1 "$1"
sdlgnuboy --syncrtc "$1"
