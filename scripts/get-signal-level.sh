#!/usr/bin/env bash

RSSI_CUR="$(iwconfig wlan0 | rg -o 'Signal.*=[-0-9]+' | choose -f = 1)"
RSSI_MIN=-100
RSSI_MAX=-50

printf "%s dBm\n" $RSSI_CUR
