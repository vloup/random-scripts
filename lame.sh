#!/bin/sh
NAME="name"
ALBUM="album"
YEAR="1337"

for FILE in *.wav ; do
	OUTNAME=`basename "$FILE" .wav`.mp3
	lame -V0 --vbr-new -b320 --lowpass 22.05 -q0 --ta "$NAME" --tl "$ALBUM" --ty "$YEAR" "$FILE" "$OUTNAME"
done
