#!/bin/sh

# Security
cp /usr/games/mednafen-09x.cfg ${MEDNAFEN_HOME}/
export HOME=/tmp/funkey
mkdir -p ${HOME}
cd ${HOME}
mednafen -fs 1 -force_module pce_fast -pce_fast.stretch full "$1"
