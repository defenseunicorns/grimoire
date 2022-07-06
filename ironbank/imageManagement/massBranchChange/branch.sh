#!/bin/bash

set -exo pipefail

for d in */ ; do
  pushd "$d"
  git fetch
  if [ "${1}" == "--create" ] || [ "${1}" == "-c" ]
  then
    git checkout -b "${1:-development}"
  else
    git checkout "${1:-development}"
  fi
  git pull
  popd
done