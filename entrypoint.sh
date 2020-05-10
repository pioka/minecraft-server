#!/bin/sh
JAR_DIR=/opt/minecraft

echo "================ Environment ================"
echo "MC_EULA                 | ${MC_EULA:=false}"
echo "MC_JVM_ARGS             | ${MC_JVM_ARGS:=}"
echo "MC_PORT                 | ${MC_PORT:=25565}"
echo "MC_BACKUP_PERIOD_SEC    | ${MC_BACKUP_PERIOD_SEC:=0}"
echo "MC_TIMEZONE             | ${MC_TIMEZONE:=Etc/UTC}"
echo "MC_BACKUP_COMPLETE_TEXT | ${MC_BACKUP_COMPLETE_TEXT:=}"
echo "============================================="

# Timezone configuration
if [ -e /usr/share/zoneinfo/${MC_TIMEZONE} ]; then
  cp /usr/share/zoneinfo/${MC_TIMEZONE} /etc/localtime
else
  echo "Timezone configuration failed"
fi

# EULA Agreement
if [ "${MC_EULA:-}" == true ]; then
  echo "eula=true" > eula.txt
fi

# Start server on screen
screen -mdS minecraft java -jar ${MC_JVM_ARGS} ${JAR_DIR}/server.jar --port=${MC_PORT}

# Run backup script if $MC_BACKUP_PERIOD_SEC > 0
if [ ${MC_BACKUP_PERIOD_SEC} -gt 0 ]; then
  mkdir -p backup
  ${JAR_DIR}/backup-loop.sh ${MC_BACKUP_PERIOD_SEC} &
fi

# Display server console
export TERM=vt100
script -c "screen -r minecraft" /dev/null
