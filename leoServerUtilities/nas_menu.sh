#!/bin/bash

# Configuración de conexión
NAS_SERVER="192.168.100.50"
NAS_SHARE="NAS"
NAS_USER="axl"
NAS_PASSWORD="psyduck56"
REMOTE_PATH=""  # Dejamos vacío para usar el directorio raíz del share

# Función para crear y subir archivo
crear_y_subir() {
    read -p "Nombre del nuevo archivo a crear: " FILENAME
    
    # Validación del nombre
    if [[ -z "$FILENAME" ]]; then
        echo "Error: El nombre no puede estar vacío"
        return 1
    fi
    
    # Crear archivo local
    touch "$FILENAME" || {
        echo "Error: No se pudo crear el archivo local"
        return 1
    }
    echo "Archivo '$FILENAME' creado localmente."
    
    # Subir al NAS (directamente al root del share)
    echo "Subiendo '$FILENAME' al NAS..."
    if smbclient "//${NAS_SERVER}/${NAS_SHARE}" -U "${NAS_USER}%${NAS_PASSWORD}" -c "put \"${FILENAME}\""; then
        echo "✅ SUBIDO EXITOSAMENTE"
    else
        echo "❌ Error al subir el archivo"
        return 1
    fi
}

# Función para subir archivo existente
subir_existente() {
    read -p "Ruta local del archivo existente a subir: " LOCALFILE
    
    # Validar que el archivo existe
    if [[ ! -f "$LOCALFILE" ]]; then
        echo "Error: El archivo '$LOCALFILE' no existe"
        return 1
    fi
    
    # Extraer solo el nombre del archivo
    FILENAME=$(basename "$LOCALFILE")
    
    echo "Subiendo '$FILENAME' al NAS..."
    if smbclient "//${NAS_SERVER}/${NAS_SHARE}" -U "${NAS_USER}%${NAS_PASSWORD}" -c "put \"${LOCALFILE}\" \"${FILENAME}\""; then
        echo "✅ SUBIDO EXITOSAMENTE"
    else
        echo "❌ Error al subir el archivo"
        return 1
    fi
}

# Función para listar archivos
listar_nas() {
    echo "Contenido del NAS:"
    smbclient "//${NAS_SERVER}/${NAS_SHARE}" -U "${NAS_USER}%${NAS_PASSWORD}" -c "ls"
}

# Menú principal
while true; do
    clear
    echo "=== NAS Management Menu ==="
    echo "1) Crear y subir nuevo archivo"
    echo "2) Subir archivo existente"
    echo "3) Listar archivos en NAS"
    echo "4) Salir"
    echo ""
    read -p "Selecciona una opción [1-4]: " OPCION

    case $OPCION in
        1) crear_y_subir ;;
        2) subir_existente ;;
        3) listar_nas ;;
        4) echo "Saliendo... ¡Hasta luego!"; exit 0 ;;
        *) echo "Opción inválida" ;;
    esac

    read -p "Presiona Enter para continuar..."
done
