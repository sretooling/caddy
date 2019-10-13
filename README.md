[![Build Status](https://travis-ci.org/sretooling/caddy.svg?branch=master)](https://travis-ci.org/sretooling/caddy)

# Defaults:

item | default | note
---|---|---
`Caddyfile` | `/`  | over-write this if you want
static assets | `/app/` |   put your `index.html` and other static assets in here.. otherwise set `ROOT=/elsewhere`
http port | `:8080` | set a custom port with `${PORT}`
prometheus  metrics | `:9090/metics` | not a variable..

