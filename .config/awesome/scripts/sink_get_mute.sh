#!/usr/bin/sh
if [ "$(pactl -- get-sink-mute @DEFAULT_SINK@ | awk '/Mute:/ {print $2}')" = "yes" ]; then
    echo -n "1"
else
    echo -n "0"
fi
