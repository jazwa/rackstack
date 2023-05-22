#!/bin/bash

# Set the directory where the GIF files are located
directory="./assembly"

# Change to the target directory
cd "$directory" || exit



# Iterate over each GIF file in the directory
for file in *.gif; do
  # Check if the file is a regular file
  if [[ -f "$file" ]]; then
    # Create a temporary file name for the resized GIF
    temp_file=$(mktemp)

    # Optimize and resize the GIF file using gifsicle
    gifsicle -O3 --resize-fit 1920x1080 --colors 8 "$file" -o "$temp_file"

    # Replace the original file with the optimized and resized version
    mv "$temp_file" "$file"
  fi
done
