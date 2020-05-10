FROM alpine:3.11

RUN apk add --no-cache \
  openjdk11-jre-headless \
  screen \
  ncurses-terminfo \
  util-linux \
  tzdata

ARG JAR_URL

WORKDIR /opt/minecraft/
RUN wget -q ${JAR_URL} -O server.jar
COPY entrypoint.sh backup-loop.sh ./

WORKDIR /opt/minecraft/data
CMD ["/opt/minecraft/entrypoint.sh"]
