FROM outstand/su-exec as su-exec
FROM outstand/tini as tini
FROM outstand/fsconsul as fsconsul

FROM elixir:1.6.4
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

ENV TINI_VERSION v0.17.0
ENV FSCONSUL_VERSION 0.6.4.1

COPY --from=su-exec /sbin/su-exec /sbin/
COPY --from=tini /sbin/tini /sbin/
COPY --from=fsconsul /bin/fsconsul /bin/

RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    jq \
    openssl \
  && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
