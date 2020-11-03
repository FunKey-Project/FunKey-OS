#!/bin/sh

cd /tmp/funkey
mednafen -sound 1 -soundrate 22050 -soundbufsize 100 -vdriver sdl -frameskip 1  -fs 0 "$1"
