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

run "clear"

kubectl create namespace demos > /dev/null 2>&1 || true

desc "Create a Service to load balancer our server"
run "${CAT} svc.yaml"

run "kubectl apply -f svc.yaml"

run "${CAT} v1/server.go"

cd v1
./make.sh
cd ..

run "${CAT} v1/deployment.yaml"

run "kubectl apply -f v1/deployment.yaml"

run "watch kubectl --namespace=demos get pods"

tmux new -d -s my-deploy-session \
    "$(dirname $BASH_SOURCE)/split1_control.sh" \; \
    split-window -v -p 66 "$(dirname ${BASH_SOURCE})/split1_hit_svc.sh" \; \
    split-window -v "$(dirname ${BASH_SOURCE})/split1_watch.sh v1" \; \
    split-window -h -d "$(dirname ${BASH_SOURCE})/split1_watch.sh v2" \; \
    select-pane -t 0 \; \
    attach \;

kubectl delete namespace demos 2> /dev/null || true
