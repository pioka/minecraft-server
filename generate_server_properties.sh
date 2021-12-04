#!/bin/sh
cat << EOS
broadcast-rcon-to-ops=${MC_PROP_BROADCAST_RCON_TO_OPS:-true}
view-distance=${MC_PROP_VIEW_DISTANCE:-10}
enable-jmx-monitoring=${MC_PROP_ENABLE_JMX_MONITORING:-false}
server-ip=${MC_PROP_SERVER_IP:-}
resource-pack-prompt=${MC_PROP_RESOURCE_PACK_PROMPT:-}
rcon.port=${MC_PROP_RCON_PORT:-25575}
gamemode=${MC_PROP_GAMEMODE:-survival}
server-port=${MC_PROP_SERVER_PORT:-25565}
allow-nether=${MC_PROP_ALLOW_NETHER:-true}
enable-command-block=${MC_PROP_ENABLE_COMMAND_BLOCK:-false}
enable-rcon=${MC_PROP_ENABLE_RCON:-false}
sync-chunk-writes=${MC_PROP_SYNC_CHUNK_WRITES:-true}
enable-query=${MC_PROP_ENABLE_QUERY:-false}
op-permission-level=${MC_PROP_OP_PERMISSION_LEVEL:-4}
prevent-proxy-connections=${MC_PROP_PREVENT_PROXY_CONNECTIONS:-false}
resource-pack=${MC_PROP_RESOURCE_PACK:-}
entity-broadcast-range-percentage=${MC_PROP_ENTITY_BROADCAST_RANGE_PERCENTAGE:-100}
level-name=${MC_PROP_LEVEL_NAME:-world}
rcon.password=${MC_PROP_RCON_PASSWORD:-}
player-idle-timeout=${MC_PROP_PLAYER_IDLE_TIMEOUT:-0}
motd=${MC_PROP_MOTD:-A Minecraft Server}
query.port=${MC_PROP_QUERY_PORT:-25565}
force-gamemode=${MC_PROP_FORCE_GAMEMODE:-false}
rate-limit=${MC_PROP_RATE_LIMIT:-0}
hardcore=${MC_PROP_HARDCORE:-false}
white-list=${MC_PROP_WHITE_LIST:-false}
broadcast-console-to-ops=${MC_PROP_BROADCAST_CONSOLE_TO_OPS:-true}
pvp=${MC_PROP_PVP:-true}
spawn-npcs=${MC_PROP_SPAWN_NPCS:-true}
spawn-animals=${MC_PROP_SPAWN_ANIMALS:-true}
snooper-enabled=${MC_PROP_SNOOPER_ENABLED:-true}
difficulty=${MC_PROP_DIFFICULTY:-easy}
function-permission-level=${MC_PROP_FUNCTION_PERMISSION_LEVEL:-2}
network-compression-threshold=${MC_PROP_NETWORK_COMPRESSION_THRESHOLD:-256}
text-filtering-config=${MC_PROP_TEXT_FILTERING_CONFIG:-}
require-resource-pack=${MC_PROP_REQUIRE_RESOURCE_PACK:-false}
spawn-monsters=${MC_PROP_SPAWN_MONSTERS:-true}
max-tick-time=${MC_PROP_MAX_TICK_TIME:-60000}
enforce-whitelist=${MC_PROP_ENFORCE_WHITELIST:-false}
use-native-transport=${MC_PROP_USE_NATIVE_TRANSPORT:-true}
max-players=${MC_PROP_MAX_PLAYERS:-20}
resource-pack-sha1=${MC_PROP_RESOURCE_PACK_SHA1:-}
spawn-protection=${MC_PROP_SPAWN_PROTECTION:-16}
online-mode=${MC_PROP_ONLINE_MODE:-true}
enable-status=${MC_PROP_ENABLE_STATUS:-true}
allow-flight=${MC_PROP_ALLOW_FLIGHT:-false}
max-world-size=${MC_PROP_MAX_WORLD_SIZE:-29999984}
EOS
