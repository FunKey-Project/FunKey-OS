#!/bin/sh

export HOME=/tmp/funkey
mkdir -p ${HOME}
cd ${HOME}
psnes "$1"
