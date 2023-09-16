FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl unzip

RUN [ "$(uname -m)" = "aarch64" ] && arch=arm64 || arch=x64 \
  && mkdir /ghjk && cd /ghjk \
  && curl -fLOJ "https://github.com/kryolite-crypto/kryolite/releases/download/2.2.1/kryolite-kryolite-linux-${arch}.zip" \
  && unzip "kryolite-kryolite-linux-${arch}.zip" \
  && mv kryolite /usr/local/bin \
  && rm -rf /ghjk

RUN apt-get update && apt-get install -y --no-install-recommends \
  libicu-dev sqlite

ENTRYPOINT ["/usr/local/bin/kryolite", "wallet", "list" ]
