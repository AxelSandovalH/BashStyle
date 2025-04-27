#!/bin/bash

# Usuario de la sesión gráfica
GRAPHICAL_USER="axl"

# Display de la sesión gráfica
DISPLAY_NUMBER=":1"

# Archivo de autorización para controlar X11
XAUTHORITY_FILE="/home/$GRAPHICAL_USER/.Xauthority"

# Verificar si el archivo XAUTHORITY existe
if [ ! -f "$XAUTHORITY_FILE" ]; then
    echo "No se encontró el archivo $XAUTHORITY_FILE. ¿Está la sesión gráfica activa?"
    exit 1
fi

# Comando para "encender" el monitor
sudo -u "$GRAPHICAL_USER" DISPLAY="$DISPLAY_NUMBER" XAUTHORITY="$XAUTHORITY_FILE" xset dpms force on

# Mensaje final
echo "Monitor encendido exitosamente."
