#!/bin/bash
# Copyright 2018 Brendan Burns.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

. $(dirname ${BASH_SOURCE})/../util.sh

export PATH=$PATH:$HOME/go/bin

if which ccat > /dev/null; then
   CAT="ccat"
else
   CAT="cat"
fi

namespace=build

run "clear"

kubectl create namespace ${namespace} > /dev/null 2>&1 || true

run "${CAT} server.go"

REPO=${REPO:-brendanburns}
IMAGE=${IMAGE:-go-server}
VERSION=first

DOCKER_IMAGE=${REPO}/${IMAGE}:${VERSION}

export CGO_ENABLED=0
export GOOS=linux
export PATH=$PATH:/usr/local/go/bin

run "go build -a -tags netgo -ldflags '-w' server.go"
run "docker build -t ${DOCKER_IMAGE} ."
run "docker push ${DOCKER_IMAGE}"

run "kubectl run --namespace=${namespace} --image=brendanburns/go-server:first server"

run "watch kubectl --namespace=${namespace} get pods"

kubectl delete namespace ${namespace}

