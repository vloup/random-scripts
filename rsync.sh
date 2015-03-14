#!/bin/sh
#
# backup the windows and linux steam library on raspberrypi.local with rsync. 

readonly USER="user"
readonly HOST="host.local"
readonly FOLDER="steam"
readonly WIFI="wifi"

# print an error message and stop the script
#	usage: error ["function"] ["message"]
error() {
	function="unknown function"
	message="no given error message"

	if [ "$#" -ge 2 ]; then
		function="$1"
		shift
	fi

	if [ "$#" -ge 1 ]; then
		message="$1"
		shift
	fi

	echo "[ERROR] $function: $message" 1>&2
	exit 1
}

# get the current wifi name
getWifiName() {
	echo $(iwconfig wlp3s0 | grep 'ESSID:' | awk '{print $4}' | sed 's/ESSID://g' | sed 's/"//g')
}

# rsync shortener for steam folder
#	usage: steam_sync "steampath/" "remote-subfolder/"
steam_sync() {
	if [ "$#" -ne 2 ]; then
		error "steam_sync" "expected 2 arguments"
	fi

	if [ ! -d "$1" ]; then
		error "steam_sync" "$1 is not a folder"	
	fi
	
	if [ ! -x "$1" ]; then
		error "steam_sync" "No search permission for $1"
	fi

	# rsync options used
	# -a		archive
	# -m		ignore empty folders
	# -v		verbose (currently disabled)
	# -h		human readable
	# -z		compress (currently disabled)
	# --progress	show progress
	# --exclude	exclude given directory (mostly download and temp folders)
	rsync -amh --progress --exclude="temp/" --exclude="downloading/" \
		"$1" \
		"$USER@$HOST:$FOLDER/$2"

	if [ "$?" -ne 0 ]; then
		error "steam_sync" "rsync returned a non-zero return code"
	fi

}

# check we are in the right wifi network
wifi=$(getWifiName)
if [ "$wifi" != "$WIFI" ]; then
	error "main" "not in local wifi"
fi

steam_sync folder1 "remote1"
