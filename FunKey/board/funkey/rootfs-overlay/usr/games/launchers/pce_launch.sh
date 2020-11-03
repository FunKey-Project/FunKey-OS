#!/bin/sh

cd /tmp/funkey
mednafen -fs 1 -force_module pce_fast -pce_fast.stretch full "$1"
