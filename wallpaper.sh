#!/bin/sh

LANG=C
readonly URL="http://rammb.cira.colostate.edu/ramsdis/online/images/latest_hi_res/himawari-8/full_disk_ahi_true_color.jpg" 
readonly DATE_EPOCH="$(date +"%s")"
readonly DATE_LOCAL="$(date +"%c")"

# clean previous wallpapers
find /tmp/ -maxdepth 1 -name "wallpaper-*.jpg" -delete

# remove watermark and resize
convert "$URL" \
	-draw 'rectangle 0,5500 1000,5000' \
	-gravity SouthWest \
	-pointsize 100 \
	-fill grey \
	-draw "text 0,0 \"$DATE_LOCAL\"" \
	-resize 1400x788 \
	/tmp/wallpaper-"$DATE_EPOCH".jpg
if [ $? -ne 0 ]; then
	exit
fi

# set as wallpaper
nitrogen --set-auto /tmp/wallpaper-"$DATE_EPOCH".jpg
