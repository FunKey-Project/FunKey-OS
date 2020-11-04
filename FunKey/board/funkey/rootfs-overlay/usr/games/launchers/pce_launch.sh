#!/bin/sh

cd /tmp/funkey

# Security
cp /usr/games/mednafen-09x.cfg ${MEDNAFEN_HOME}/

mednafen -fs 1 -force_module pce_fast -pce_fast.stretch full "$1"
