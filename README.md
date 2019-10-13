[![Build Status](https://travis-ci.org/sretooling/caddy.svg?branch=master)](https://travis-ci.org/sretooling/caddy)

# Defaults:

item | default | note
---|---|---
`Caddyfile` | `/`  | over-write this if you want
static assets | `/app/` |   put your `index.html` and other static assets in here.. otherwise set `ROOT=/elsewhere`
http port | `:8080` | set a custom port with `${PORT}`
prometheus  metrics | `:9090/metics` | not a variable..



## Example usage


In this example I'm compiling some static assets with hugo in a multi-stage build.

The second stage is simply copying the contents of a generated `public` directory from the first stage into caddy `/app/.`


```
FROM jojomi/hugo:0.56 as hugo

# lets work in a directory called `/hugo`
WORKDIR /hugo
COPY content .
RUN find /hugo -type f
RUN hugo
# The "find" commands are for you to simply see whats produced..
RUN find /hugo/public -type f

##############################################
FROM sretooling/caddy

COPY --from=hugo /hugo/public /app
```



build it with a tag called `waz` (EG)
```
docker build -t waz .
```


now test.. lets launch the container

```
docker run -it -p 8080:8080 -p 9090:9090 waz
```



lets see if its doing its job... see: http://localhost:8080 / http://localhost:9090/metrics
```
# see the docroot
curl localhost:8080

# see the metrics
curl localhost:9090/metrics
```

There is no need to set `CMD` or `ENTRYPOINT` as that is already done in the source image
