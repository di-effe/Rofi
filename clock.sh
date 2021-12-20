#!/usr/bin/env bash
################################################
# Original design by Aditya Shakya (@adi1090x) #
################################################

# SETTINGS ####################################################
# Possible positions:
# center
# north
# northeast
# east
# southeast
# south
# southwest
# west
# northwest
LOCATION="center"
###############################################################

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
rofi_cmd="rofi -theme $LPATH/rasi/clock.rasi"
display="$HOUR\n$MINUTES"

# Main
chosen="$(echo -e "$display" | \
$rofi_cmd -p "$DN, $DAY $MN" -dmenu \
-theme-str 'window {location: '$LOCATION';}' \
-selected-row 1\
)"