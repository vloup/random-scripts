#!/bin/sh

####################
# Display an error and quit
#
# use: error "message"
error () {
	echo "$@" 1>&2
	exit 1
}

####################
# Display a warning
#
# use: warn "message"
warn () {
	echo "$@" 1>&2
}

####################
# Main script
#
# use: email-to-eml.sh "folder"
if [ $# -ne 1 ]; then
	error "Not enough arguments"
fi

if [ ! -d "$1" ]; then
	error "Not a directory"
fi

for file in "$1"/*; do
	if [ -f "$file" ] && [ -r "$file" ] && [ -w "$file" ]; then
		name="$(grep "Subject: " "$file" | head -n 1 | sed -e 's/Subject: //g' | sed -e 's/\///g')" || warn "Runtime error: not an email"
		mv "$file" "$1"/"$name".eml || warn "Runtime error: could not rename"
		echo "$file -> $1/$name.eml"
	fi
done
