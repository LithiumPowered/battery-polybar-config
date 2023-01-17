#!/usr/bin/env bash

SCRIPT="$0"

printf "running $SCRIPT...\n"

EXISTING=$( pgrep -f "bash $0" | wc -l )

if [ $EXISTING -gt 2 ]; then
  printf "ipc-split is already running!\n"
  exit 1

else 
  while :; do
    WIN_D="$(xdotool getwindowfocus getwindowgeometry | rg -o "Geometry:.*$" | choose -f : 1 | xargs -0)"
    WIN_X="$(choose -f x 0 <<< $WIN_D)"
    WIN_Y="$(choose -f x 1 <<< $WIN_D)"

    # Change split symbol depending on window dimensions
    [[ $WIN_X -gt $WIN_Y ]] && {
      polybar-msg action "#split.hook.0" >/dev/null 2>&1
    } || {
      polybar-msg action "#split.hook.1" >/dev/null 2>&1
    }
    sleep 0.1
  done 
fi

