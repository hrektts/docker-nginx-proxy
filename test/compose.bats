#!/usr/bin/env bats

@test "initialize using docker-compose" {
    run docker-compose up -d
    [ "${status}" -eq 0 ]

    until curl --head localhost:80
    do
        sleep 1
    done

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

@test "cleanup using docker-compose" {
    run docker-compose stop
    run docker-compose rm -f
}
