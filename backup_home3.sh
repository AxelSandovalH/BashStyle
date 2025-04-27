#!/bin/bash

# Variables 
BACKUP_DIR="$HOME/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"
SOURCE_DIR="$HOME"
DAYS_TO_KEEP=7

# Crear la carpeta de backups si no existe 
mkdir -p "$BACKUP_DIR"

tar -czvf "$BACKUP_FILE" "$SOURCE_DIR"
RESULT=$? # <-- Captura si el comando tar fue exitoso (0) o fallo (>0)

# Configurar entorno para notificaciones graficas (Por que cron no tiene DISPLAY)

export DISPLAY=:0
export XAUTHORITY="$HOME/.Xauthority"

# Verificar si el backup fue exitoso o fallo 

if [ $RESULT -eq 0 ]; then
	echo "Backup creado: $BACKUP_FILE"
	echo "Backups mas antiguos de $DAYS_TO_KEEP dias han sido eliminados"
	
	# Notificacion de exito
	notify-send "Backup exitoso" "Se creo el archivo $BACKUP_FILE" --icon=dialog-information
else
	echo "Error al crear el backup"
	
	#Notificacion de error
	notify-send "Error en el backup" "No se pudo craar el archivo de respaldo." --icon=dialog-error
fi

# Borrar backups mas viejos que $DAYS_TO_KEEP

find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +$DAYS_TO_KEEP -exec rm {} \;
