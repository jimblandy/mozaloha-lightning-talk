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

mkdir -p pdf
pdfs=
for slide in $slides; do
    pdf=pdf/$slide.pdf
    inkscape --export-area-page \
             --export-dpi=300 \
             -o "$pdf" \
             "$slide.svg"
    pdfs="$pdfs $pdf"
done

pdfunite $pdfs temp.pdf
mv temp.pdf slides.pdf
