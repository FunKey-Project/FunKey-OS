#!/bin/sh

export HOME=/tmp/funkey
mkdir -p ${HOME}
cd ${HOME}
sdlgnuboy --syncrtc "$1"
