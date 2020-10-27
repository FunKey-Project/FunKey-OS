#!/bin/sh
#echo $1

cp /usr/games/mednafen-09x.cfg /root/.mednafen/
mednafen -fs 1 -force_module pce_fast -pce_fast.stretch full "$1"
