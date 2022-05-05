FROM openjdk:18-alpine3.15

RUN apk add --no-cache \
  tzdata \
  curl \
  jq

COPY entrypoint.sh /opt/minecraft/bin/entrypoint.sh

RUN mkdir /opt/minecraft/data

ENV \
  MC_VERSION="" \
  MC_EULA=false \
  MC_TIMEZONE="Etc/UTC" \
  MC_JVM_ARGS="" \
  MC_SERVER_PROPERTIES_BASE64="" \
  MC_INIT_OPS="" \
  MC_INIT_WHITELIST="" \
  MC_INIT_BANNED_PLAYERS="" \
  MC_INIT_BANNED_IPS=""

CMD ["/opt/minecraft/bin/entrypoint.sh"]
