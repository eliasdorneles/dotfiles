#!/bin/bash
# Script to optimize images using ImageMagick for web use.

set -o errexit
set -o nounset


abort() {
    echo "$*"; exit 1;
}

usage() {
    abort "Usage: $(basename $0) [-h|--help] FILES..."
}

require() {
    type "$1" >/dev/null 2>/dev/null
}

require convert || abort "Please install ImageMagick"

arg="${1:-}"
do_backup=false
autoresize=true
while [ "${arg#-}" != "$arg" ]; do
    case "$arg" in
        -h|--help) usage;;
        -k|--backup) do_backup=true;;
        --no-autoresize) autoresize=false;;
        *) usage;;
    esac
    shift
    arg="${1:-}"
done
[ "$#" -ge 1 ] || usage


echo BEFORE OPTIMIZATION:
ls -lh "$@"
echo

for f in "$@"; do
    [ -f "$f" ] || abort "File not found: $f"
    $do_backup && cp "$f" "$f.bak"

    # Auto-resize if larger than 1920x1080
    if $autoresize; then
        width=$(identify -format "%w" "$f")
        height=$(identify -format "%h" "$f")
        if [ "$width" -gt 1920 ] || [ "$height" -gt 1080 ]; then
            echo "Resizing $f from ${width}x${height} to fit within 1920x1080"
            convert "$f" -resize 1920x1080\> "$f"
        fi
    fi
    echo "Optimizing $f"
    convert "$f" \
        -sampling-factor 4:2:0 \
        -strip \
        -quality 85 \
        -interlace Plane \
        -gaussian-blur 0.05 \
        "$f"
    echo Done
done

echo
echo AFTER OPTIMIZATION:
ls -lh "$@"
