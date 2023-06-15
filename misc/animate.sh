#!/bin/bash
# simple bash script to animate the frame dump from openscad

name="anim"

# Check if an argument is provided and update the variable if so
if [ -n "$1" ]; then
    name="$1"
fi

filename_without_extension="${name%.*}"

# needs tomorrow night openscad theme
convert -resize 20%  -delay 6 -loop 0 -transparent "#1d1f21"  -dispose  previous frame000*.png "$filename_without_extension".gif

gifsicle -O3 --colors=64 --scale 0.5 -i "$filename_without_extension".gif -o "$filename_without_extension".gif