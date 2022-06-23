#!/usr/bin/env bash

port=${port:-8888}
heading=${heading:-'Default heading'}
content=${content:-'Default content'}

function gen-response() {
    echo HTTP/1.1 200 OK
    echo Connection: Keep-Alive
    echo Content-Type: text/html; charset=UTF-8
    echo Content-Length: $(calc-content-length-header "$1")
    echo
    echo "$1"
}

function gen-html-page() {
    cat index.template.html | \
    sed "s/__REPLACEABLE_HEADING__/$heading/" | \
    sed "s/__REPLACEABLE_CONTENT__/$content/"
}

function calc-content-length-header() {
    printf %s $(echo "$1" | wc -c)
}

function main() {
    echo "[nc-server:$$] Listening on port $port..."
    while true;
        do gen-response "$(gen-html-page)" | nc -l $port;
    done;
}

main