#!/bin/bash

# Variables
BACKUP_DIR="$HOME/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"
SOURCE_DIR="$HOME"
DAYS_TO_KEEP=7 # <-- Numero de dias que quieres conservar los backups

# Crear carpeta de backups si no existe
mkdir -p "$BACKUP_DIR"

# Crear el backup 
tar -czvf "$BACKUP_FILE" "$SOURCE_DIR"

# Borrar backups mas viejos que $DAYS_TO_KEEP dias
find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +$DAYS_TO_KEEP -exec rm {} \;

# Mensaje Final 

echo "Backup creado: $BACKUP_FILE"
echo "Backups mas antiguos de $DAYS_TO_KEEP dias han sido eliminados"
