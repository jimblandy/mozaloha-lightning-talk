#!/usr/bin/env bash

set -eu

slides='
  opening
  what-is
  WebGPU-block
  native
  commands
  try-it
  try-it-2
  final
'

for slide in $slides; do
    if ! [ -f "$slide.svg" ]; then
        echo "Slide not found: $slide" >&2
        exit 1
    fi
done

mkdir -p png
rm -f png/*

i=1
for slide in $slides; do
    png=png/$(printf %02d $i)-$slide.png
    : $((i++))
    inkscape --export-area-page \
             --export-dpi=300 \
             -o "$png" \
             "$slide.svg"
done
