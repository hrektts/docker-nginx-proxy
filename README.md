docker-nginx-proxy
==================

[![Travis Build Status](https://travis-ci.org/hrektts/docker-nginx-proxy.svg?branch=master)](https://travis-ci.org/hrektts/docker-nginx-proxy)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

Dockerfile to build a nginx container image that proxies requests with
subdirectories.

Quick Start
-----------

You can launch the container using the docker command line:

``` shell
docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro hrektts/nginx-proxy
```

Then start any containers you want to be proxied with an environment variable
`PROXY_SUBDIR=/subdirectory`:

``` shell
docker run -e PROXY_SUBDIR=/subdirecroty ...
```

The containers being proxied must expose the port to be proxied, either by using
the EXPOSE directive in their Dockerfile or by using the --expose flag to docker
run or docker create.

HTTPS
-----

HTTPS support can be enabled as follows:

``` shell
docker run -d -p 80:80 -p 443:443 -v /path/to/certs:/etc/nginx/certs \
    -v /var/run/docker.sock:/tmp/docker.sock:ro hrektts/nginx-proxy
```

The default path to look for the SSL certificates is /etc/nginx/certs.
To enable HTTPS support, this directory must contain a private key and
a certificate named /etc/nginx/certs/default.key and
/etc/nginx/certs/default.crt respectively, these can however be changed using
the SSL_KEY_PATH and SSL_CERTIFICATE_PATH configuration options.

Available Configuration Parameters
----------------------------------

- SSL_CERTIFICATE_PATH:
  Location of the ssl certificate. Defaults to `/etc/nginx/certs/default.crt`.

- SSL_KEY_PATH:
  Location of the ssl private key. Defaults to `/etc/nginx/certs/default.key`.

- SSL_DHPARAM_PATH
  Location of the dhparam file. Defaults to `/etc/nginx/certs/default.dhparam.pem`.

Available Configuration Parameters for Backend Container
--------------------------------------------------------

- PROXY_SUBDIR:
  The relative url of the backend service, e.g. /backend.

- PROXY_MAX_OBJECT_SIZE:
  Maximum size of a object to be uploaded in byte. The default value of Nginx is
  used if no other value has been specified.

- VIRTUAL_PROTO:
  The communication protocol between the proxy container and the backend
  container. Defaults to `http`.

- VIRTUAL_PORT:
  The port to be proxied. Defaults to `80`.
