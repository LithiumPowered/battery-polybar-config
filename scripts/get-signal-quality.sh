#!/usr/bin/env bash

LINK_0="$(iwconfig wlan0 | awk -F'=' '/Link Quality/ {print $2}' | choose 0)"
LINK_1="$(echo $LINK_0 | choose -f / 0)"
LINK_2="$(echo $LINK_0 | choose -f / 1)"

LINK_Q="$(bc <<< "scale=2;$LINK_1/$LINK_2" | tr -d .)%"
echo $LINK_Q
