#!/bin/sh
if [ -z $1 ]; then
	DELAY=1
else
	DELAY="$1"
fi

while true; do
	for frame in *.frame; do
		clear
		cat "$frame"
		sleep $DELAY
	done
done
