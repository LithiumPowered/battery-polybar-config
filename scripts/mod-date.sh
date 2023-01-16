#!/usr/bin/env bash

NOT_TIMER=10000 # in miliseconds
NOT_ID=$(pidof polybar)

# Display notification without weather
NO_TITLE="$(date '+(%a) %b %d, %Y')"
dunstify -r $NOT_ID -t $NOT_TIMER \
  "$NO_TITLE" \
  "$NO_BODY" 

# Get Current Location
if CITY="$(timeout 1 curl -s "https://ipinfo.io/city")"; then

  # Add weather to current if it runs successfully
  if WEATHER="$( timeout 1 curl -s "wttr.in/${CITY/ /+}?T" | head -n7 )"; then
    NO_BODY="$WEATHER"

  # Append notification if curl is successful
  dunstify -r $NOT_ID -t $NOT_TIMER \
    "$NO_TITLE" \
    "\n${NO_BODY/\\/ }" 
  fi

fi
