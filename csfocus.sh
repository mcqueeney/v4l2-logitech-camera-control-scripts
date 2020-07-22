#!/bin/bash

# Sane value if requested
SETTING=45

if [ -n "$1" ]; then
	# Use the "sane" value unless they provided something else
	if [ "$1" != "sane" ]; then
		SETTING="$1"
	fi

	echo "Setting focus to: $SETTING"

	# Ensure camera in manual exposure mode, then set it
	v4l2-ctl -d 0 --set-ctrl=focus_auto=0
	v4l2-ctl -d 0 --set-ctrl=focus_absolute="$SETTING"
else
	v4l2-ctl -d 0 --get-ctrl=focus_absolute
fi
