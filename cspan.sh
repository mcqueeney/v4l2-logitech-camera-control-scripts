#!/bin/bash

# Sane value if requested
DEFAULT=0
STEP_VALUE=3600

# Useful values for the Logitech 920: min=-36000 max=36000 step=3600

IFS=: read control value <<<"$(v4l2-ctl -d 0 --get-ctrl=pan_absolute)"

if [ -z "$1" ]; then
	v4l2-ctl -d 0 --get-ctrl=pan_absolute
	exit 0
elif [ "$1" == "Right" ]; then
	SETTING="36000"
elif [ "$1" == "Left" ]; then
	SETTING="-36000"
elif [ "$1" == "right" ]; then
	SETTING="$(($value + $STEP_VALUE))"
elif [ "$1" == "left" ]; then
	SETTING=$(($value - $STEP_VALUE))
elif [ "$1" == "sane" ]; then
	SETTING="$DEFAULT"
else
	SETTING="$1"
fi

echo "Setting pan to: $SETTING"
v4l2-ctl -d 0 --set-ctrl=pan_absolute="$SETTING"
