FROM openjdk:18-alpine3.15

RUN apk add --no-cache \
  tzdata \
  curl \
  jq

COPY entrypoint.sh /opt/minecraft/bin/entrypoint.sh
COPY generate_server_properties.sh /opt/minecraft/bin/generate_server_properties.sh

RUN mkdir /opt/minecraft/data

ENV \
  MC_VERSION="" \
  MC_EULA=false \
  MC_TIMEZONE="Etc/UTC" \
  MC_JVM_ARGS=""

CMD ["/opt/minecraft/bin/entrypoint.sh"]
