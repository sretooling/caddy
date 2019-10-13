##############################################
FROM golang:1.12-alpine as buildstage

# build deps
RUN apk add --no-cache \
      gcc \
      git \
      musl-dev

WORKDIR /build

COPY . .

ENV GO111MODULE=on
RUN go build -v .
RUN ls -lash




##############################################
FROM alpine

# change these to serve different ports/paths
# these are left as {%VAR%} in the `Caddyfile` meaning they can  be set by ENV var at runtime
ENV PORT 8080
ENV ROOT /app

RUN addgroup -g 1000 -S appuser && \
    adduser -u 1000 -G appuser -S appuser
USER appuser

WORKDIR /app

# Grab the Caddy binary
COPY --from=buildstage /build/caddy /caddy
RUN find  /app

# Install the config file
ADD Caddyfile /

ENTRYPOINT /caddy -conf /Caddyfile
