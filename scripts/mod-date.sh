#!/usr/bin/env bash

NOT_TIMER=5000 # in miliseconds
NOT_ID=12

CITY_LIST=( 
  "Manteca" 
  "Livermore" 
)

# Display notification without weather
NO_TITLE="$(date '+%a, %b %d')"
dunstify -r $NOT_ID -t $NOT_TIMER \
  "$NO_TITLE" \
  "$NO_BODY" 

# Add weather to current if it runs successfully
for CITY in ${CITY_LIST[@]}; do
  if WEATHER="$(timeout 1 curl -s "wttr.in/${CITY/ /+}"?format=%C+\(%x\),+%p,+%t)"; then
    NO_BODY+="<i>$CITY</i>, $WEATHER\n"
  fi
done && {
  # TODO: Lol, this looks fucking ugly
  # Display notification with appended weather info
  dunstify -r $NOT_ID -t $NOT_TIMER \
    "$NO_TITLE" \
    "\n$NO_BODY" 
}

