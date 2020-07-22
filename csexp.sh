#!/bin/bash

# Sane value if requested
SETTING=156

# Values the camera seems to support are:
# 77 156 312 624 1250

if [ -n "$1" ]; then
	# Get current value of exposure 
	IFS=: read control value <<<"$(v4l2-ctl -d 0 --get-ctrl=exposure_absolute)"

	if [ "$1" == "up" ]; then
		SETTING="$(($value * 2))"
	elif [ "$1" == "down" ]; then
		SETTING=$(( $value / 2 ))
	elif [ "$1" != "sane" ]; then
		# Use the "sane" initial  value unless they provided something else
		SETTING="$1"
	fi

	echo "Setting exposure to: $SETTING"

	# Ensure camera in manual exposure mode, then set it
	v4l2-ctl -d 0 --set-ctrl=exposure_auto=1
	v4l2-ctl -d 0 --set-ctrl=exposure_absolute="$SETTING"
else
	v4l2-ctl -d 0 --get-ctrl=exposure_absolute
fi
