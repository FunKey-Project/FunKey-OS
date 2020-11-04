#!/bin/sh

export HOME=/tmp/funkey
mkdir -p ${HOME}
cd ${HOME}
fceux "$1"

