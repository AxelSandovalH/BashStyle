#!/bin/bash

# Configuracion
NAS_SERVER="192.168.100.50"
NAS_SHARE="NAS"
NAS_USER="axl"
NAS_PASSWORD="psyduck56"
REMOTE_PATH="/" 

# Preguntar por el nombre del archivo a crear y subir
read -p "Nombre del archivo a crear y subir: " FILENAME

# Crear archivo local
touch "$FILENAME"
echo "Archivo'$FILENAME' creado localmente"

# Subir archivo usando smbclient
echo "Subiendo '$FILENAME' al NAS..."
smbclient "//$NAS_SERVER/$NAS_SHARE" "$NAS_PASSWORD" -U "$NAS_USER" -c "cd $REMOTE_PATH; put $FILENAME"

# Confirmar
echo "Archivo '$FILENAME' subido correctamente"

