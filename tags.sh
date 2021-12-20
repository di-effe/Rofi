#!/usr/bin/env bash

# SETTINGS ####################################################
# Will be used to mark visible and busy tags
ISBUSY="·"
# Size for each tag button/link
WIDTH="90"
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
WSACTIVE="$(leftwm-state -q -t $LPATH/misc/workspaceid.liquid)"

# Items to display
# Tag status legend
# m) mine - active
# v) visible 
# b) busy
# e) empty
tags="$(leftwm-state -q -w $WSACTIVE -t $LPATH/misc/tags.liquid)"
IFS=';' read -r -a tagsarray <<< "$tags"

# How many tags are configured
tagscount=${#tagsarray[@]}

# Calculate the new window width
# - number of tags (minus the active one) * WIDTH 
WINDOW_COLS="$(($tagscount-1))"
WINDOW_WIDTH="$(($WINDOW_COLS*$WIDTH))"

# Create items list to show
for tag in "${tagsarray[@]}"
do
    tag_index="$(echo $tag | awk -F "\"*,\"*" '{print $1}')"
    tag_status="$(echo $tag | awk -F "\"*,\"*" '{print $3}')"
    if [[ $tag_status == "b" ]] || [[ $tag_status == "v" ]]; then
        tag_name="$(echo $tag | awk -F "\"*,\"*" '{print $2}')$ISBUSY"
    else
        tag_name="$(echo $tag | awk -F "\"*,\"*" '{print $2}')"
    fi

    # Split active tags from the others
	if [[ $tag_status == "m" ]]; then
		TAGACTIVE="Tag: $tag_name (id:$tag_index)"
    else
        if [ -z "$TAGS" ]; then
            TAGS="$tag_name"
        else
            TAGS="$TAGS\n$tag_name"
        fi
	fi 
done

# Rofi config
rofi_cmd="rofi -theme $LPATH/rasi/tags.rasi"

# Main
chosen="$(echo -e "$TAGS" | \
$rofi_cmd -p "$TAGACTIVE" -dmenu \
-selected-row 0 \
-theme-str 'window {width: '$WINDOW_WIDTH';}' \
-theme-str 'listview {columns: '$WINDOW_COLS';}' \
-theme-str 'window {location: '$LOCATION';}' \
)"

# Stripping busy char
if [[ $chosen == *$ISBUSY ]]; then
     chosen="${chosen::-1}"
 fi

# Use choosen to change active tag
for tag in "${tagsarray[@]}"
do
    TAGIDX="$(echo $tag | awk -F "\"*,\"*" '{print $1}')"
    tag_name="$(echo $tag | awk -F "\"*,\"*" '{print $2}')"
	if [[ $tag_name == "$chosen" ]]; then
		leftwm-command "SendWorkspaceToTag $WSACTIVE $TAGIDX"
	fi 
done