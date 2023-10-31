#!/bin/bash

# Descarga los diagramas de PlantUML del repositorio y los guarda en una carpeta temporal
mkdir temp
find . -name "*.puml" -type f -exec cp {} temp \;
# find . -name "*.puml" -type f -exec cp --parents {} temp \;


# Genera las imágenes PNG correspondientes a cada archivo .puml
cd temp
for file in $(find . -name "*.puml" -type f); do
  java -jar /usr/local/bin/plantuml.jar -tpng $file
done

# Copia las imágenes generadas a una carpeta del repositorio
mkdir -p ../images
find . -name "*.png" -type f -exec cp --parents {} ../images \;

# Actualiza el archivo README.md con los enlaces a las imágenes generadas
cd ..
for file in $(find images -name "*.png" -type f); do
  filename=$(basename -- "$file")
  extension="${filename##*.}"
  filename="${filename%.*}"
  echo "![$filename]($file)" >> README.md
done
