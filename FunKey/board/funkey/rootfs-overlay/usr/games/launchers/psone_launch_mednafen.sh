#!/bin/sh

mkdir -p ${HOME}
cd ${HOME}

# Launch the process in background, record the PID into a file, wait
# for the process to terminate and erase the recorded PID
pcsx -frameskip -cdfile "$1"&
record_pid $!
wait $!
erase_pid
