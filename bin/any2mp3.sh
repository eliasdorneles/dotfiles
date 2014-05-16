#!/bin/bash
# Script to convert to mp3 any file that mplayer can play
# Requires mplayer and lame

abort() {
    echo "$*"; exit 1;
}

usage() {
    abort "Usage: $(basename $0) MEDIA_FILE..."
}

while [ "${1#-}" != "$1" ]; do
    case "$1" in
        -h) usage;;
        *) usage;;
    esac
    shift
done

if ! type mplayer >/dev/null 2>/dev/null; then
    abort "This script requires mplayer, install with: sudo apt-get install mplayer"
fi
if ! type lame >/dev/null 2>/dev/null; then
    abort "This script requires lame, install with: sudo apt-get install lame"
fi

[ -z "$1" ] && usage

dump=`mktemp wavdumpXXXX.wav`
for i in "$@"
do
	[ -f "$i" ] || abort "File $i not found"
	ext="${filename##*.}"
    dest="${filename%.*}.mp3"
	echo -n "Decoding wave... "
	mplayer -vo null -novideo -af resample=44100 \
        -ao pcm:waveheader:fast:file="$dump" "$i" \
        >/dev/null 2>/dev/null || abort "problem decoding file $i"
	echo -n "encoding to mp3... "
	lame -h -m s "$dump" -o "$dest" >/dev/null 2>/dev/null
	echo "done"
done

rm -f "$dump"
