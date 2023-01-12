#!/bin/bash

STL_TARGET_DIR=stl
RACK_DIR=rack
RACK_TARGET_DIR="$STL_TARGET_DIR"/"$RACK_DIR"

echo "Starting build"

rbuild() {

  mkdir -p "$RACK_TARGET_DIR";

  local command="$1"
  local item="$2"

  if [[ "$command" == "build" ]]; then
    build_scad "$item"
  elif [[ "$command" == "clean" ]]; then
    clean_scad "$item"
  fi

  echo "That all folks"
}

build_scad() {
  if [[ -z "$item" ]]; then
    build_scad_dir;
  else
    build_scad_file "$item";
  fi
}

clean_scad() {
  local item="$1"
  if [[ -z "$item" ]]; then
    clean_scad_dir;
  else
    clean_scad_file "$item";
  fi
}

build_scad_file() {
  local source_item=$1;
  local source_file_name="$RACK_DIR"/"$source_item".scad
  local target_file_name="$RACK_TARGET_DIR"/"$source_item".stl

  echo "Building" "$source_file_name" "to" "$target_file_name"

  openscad -o "$target_file_name" "$source_file_name"
}

build_scad_dir() {
 echo "build_scad_dir TODO"
}

clean_scad_file() {
  local stl_item=$1;
  local stl_file_name="$RACK_TARGET_DIR"/"$stl_item".stl

  echo "Removing" "$stl_file_name"
  rm "$stl_file_name"
}

clean_scad_dir() {
  echo "clean_scad_dir TODO"
}

rbuild "$1" "$2"