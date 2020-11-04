#!/bin/sh

export HOME=/tmp/funkey
mkdir -p ${HOME}
cd ${HOME}
mednafen -fs 1 -wswan.stretch full "$1"
