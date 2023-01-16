#!/usr/bin/env bash

ESSID="$(iwconfig wlan0 | rg -o 'ESSID.*$' | choose -f : 1)"
printf "$ESSID\n"
