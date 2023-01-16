#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Launch main bar
polybar statusline 2>&1 | tee -a /tmp/polymain.log & disown
printf "Main bar launched...\n"
