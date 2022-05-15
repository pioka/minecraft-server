#!/bin/sh
set -e

BIN_DIR='/opt/minecraft/bin'
DATA_DIR='/opt/minecraft/data'
PIPE_PATH='/opt/minecraft/pipe/stdin.pipe'
MC_VERSION_LIST_URL='http://launchermeta.mojang.com/mc/game/version_manifest.json'

# 1. Download server binary
# 1.1. Check $MC_VERSION is given
if [ -z "${MC_VERSION}" ]; then
  echo "Please set minecraft version. \n  Example: '-e MC_VERSION=1.16.4'"
  exit 1
fi
echo "* Download v${MC_VERSION} server binary..."

# 1.2. Get version manifest
manifest_url=`curl -s ${MC_VERSION_LIST_URL} | jq -r ".versions[] | select(.id==\"${MC_VERSION}\") .url"`
if [ -z "${manifest_url}" ]; then
  echo "Failed to get manifest for ${MC_VERSION}"
  exit 1
fi

# 1.3. Get server binary
jar_url=`curl -s ${manifest_url} | jq -r ".downloads .server .url"`
curl -s -o ${BIN_DIR}/server.jar ${jar_url} 


# 2. Configure server
echo '* Apply server options...'
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

# 2.3. Generate server.properties
echo ${MC_SERVER_PROPERTIES_BASE64} | base64 -d > ${DATA_DIR}/server.properties
echo -e "Decoded server.properties:\n--------"
cat ${DATA_DIR}/server.properties
echo -e "\n--------"

# 2.4. (First launch only) Create ops.txt if ops is not configured
if [ ! -e ${DATA_DIR}/ops.json ]; then
  for player in ${MC_INIT_OPS}; do
    echo $player >> ${DATA_DIR}/ops.txt
  done
else
  echo '`ops.json` exists. $MC_INIT_OPS will be ignored.'
fi

# 2.5. (First launch only) Create whitelist.txt if whitelist is not configured
if [ ! -e ${DATA_DIR}/whitelist.json ]; then
  for player in ${MC_INIT_WHITELIST}; do
    echo $player >> ${DATA_DIR}/white-list.txt
  done
else
  echo '`whitelist.json` exists. $MC_INIT_BANNED_WHITELIST will be ignored.'
fi

# 2.6. (First launch only) Create banned-players.txt if banned-players is not configured
if [ ! -e ${DATA_DIR}/banned-players.json ]; then
  for player in ${MC_INIT_BANNED_PLAYERS}; do
    echo $player >> ${DATA_DIR}/banned-players.txt
  done
else
  echo '`banned-players.json` exists. $MC_INIT_BANNED_PLAYERS will be ignored.'
fi

# 2.7. (First launch only) Create banned-ips.txt if banned-ip is not configured
if [ ! -e ${DATA_DIR}/banned-ips.json ]; then
  for player in ${MC_INIT_BANNED_IPS}; do
    echo $player >> ${DATA_DIR}/banned-ips.txt
  done
else
  echo '`banned-ips.json` exists. $MC_INIT_BANNED_IPS will be ignored.'
fi

# 3. Create named pipe if not exists.
if [ ! -p ${PIPE_PATH} ]; then
  mkfifo ${PIPE_PATH}
fi

# 4. Start server
echo '* Start server...'
echo '================ server.jar output ================'
tail -f ${PIPE_PATH} | java -jar ${MC_JVM_ARGS} ${BIN_DIR}/server.jar
