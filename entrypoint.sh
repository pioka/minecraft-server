#!/bin/sh
BIN_DIR='/opt/minecraft/bin'
DATA_DIR='/opt/minecraft/data'

# Check $MC_VERSION is given
if [ -z "${MC_VERSION}" ]; then
  echo "Please set minecraft version. \n  Example: '-e MC_VERSION=1.16.4'"
  exit 1
fi

# Get version manifest
manifest_url=`curl -s ${MC_VERSION_LIST_URL} | jq -r ".versions[] | select(.id==\"${MC_VERSION}\") .url"`
if [ -z "${manifest_url}" ]; then
  echo "Failed to get manifest for ${MC_VERSION}"
  exit 1
fi

# Get server binary
echo "Downloading server binary..."
jar_url=`curl -s ${manifest_url} | jq -r ".downloads .server .url"`
curl -s -o ${BIN_DIR}/server.jar ${jar_url} 
echo "done"

# Configure timezone
if [ -e /usr/share/zoneinfo/${MC_TIMEZONE} ]; then
  cp /usr/share/zoneinfo/${MC_TIMEZONE} /etc/localtime
else
  echo "Timezone configuration failed"
  exit 1
fi

# EULA Agreement
if [ "${MC_EULA:-}" == true ]; then
  echo "eula=true" > ${DATA_DIR}/eula.txt
fi

cd ${DATA_DIR}

# Start server
java -jar ${MC_JVM_ARGS} ${BIN_DIR}/server.jar
