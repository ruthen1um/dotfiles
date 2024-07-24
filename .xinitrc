#!/bin/sh

xbacklight -set 30
exec dbus-run-session awesome
