# minecraft-server
## Getting Started
[docker-compose Example](https://github.com/pioka/minecraft-server/blob/master/example/docker-compose.yml)

## Configuration
### Volume
* __`/opt/minecraft/data`__:
  * Contains Minecraft world data.

### Environment Variables
#### Generic Options
* __`MC_VERSION`__:
  * (required) The version of the Minecraft server you want to run.
  * default: ``
* __`MC_EULA`__:
  * (required) Set to `true`, if you agree to the EULA.
  * default: `false`
* __`MC_TIMEZONE`__:
  * (optional) Timezone.
  * default: `Etc/UTC`
* __`MC_JVM_ARGS`__:
  * (optional) Command line args for JVM.
  * default: ``

#### Options available at first launch
These options can be specify multiple values, separated by spaces.

* __`MC_INIT_OPS`__:
  * (optional) Players to add ops.
  * default: ``
* __`MC_INIT_WHITELIST`__:
  * (optional) Players to add white-list
  * default: ``
* __`MC_INIT_BANNED_PLAYERS`__:
  * (optional) Players to add banned-players
  * default: ``
* __`MC_INIT_BANNED_IPS`__:
  * (optional) IPs to add banned-ips
  * default: ``

#### Options for server.properties
You can use __`MC_PROP_*`__ variable to set the value of `server.properties`.  
e.g. `MC_PROP_VIEW_DISTANCE=32`→`view-distance=32`
