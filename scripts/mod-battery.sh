#!/usr/bin/env bash

NOT_TIMER=5000 # in miliseconds
NOT_ID=12

UP="$(uptime -p)"
dunstify -r $NOT_ID -t $NOT_TIMER \
  "${USER^^} System - Status" \
  "${UP/up/Uptime:}\n\n$(acpi)"
