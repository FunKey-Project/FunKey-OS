#!/bin/sh

cd /tmp/funkey

# Security
cp /usr/games/mednafen-09x.cfg ${MEDNAFEN_HOME}/

mednafen -fs 1 -wswan.stretch full "$1"
