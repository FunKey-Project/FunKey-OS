#!/bin/sh

export HOME=/tmp/funkey
mkdir -p ${HOME}
cd ${HOME}
pcsx -frameskip -cdfile "$1"
