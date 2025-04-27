#!/bin/bash

# Carpeta a monitorear
WATCH_DIR="$HOME/BASHSTYLE/test_folder" # Cambia esto si quieres

# Carpeta donde se guardaran los backups
BACKUP_DIR="$HOME/BASHSTYLE/backups"
# Archivo donde guardamos el "estado anterior"
STATE_FILE="$HOME/BASHSTYLE/last_state.md5"

# Archivo temporal para el estado actual
CURRENT_STATE=$(mktemp)

# Crear carpeta si no existe
mkdir -p "$WATCH_DIR"
mkdir -p "$BACKUP_DIR"
# Generar el estado actual: listar archivos + checksum
find "$WATCH_DIR" -type f -exec md5sum {} \; | sort > "$CURRENT_STATE"

# Comparar con el estado anterior
if [ -f "$STATE_FILE" ]; then
    if cmp -s "$CURRENT_STATE" "$STATE_FILE"; then
        echo "No hay cambios detectados en $WATCH_DIR."
    else
        echo "Cambios detectados en $WATCH_DIR."
	
	# Crear backup
	DATE=$(date +%Y-%m-%d_%H-%M-%S)
	BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"
	
	tar -czvf "$BACKUP_FILE" -C "$WATCH_DIR" .
	
	echo "Backup creado exitosamente: $BACKUP_FILE"
	
	# Notificacion grafica
	export DISPLAY=:0
	export XAUTHORITY="$HOME/.Xauthority"
	notify-send "Backup autormatico" "Backup creado: backup_$DATE.tar.gz" --icon=dialog-information

    fi
else
    echo "No había registro anterior. Guardando estado inicial."
fi

# Actualizar el archivo de estado para la próxima ejecución
cp "$CURRENT_STATE" "$STATE_FILE"

# Borrar el archivo temporal
rm "$CURRENT_STATE"
