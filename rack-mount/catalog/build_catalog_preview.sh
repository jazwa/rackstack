#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <scad_file>"
    exit 1
fi

SCAD_FILE="$1"
CONFIG="micro"

dir=$(dirname "$SCAD_FILE")
filename=$(basename "$SCAD_FILE" .scad)

openscad \
    --colorscheme "Tomorrow Night" \
    --render \
    --imgsize 1920,1080 \
    --projection o \
    --viewall \
    --autocenter \
    -D "profileName=\"$CONFIG\"" \
    -D '$fn=64' \
    -o "$dir/$filename.png" \
    "$SCAD_FILE"

echo "Preview saved to $dir/$filename.png"
