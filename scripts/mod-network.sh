#!/usr/bin/env bash

NOT_TIMER=5000 # in miliseconds
NOT_ID=$(pidof polybar)

# Get essid 
ESSID="<i>$(iwconfig wlan0 | rg -o 'ESSID.*$' | choose -f : 1)</i>"

# Get signal level
RSSI_CUR="$(iwconfig wlan0 | rg -o 'Signal.*=[-0-9]+' | choose -f = 1) dBm"

# Get signal quality
LINK_0="$(iwconfig wlan0 | awk -F'=' '/Link Quality/ {print $2}' | choose 0)"
LINK_1="$(choose -f / 0 <<< $LINK_0)"
LINK_2="$(choose -f / 1 <<< $LINK_0)"

LINK_Q="$(bc <<< "scale=2;$LINK_1/$LINK_2" | tr -d .)%"

dunstify -r $NOT_ID -t $NOT_TIMER \
  "${USER^^} Network - Status" \
  "$ESSID ($RSSI_CUR, $LINK_Q)"

# Get ipinfo - exit early on failure
if ! RES=$(curl -s 'https://ipinfo.io/json'); then
  exit 0 
fi

# jq the pertinent info
PUB_IP="$(jq -r '.ip' <<< $RES| xargs -0)"
LOC_COUNTRY="$(jq -r '.country' <<< $RES | xargs -0)"
LOC_CITY="$(jq -r '.city' <<< $RES | xargs -0)"

# output to console
dunstify -r $NOT_ID -t $NOT_TIMER \
  "${USER^^} Network - Status" \
  "$ESSID ($RSSI_CUR, $LINK_Q)\n\n$PUB_IP $LOC_COUNTRY, $LOC_CITY"
