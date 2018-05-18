FROM outstand/fsconsul as fsconsul

FROM elixir:1.6.5-alpine
LABEL maintainer="Ryan Schlesinger <ryan@outstand.com>"

COPY --from=fsconsul /bin/fsconsul /bin/
RUN apk add --no-cache ca-certificates wget openssl jq git bash tini su-exec

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
