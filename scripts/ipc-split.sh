#!/usr/bin/env bash

WIN_D="$(xdotool getwindowfocus getwindowgeometry | rg -o "Geometry:.*$" | choose -f : 1 | xargs -0)"
WIN_X="$(choose -f x 0 <<< $WIN_D)"
WIN_Y="$(choose -f x 1 <<< $WIN_D)"

# Change split symbol depending on window dimensions
[[ $WIN_X -gt $WIN_Y ]] && {
  i3-msg split horizontal >/dev/null 2>&1
  printf "|"
} || {
  i3-msg split vertical >/dev/null 2>&1
  printf "-"
}
