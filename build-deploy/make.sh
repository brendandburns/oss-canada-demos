#!/bin/bash

REPO=${REPO:-brendanburns}
IMAGE=${IMAGE:-go-server}
VERSION=first

DOCKER_IMAGE=${REPO}/${IMAGE}:${VERSION}

. $(dirname ${BASH_SOURCE})/../util.sh

export CGO_ENABLED=0
export GOOS=linux
export PATH=$PATH:/usr/local/go/bin

run "go build -a -tags netgo -ldflags '-w' server.go"
run "docker build -t ${DOCKER_IMAGE} ."
run "docker push ${DOCKER_IMAGE}"
