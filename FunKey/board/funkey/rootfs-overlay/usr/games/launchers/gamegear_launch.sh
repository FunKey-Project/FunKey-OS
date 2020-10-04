#!/bin/sh
#echo $1

cp /usr/games/mednafen-09x.cfg /root/.mednafen/
mednafen -fs 1 -gg.stretch full "$1"
