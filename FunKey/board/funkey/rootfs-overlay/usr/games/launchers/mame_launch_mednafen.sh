#!/bin/sh

# Security
cp /usr/games/mednafen-09x.cfg ${MEDNAFEN_HOME}/
export HOME=/tmp/funkey
mkdir -p ${HOME}
cd ${HOME}
mednafen -sound 1 -soundrate 22050 -soundbufsize 100 -vdriver sdl -frameskip 1  -fs 0 "$1"
