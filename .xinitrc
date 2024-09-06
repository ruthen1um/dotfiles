#!/bin/sh

xbacklight -set 30
pkill pipewire
pkill pipewire-pulse
exec dbus-run-session awesome
