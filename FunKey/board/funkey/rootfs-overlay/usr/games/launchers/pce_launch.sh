#!/bin/sh

export HOME=/tmp/funkey
mkdir -p ${HOME}
cd ${HOME}
mednafen -fs 1 -force_module pce_fast -pce_fast.stretch full "$1"
