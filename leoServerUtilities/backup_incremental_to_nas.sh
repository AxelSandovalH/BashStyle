#!/bin/bash

# Variables

SOURCE_DIR="$HOME/Proyectos"
DEST_DIR="/srv/nas/Backups/Incremental"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Crear carpeta de destino si no existe

mkdir -p "$DEST_DIR"

# Realizar backup incremental
rsync -av --delete "$SOURCE_DIR/" "$DEST_DIR/$DATE/"
echo "Backup incremental realizado exitosamente"
