#!/bin/sh
BIN_DIR='/opt/minecraft/bin'
DATA_DIR='/opt/minecraft/data'
MC_VERSION_LIST_URL='http://launchermeta.mojang.com/mc/game/version_manifest.json'

# 1. Download server binary
# 1.1. Check $MC_VERSION is given
if [ -z "${MC_VERSION}" ]; then
  echo "Please set minecraft version. \n  Example: '-e MC_VERSION=1.16.4'"
  exit 1
fi

# 1.2. Get version manifest
manifest_url=`curl -s ${MC_VERSION_LIST_URL} | jq -r ".versions[] | select(.id==\"${MC_VERSION}\") .url"`
if [ -z "${manifest_url}" ]; then
  echo "Failed to get manifest for ${MC_VERSION}"
  exit 1
fi

# 1.3. Get server binary
echo "Downloading server binary..."
jar_url=`curl -s ${manifest_url} | jq -r ".downloads .server .url"`
curl -s -o ${BIN_DIR}/server.jar ${jar_url} 
echo "done"


# 2. Configure server
# 2.1. Configure timezone
if [ -e /usr/share/zoneinfo/${MC_TIMEZONE} ]; then
  cp /usr/share/zoneinfo/${MC_TIMEZONE} /etc/localtime
else
  echo "Timezone configuration failed"
  exit 1
fi

# 2.2. EULA Agreement
if [ "${MC_EULA:-}" == true ]; then
  echo "eula=true" > ${DATA_DIR}/eula.txt
fi

# 2.3. (First launch only) Create ops.txt if ops is not configured
if [ ! -e ${DATA_DIR}/ops.json ]; then
  for player in ${MC_INIT_OPS}; do
    echo $player >> ${DATA_DIR}/ops.txt
  done
fi

# 2.4. (First launch only) Create whitelist.txt if whitelist is not configured
if [ ! -e ${DATA_DIR}/whitelist.json ]; then
  for player in ${MC_INIT_WHITELIST}; do
    echo $player >> ${DATA_DIR}/white-list.txt
  done
fi

# 2.5. (First launch only) Create banned-players.txt if banned-players is not configured
if [ ! -e ${DATA_DIR}/banned-players.json ]; then
  for player in ${MC_INIT_BANNED_PLAYERS}; do
    echo $player >> ${DATA_DIR}/banned-players.txt
  done
fi

# 2.6. (First launch only) Create banned-ips.txt if banned-ip is not configured
if [ ! -e ${DATA_DIR}/banned-ips.json ]; then
  for player in ${MC_INIT_BANNED_IPS}; do
    echo $player >> ${DATA_DIR}/banned-ips.txt
  done
fi

# 2.7. Generate server.properties
${BIN_DIR}/generate_server_properties.sh > ${DATA_DIR}/server.properties


# 3. Start server
cd ${DATA_DIR} && java -jar ${MC_JVM_ARGS} ${BIN_DIR}/server.jar
