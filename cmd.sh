#!/bin/bash
set -e

/usr/sbin/nginx
/usr/local/bin/docker-gen -watch -notify \
    "/usr/sbin/nginx -s reload" /app/nginx.tmpl /etc/nginx/conf.d/default.conf
