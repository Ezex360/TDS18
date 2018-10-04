#! /bin/sh


####
# Script para cambiar extensiones de ficheros o archivos
# Noviembre 2010
####


ext1=$1 # Argumento ext1 es la extensión inicial
ext2=$2 # Argumento ext2 es la extensión final

RUTA=$(/bin/pwd)

for i in *
do
if [ -f "$RUTA/$i" ]; then
arg=${i%%.$ext1}
if [ ! -f "$RUTA/$arg" ]; then
arg1=${arg#$i}
mv "$RUTA/$arg1.$ext1" "$RUTA/$arg1.$ext2"
fi
else
echo "$i" > /dev/null
fi
done


exit 0
