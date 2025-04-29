#!/bin/bash

# Datos de conexión
USUARIO="axl"
SERVIDOR="192.168.100.50"

# Rutas locales donde se encuentran los roms
LOCAL_NES="$HOME/roms/NES"
LOCAL_SNES="$HOME/roms/SNES"
LOCAL_GB="$HOME/roms/GB"
LOCAL_GBA="$HOME/roms/GBA"
LOCAL_PSX="$HOME/roms/PSX"
LOCAL_N64="$HOME/roms/N64"

# Rutas remotas en el servidor
REMOTE_BASE="/var/www/html/roms"

# Subir las ROMS
echo "🚀 Subiendo ROMs de NES..."
rsync -avh --progress "$LOCAL_NES/" "$USUARIO@$SERVIDOR:$REMOTE_BASE/NES/"

echo "🚀 Subiendo ROMs de SNES..."
rsync -avh --progress "$LOCAL_SNES/" "$USUARIO@$SERVIDOR:$REMOTE_BASE/SNES/"

echo "🚀 Subiendo ROMs de GB..."
rsync -avh --progress "$LOCAL_GB/" "$USUARIO@$SERVIDOR:$REMOTE_BASE/GB/"

echo "🚀 Subiendo ROMs de GBA..."
rsync -avh --progress "$LOCAL_GBA/" "$USUARIO@$SERVIDOR:$REMOTE_BASE/GBA/"

echo "🚀 Subiendo ROMs de PSX..."
rsync -avh --progress "$LOCAL_PSX/" "$USUARIO@$SERVIDOR:$REMOTE_BASE/PSX/"

echo "🚀 Subiendo ROMs de N64..."
rsync -avh --progress "$LOCAL_N64/" "$USUARIO@$SERVIDOR:$REMOTE_BASE/N64/"

echo "✅ Subida de ROMs completada."


[NAS]
   path = /srv/nas
   browseable = yes
   writable = yes
   guest ok = no
   valid users = axl
   force user = axl
   create mask = 0775
   directory mask = 0775

sudo apt install samba -y

/etc/samba/smb.conf

sudo pacman -S cifs-utils

sudo mkdir -p /mnt/nas
sudo mount -t cifs //IPSERVER/NAS /mnt/nas -o username=USERNAME

cd /mnt/nas
ls
