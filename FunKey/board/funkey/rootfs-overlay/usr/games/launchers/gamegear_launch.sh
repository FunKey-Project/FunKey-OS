#!/bin/sh

cp /usr/games/mednafen-09x.cfg ${MEDNAFEN_HOME}/
export HOME=/tmp/funkey
mkdir -p ${HOME}
cd ${HOME}

# Launch the process in background, record the PID into a file, wait
# for the process to terminate and erase the recorded PID
mednafen -fs 1 -gg.stretch full "$1"&
record_pid $!
wait $!
erase_pid
