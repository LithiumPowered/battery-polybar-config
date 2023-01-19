#!/usr/bin/env bash
WINDOW_PROP="$(xdotool getwindowfocus getwindowgeometry)"
WINDOW_NAME="$(xdotool getwindowfocus getwindowname)"

# Window Position
WIN_P="$(rg -o "Position:.*$" <<< $WINDOW_PROP | choose 1 | xargs -0)"
WIN_POS_X="$(choose -f , 0 <<< $WIN_P)"

# Change Label based on x location
INDICATOR=" " 
[[ $WIN_POS_X -lt 20 ]] && INDICATOR="=" 
[[ $WIN_POS_X -gt 20 ]] && INDICATOR="-"

# If no window focused then blank indicator
[[ "$WINDOW_NAME" == "i3" ]] && INDICATOR=" "

printf "$INDICATOR"
