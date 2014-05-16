#!/bin/bash
# Script to rename files with names in latin1 encoding

abort() {
    echo "$*"; exit 1;
}

usage() {
    abort "Usage: $(basename $0) FILE..."
}

[ -z "$1" ] && usage

set -e

for arq in "$@"
do
    [ -f "$arq" ] || abort "File $arq not found"
    dest="$(echo "$arq" | iconv -f iso-8859-1 -t utf-8)"
    [ "$arq" != "$dest" ] && mv "$arq" "$dest"
done
