FROM outstand/fsconsul as fsconsul

FROM 786715713882.dkr.ecr.us-east-1.amazonaws.com/erlang:24.1.7.0-alpine-3.13

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.13.1" \
  LANG=C.UTF-8

RUN set -xe \
      && ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
      && ELIXIR_DOWNLOAD_SHA256="deaba8156b11777adfa28e54e76ddf49ab1a0132cca54c41d9d7648e800edcc8" \
      && buildDeps=' \
      ca-certificates \
      curl \
      make \
      ' \
      && apk add --no-cache --virtual .build-deps $buildDeps \
      && curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
      && echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
      && mkdir -p /usr/local/src/elixir \
      && tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
      && rm elixir-src.tar.gz \
      && cd /usr/local/src/elixir \
      && make install clean \
      && find /usr/local/src/elixir/ -type f -not -regex "/usr/local/src/elixir/lib/[^\/]*/lib.*" -exec rm -rf {} + \
      && find /usr/local/src/elixir/ -type d -depth -empty -delete \
      && apk del .build-deps

CMD ["iex"]

LABEL maintainer="Ryan Schlesinger <ryan@outstand.com>"

COPY --from=fsconsul /bin/fsconsul /bin/
RUN apk add --no-cache ca-certificates wget openssl jq git bash tini su-exec

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
