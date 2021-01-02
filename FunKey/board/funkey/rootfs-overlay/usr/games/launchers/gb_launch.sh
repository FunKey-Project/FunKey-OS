#!/bin/sh

# Launch the process in background, record the PID into a file, wait
# for the process to terminate and erase the recorded PID
sdlgnuboy --syncrtc "$1"&
record_pid $!
wait $!
erase_pid
