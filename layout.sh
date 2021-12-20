#!/usr/bin/env bash
LPATH="$( cd "$(dirname "$0")" ; pwd -P )"

WSACTIVE="$(leftwm-state -q -t $LPATH/misc/workspaceid.liquid)"

# Items to display
LAYOUT="$(leftwm-state -q -n -w $WSACTIVE -s "{{workspace.layout}}")"
PREV=""
NEXT=""

# Rofi config
start_rofi="rofi -theme $LPATH/layout.rasi"
display="$PREV\n$NEXT"

## Main
chosen="$(echo -e "$display" | $start_rofi -p "$LAYOUT" -dmenu -selected-row 1)"
case $chosen in
    $PREV)
        leftwm-command "PreviousLayout"
        ${0}
        ;;
    $NEXT)
        leftwm-command "NextLayout"
        ${0}
        ;;        
esac