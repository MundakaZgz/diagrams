#!/bin/bash

# Create temp and images directories
mkdir -p temp images

# Find all .puml files, copy them to temp and generate .png images
find . -name "*.puml" -type f -exec sh -c '
  cp "$1" temp
  java -jar /usr/local/bin/plantuml.jar -tpng -o ../images temp/"$1"
' sh {} \;

# Update README.md with links to the generated images
find images -name "*.png" -type f -exec sh -c '
  filename=$(basename -- "$1")
  extension="${filename##*.}"
  filename="${filename%.*}"
  echo "![$filename]($1)" >> README.md
' sh {} \;