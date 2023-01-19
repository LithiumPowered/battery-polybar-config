#!/usr/bin/env bash

NOT_TIMER=5000 # in miliseconds
NOT_ID=$(pidof polybar)

for (( i=0; i< 3; ++i ));do
DOTS+="."
dunstify -r $NOT_ID -t $NOT_TIMER \
  "${USER^^} Network - Status" \
  "$DOTS"
 sleep 0.3
done

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
  "$PUB_IP $LOC_COUNTRY, $LOC_CITY"
