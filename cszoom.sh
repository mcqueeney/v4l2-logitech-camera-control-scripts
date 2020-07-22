#!/bin/bash

# Sane value if requested
DEFAULT=100

if [ -z "$1" ]; then
	v4l2-ctl -d 0 --get-ctrl=zoom_absolute
	exit 0
elif [ "$1" == "sane" ]; then
	SETTING="$DEFAULT"
else
	SETTING="$1"
fi

echo "Setting zoom to: $SETTING"
v4l2-ctl -d 0 --set-ctrl=zoom_absolute="$SETTING"
