#!/bin/bash

set -euxo pipefail

DEFAULTNS="default"
kubectl create secret generic private-registry \
    --from-file=.dockerconfigjson=${HOME}/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson \
    --namespace ${1:-$DEFAULTNS}
