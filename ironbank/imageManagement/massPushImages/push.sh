#!/bin/bash

set -exo pipefail

IBIMAGELIST=$(docker images | grep "\-ib" | awk '{print $1 ":" $2}')

for image in $IBIMAGELIST ; do
  docker push "${image}" &
done

wait