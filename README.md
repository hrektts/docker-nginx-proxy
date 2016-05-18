docker-nginx-proxy
==================

[![Travis Build Status](https://travis-ci.org/hrektts/docker-nginx-proxy.svg?branch=master)](https://travis-ci.org/hrektts/docker-nginx-proxy)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

Dockerfile to build a nginx container image that proxies requests with subdirectories.

Quick Start
-----------

You can launch the container using the docker command line:

``` shell
docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro hrektts/nginx-proxy
```

Then start any containers you want proxied with an env var `PROXY_SUBDIR=subdirectory`:

``` shell
docker run -e PROXY_SUBDIR=service ...
```

The containers being proxied must expose the port to be proxied, either by using the EXPOSE directive in their Dockerfile or by using the --expose flag to docker run or docker create.

HTTPS
-----

HTTPS support can be enabled as follows:

``` shell
docker run -d -p 80:80 -p 443:443 -v /path/to/certs:/etc/nginx/certs \
    -v /var/run/docker.sock:/tmp/docker.sock:ro hrektts/nginx-proxy
```
