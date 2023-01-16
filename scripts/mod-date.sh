#!/usr/bin/env bash

NOT_TIMER=5000 # in miliseconds
NOT_ID=12

CITY_LIST=( 
  "Livermore" 
)

# Display notification without weather
NO_TITLE="$(date '+(%a) %b %d, %Y')"
dunstify -r $NOT_ID -t $NOT_TIMER \
  "$NO_TITLE" \
  "$NO_BODY" 

# Add weather to current if it runs successfully
for CITY in ${CITY_LIST[@]}; do
  if WEATHER="$( timeout 1 curl -s "wttr.in/${CITY/ /+}?T" | head -n7 )"; then
    NO_BODY+="${WEATHER/\\/ }"

  # Append notification if curl is successful
  dunstify -r $NOT_ID -t $NOT_TIMER \
    "$NO_TITLE" \
    "\n$NO_BODY" 
  fi
done
