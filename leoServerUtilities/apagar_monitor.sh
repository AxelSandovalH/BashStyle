#!/bin/bash

# Usuario de la sesion grafica
GRAPHICAL_USER="axl"

# Display de la sesion grafica
DISPLAY_NUMBER=":1"
 
# Archivo de autorizacion para controlar X11
XAUTHORITY_FILE="/home/$GRAPHICAL_USER/.Xauthority"

# Verificar si el archivo XAUTHORITY existe
if [ ! -f "$XAUTHORITY_FILE" ]; then
	echo "No se encontro el archivo $XAUTHORITY_FILE"
	exit 1
fi

# Comando para apagar el monitor 
sudo -u "$GRAPICAL_USER" DISPLAY="$DISPLAY_NUMBER" XAUTHORITY="$XAUTHORITY_FILE" xset dpms force off

# Mensaje final
echo "Monitor apagado exitosamente"
