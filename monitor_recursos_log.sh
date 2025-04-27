#!/bin/bash 

# Umbrales 
 
CPU_THRESHOLD=80
RAM_THRESHOLD=80

# Configuracion para notificaciones graficas

export DISPLAY=:0
export XAUTHORITY="$HOME/.Xauthority"

# Archivo de log

LOGFILE="$HOME/BASHSTYLE/monitor_log.txt"

# Obtener el porcentage de uso de CPU y RAM
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
RAM_USAGE=$(free | grep Mem | awk '{print ($3/$2) * 100}')


# Redondear valores
CPU_USAGE=$(printf "%.0f" "$CPU_USAGE")
RAM_USAGE=$(printf "%.0f" "$RAM_USAGE")
# obtener fecha actual
DATE=$(date "+%Y-%m-%d_%H:%M:%S")

# Verificar CPU
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
	MESSAGE="[$DATE] CPU alta: ${CPU_USAGE}%"
	echo "$MESSAGE" >> "$LOGFILE"
	notify-send "Alerta de CPU" "$MESSAGE" --icon=dialog-warning
fi

# Verificar RAM
if [ "$RAM_USAGE" -gt "$RAM_THRESHOLD" ]; then
	MESSAGE="[$DATE] RAM alta: ${RAM_USAGE}%"
	echo "$MESSAGE" >> "$LOGFILE"
	notify-send "Alerta de RAM" "$MESSAGE" --icon=dialog-warning
fi
