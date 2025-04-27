#!/bin/bash

# Ruta base donde estarán tus ROMs
BASE_DIR="$HOME/roms"

# Lista de sistemas de juegos retro
SISTEMAS=("NES" "SNES" "GB" "GBA" "PSX" "N64" "Genesis" "Arcade")

# Crear carpeta base si no existe
mkdir -p "$BASE_DIR"

# Crear subcarpetas por sistema
for sistema in "${SISTEMAS[@]}"; do
    mkdir -p "$BASE_DIR/$sistema"
    echo "Carpeta creada: $BASE_DIR/$sistema"
done

echo "Todas las carpetas de ROMs fueron creadas correctamente."

