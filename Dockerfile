FROM elixir:1.6.4
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

ENV GOSU_VERSION 1.10
ENV DUMB_INIT_VERSION 1.2.0
ENV FSCONSUL_VERSION 0.6.4.1

RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    wget -O gosu "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" && \
    wget -O gosu.asc "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64.asc" && \
    gpg --verify gosu.asc && \
    chmod +x gosu && \
    cp gosu /bin/gosu && \
    wget https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 && \
    wget https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/sha256sums && \
    grep dumb-init_${DUMB_INIT_VERSION}_amd64$ sha256sums | sha256sum -c && \
    chmod +x dumb-init_${DUMB_INIT_VERSION}_amd64 && \
    cp dumb-init_${DUMB_INIT_VERSION}_amd64 /bin/dumb-init && \
    ln -s /bin/dumb-init /usr/bin/dumb-init && \
    wget -O - https://keybase.io/outstand/pgp_keys.asc | gpg --import && \
    wget -O fsconsul "https://s3.amazonaws.com/outstand-publish/fsconsul-${FSCONSUL_VERSION}" && \
    wget -O fsconsul.asc "https://s3.amazonaws.com/outstand-publish/fsconsul-${FSCONSUL_VERSION}.asc" && \
    gpg --verify fsconsul.asc && \
    chmod +x fsconsul && \
    cp fsconsul /bin/fsconsul && \
    cd /tmp && \
    rm -rf /tmp/build && \
    rm -rf /root/.gnupg

RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    jq \
    openssl \
  && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
