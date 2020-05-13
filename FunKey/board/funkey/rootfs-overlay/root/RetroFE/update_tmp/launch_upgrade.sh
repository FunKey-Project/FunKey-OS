#!/bin/bash

echo "Launching upgrade 0.01 to 0.02"
notif_set 0 "^^^^^^^    UPGRADE IN PROGRESS... ^        v0.01->v0.2^^DO NOT TURN OFF THE CONSOLE! ^^^^^^"

sleep 5

notif_clear

exit 0