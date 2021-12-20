#!/usr/bin/env bash
################################################
# Original design by Aditya Shakya (@adi1090x) #
################################################

LPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# Split date and time into single items
HOUR="$(date +"%H")"
MINUTES="$(date +"%M%p")"
SECONDS="$(date +"%S%p")"
DN=$(date +"%A")
MN=$(date +"%B")
DAY="$(date +"%d")"
MONTH="$(date +"%m")"
YEAR="$(date +"%Y")"

# Rofi config
start_rofi="rofi -theme $LPATH/rasi/clock.rasi"
display="$HOUR\n$MINUTES"

## Main
chosen="$(echo -e "$display" | $start_rofi -p "$DN, $DAY $MN" -dmenu -selected-row 1)"
