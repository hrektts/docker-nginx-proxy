#!/usr/bin/env bats

@test "initialize" {
    run docker run --label bats-type="test" -p 80:80 \
        -v /var/run/docker.sock:/tmp/docker.sock:ro \
        -d hrektts/nginx-proxy:bats
    [ "${status}" -eq 0 ]

    until curl --head localhost:80
    do
        sleep 1
    done

    run docker run --label bats-type="test" -p 8000:8000 \
        -e PROXY_SUBDIR=/sub \
        -e VIRTUAL_PORT=8000 \
        --name backend \
        -d python:3 tail -f /dev/null
    [ "${status}" -eq 0 ]
}

@test "compose site" {
    run docker exec -it backend mkdir -p /var/www/sub
    [ "${status}" -eq 0 ]

    run docker exec -it backend sh -c "echo 'hello' > /var/www/sub/index.html"
    [ "${status}" -eq 0 ]

    run docker exec -it backend sh -c \
        "echo 'cd /var/www && python -m http.server 8000 &' > /var/www/run.sh"
    [ "${status}" -eq 0 ]

    run docker exec -it backend nohup sh /var/www/run.sh
    [ "${status}" -eq 0 ]

    until curl --head localhost:8000
    do
        sleep 1
    done
}

@test "check response from site" {
    run curl -o res.txt localhost:80/sub/
    [ "${status}" -eq 0 ]
    run cat res.txt
    [ "${output}" = "hello" ]
    rm res.txt
}

@test "cleanup" {
    CIDS=$(docker ps -q --filter "label=bats-type")
    if [ ${#CIDS[@]} -gt 0 ]; then
        run docker stop ${CIDS[@]}
        run docker rm ${CIDS[@]}
    fi
}
