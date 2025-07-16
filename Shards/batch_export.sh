#!/bin/bash

INPUT_DIR="svg"
OUTPUT_DIR_4K="png/4k"
OUTPUT_DIR_1080="png/1080"

mkdir -p "$OUTPUT_DIR_4K" "$OUTPUT_DIR_1080"

if command -v inkscape >/dev/null 2>&1; then
  INKSCAPE_CMD="inkscape"
else
  INKSCAPE_CMD="flatpak run org.inkscape.Inkscape"
fi

# Export 4K
for file in "$INPUT_DIR"/*.svg; do
  filename=$(basename "$file" .svg)
  $INKSCAPE_CMD "$file" \
    --export-type="png" \
    --export-width=3840 \
    --export-height=2160 \
    --export-filename="$OUTPUT_DIR_4K/${filename}_4k.png"
  echo "Exported 4K: ${filename}_4k.png"
done

# Export 1080p
for file in "$INPUT_DIR"/*.svg; do
  filename=$(basename "$file" .svg)
  $INKSCAPE_CMD "$file" \
    --export-type="png" \
    --export-width=1920 \
    --export-height=1080 \
    --export-filename="$OUTPUT_DIR_1080/${filename}.png"
  echo "Exported 1080p: ${filename}.png"
done
