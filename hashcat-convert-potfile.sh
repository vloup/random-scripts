#!/bin/sh

POTFILE="$HOME/.hashcat/hashcat.pot"

# classic words
cut -d ':' -f 2- "$POTFILE" | grep -e '^\$HEX\[[a-zA-Z0-9]*\]$' -v
# hex words, 0a is newline in hex as a separator
cut -d ':' -f 2- "$POTFILE" | grep -e '^\$HEX\[[a-zA-Z0-9]*\]$' | sed 's/\$HEX\[//' | sed 's/\]$/0a/' | xxd -r -p
