#!/bin/bash
set -e

# Warn if the DOCKER_HOST socket does not exist
if [[ ${DOCKER_HOST} == unix://* ]]; then
    SOCKET_FILE=${DOCKER_HOST#unix://}
    if [ ! -S ${SOCKET_FILE} ]; then
        cat >&2 <<-EOT
ERROR: you need to share your Docker host socket with a volume at ${SOCKET_FILE}
Typically you should run your hrektts/nginx-proxy with: \`-v /var/run/docker.sock:${SOCKET_FILE}:ro\`
See the documentation at https://git.io/vo4XR
EOT
        exit 1
    fi
fi

exec "$@"
