#!/bin/bash
# simple bash script to animate the frame dump from openscad

name="anim"
png_dir="./assembly-guide/gifs/tmp"
target_dir="./assembly-guide/gifs"

if [ -n "$1" ]; then
    name="$1"
fi

if [ -n "$2" ]; then
    png_dir="$2"
fi

if [ -n "$3" ]; then
    target_dir="$3"
fi

filename_without_extension="${name%.*}"

# needs tomorrow night openscad theme
# convert -resize 20%  -delay 6 -loop 0 -transparent "#1d1f21"  -dispose  previous frame000*.png "$filename_without_extension".gif

convert -delay 6 -loop 0 -dispose previous "$png_dir"/"$filename_without_extension"000*.png "$target_dir"/"$filename_without_extension".gif

#gifsicle -O3 --colors=64 --scale 0.5 -i "$target_dir"/"$filename_without_extension".gif -o "$target_dir"/"$filename_without_extension".gif
gifsicle -O3 --colors=64 --no-warnings --scale 0.5 -i "$target_dir"/"$filename_without_extension".gif -o "$target_dir"/"$filename_without_extension".gif