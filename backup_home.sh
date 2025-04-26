#!/bin/bash

#Variables 
BACKUP_DIR="$HOME/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"
SOURCE_DIR="$HOME"

# Crear carpeta de backups si no existe 
mkdir -p "$BACKUP_DIR"

#crear el backup

tar -czvf "$BACKUP_FILE" "$SOURCE_DIR"

# Mensaje final 
echo "Backup creado exitosamente: $BACKUP_FILE"
