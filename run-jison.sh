#!/bin/bash

set -e
error(){ echo "$*"; exit 1; }

[ "x$1" = "x" ] && error """Usage: `basename $0` JISONFILE [INPUTFILE...]

If no INPUTFILEs are provided, the input will be read from STDIN
"""
jisonfile=$1; shift
[ -f "$jisonfile" ] || error "ERROR: File not found: $jisonfile"

outjison=`mktemp`
tmpfile=`mktemp`

# generate parser
jison -o "$outjison" "$jisonfile"

# run jison parser with stdin or filenames from arguments
cat "$@" > "$tmpfile"
node "$outjison" "$tmpfile"

# remove temp files
rm -f "$tmpfile" "$outjison"
