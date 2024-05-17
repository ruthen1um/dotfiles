#!/usr/bin/sh
if [ -n "$(pactl get-sink-mute @DEFAULT_SINK@ | grep yes)" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ 0
fi
pactl -- set-sink-volume @DEFAULT_SINK@ +5%
