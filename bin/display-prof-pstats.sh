#!/bin/bash

set -o errexit
set -o nounset


abort() {
    echo "$*"; exit 1;
}

usage() {
    abort "Usage: $(basename $0) [-h|--help] PSTATS_FILE"
}

require() {
    type "$1" >/dev/null 2>/dev/null
}

arg="${1:-}"
while [ "${arg#-}" != "$arg" ]; do
    case "$arg" in
        -h|--help) usage;;
        *) usage;;
    esac
    shift
    arg="${1:-}"
done

require uv
require dot

pstats_file="${1:-}"
[ -f "$pstats_file" ] || abort "File not found: $pstats_file"

output_file="/tmp/${pstats_file%.*}.svg"

uv tool run gprof2dot -f pstats "$pstats_file" | dot -Tsvg -o "$output_file"
echo "Rendered profile saved to: $output_file -- opening in browser..."
x-www-browser "$output_file" >/dev/null 2>&1 || echo "Could not open in browser, please open it manually."
