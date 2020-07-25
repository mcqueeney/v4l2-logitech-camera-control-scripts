#!/bin/bash

# Brightness
# min=0 max=255 step=1 default=128

# Sane value if requested
SETTING=128

if [ -n "$1" ]; then
	# Use the "sane" value unless they provided something else
	if [ "$1" != "sane" ]; then
		SETTING="$1"
	fi

	echo "Setting brightness to: $SETTING"

	v4l2-ctl -d 0 --set-ctrl=brightness="$SETTING"
else
	v4l2-ctl -d 0 --get-ctrl=brightness
fi
