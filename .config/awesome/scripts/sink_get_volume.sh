#!/usr/bin/sh
pactl -- get-sink-volume @DEFAULT_SINK@ | awk -F/ '/Volume:/ {gsub(/ /, "", $2); gsub(/%/, "", $2); print $2}'
