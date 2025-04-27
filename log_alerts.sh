#!/bin/bash

# Archivo de log que quieres vigilar
LOG_FILE="$HOME/BASHSTYLE/monitor_log.txt"  # Asegúrate de definir esto también

# Palabras clave a buscar
KEYWORDS=("ERROR" "FAIL" "WARNING" "ALERTA" "RAM alta" "CPU alta")

# Configuración para notificaciones gráficas
export DISPLAY=:0
export XAUTHORITY="$HOME/.Xauthority"

# Verificar si el archivo existe
if [ ! -f "$LOG_FILE" ]; then
    echo "Archivo de log no encontrado: $LOG_FILE"
    exit 1
fi

echo "Monitoreando $LOG_FILE en busca de palabras clave..."

# Escuchar el log en tiempo real
tail -fn0 "$LOG_FILE" | while read line; do
    for keyword in "${KEYWORDS[@]}"; do
        if echo "$line" | grep -q "$keyword"; then
            echo "Detección: '$keyword' en línea: $line"
            notify-send "Alerta de Log" "Detectado '$keyword' en logs." --icon=dialog-warning
        fi
    done
done
