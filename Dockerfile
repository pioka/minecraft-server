FROM alpine:3.11

RUN apk add --no-cache \
  openjdk11-jre-headless \
  tzdata \
  curl \
  jq

COPY entrypoint.sh /opt/minecraft/bin/entrypoint.sh
RUN mkdir /opt/minecraft/data

ENV \
  MC_VERSION_LIST_URL='http://launchermeta.mojang.com/mc/game/version_manifest.json' \
  MC_EULA=false \
  MC_JVM_ARGS="" \
  MC_TIMEZONE="Etc/UTC" \
  MC_VERSION=""

CMD ["/opt/minecraft/bin/entrypoint.sh"]
