#!/bin/bash

# Sane value if requested
SETTING=4500

# white_balance_temperature_auto

if [ -n "$1" ]; then
	# Request to turn wb into auto or manual?
	if [ "$1" == "auto" ]; then
		echo "Setting white balance to auto"
		v4l2-ctl -d 0 --set-ctrl=white_balance_temperature_auto=1
		exit 0
	fi

	# Use the "sane" value unless they provided something else
	if [ "$1" != "sane" ]; then
		SETTING="$1"
	fi

	echo "Setting white balance temp to: $SETTING"

	# Turn off auto temperature balance then set value
	v4l2-ctl -d 0 --set-ctrl=white_balance_temperature_auto=0
	v4l2-ctl -d 0 --set-ctrl=white_balance_temperature="$SETTING"
else
	v4l2-ctl -d 0 --get-ctrl=white_balance_temperature_auto
	v4l2-ctl -d 0 --get-ctrl=white_balance_temperature
fi

