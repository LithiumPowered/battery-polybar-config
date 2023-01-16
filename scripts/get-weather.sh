#!/usr/bin/env bash

CITY_LIST=( "Manteca" "Livermore" ) 

printf "\n"
for CITY in ${CITY_LIST[@]}; do
  LOCAL_WEATHER="$(curl -s "wttr.in/${CITY/ /+}"?format=%C+\(%x\),+%p,+%t)"
  printf "${CITY/+/ }, $LOCAL_WEATHER\n"
  sleep 0.5
done 
