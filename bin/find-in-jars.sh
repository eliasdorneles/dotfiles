#!/bin/bash
# Script to search for filenames inside JAR files

if [ "x$2" = "x" ]; then
    echo "Usage: `basename $0` PATTERN JARFILE..."
    echo
    echo "Search for PATTERN in content list of JARFILE(s)"
    exit 1
fi

search="$1"; shift
for file in "$@"
do
    echo "Listing content of $file"
    jar tf "$file" | grep --color=auto "$search"
done
