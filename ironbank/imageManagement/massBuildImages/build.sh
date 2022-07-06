#!/bin/bash

set -xo pipefail

rm_old_images () {
  docker images | grep "\-ib" | awk '{print $3}' | xargs docker rmi
}

download_resources () {
  URLLIST=$(cat ./hardening_manifest.yaml | yq '.resources.[] | select(. | has("filename")) | .url');
  for url in $URLLIST ; do
    IBFILENAME=$(cat ./hardening_manifest.yaml | yq ".resources.[] | select(.url == \"${url}\") | .filename")
    wget -O "${IBFILENAME}" "${url}";
  done;
}

build_image () {
  IBVERSION=$(cat ./hardening_manifest.yaml | yq '.labels."org.opencontainers.image.version"')
  IBNAME=$(cat ./hardening_manifest.yaml | yq '.name')
  DOCKER_BUILDKIT=1 docker build -t "registry.dso.mil/platform-one/big-bang/apps/third-party/${IBNAME}:${IBVERSION}-ib" .
}

docker_ops() {
  download_resources;
  build_image;
}

rm_old_images

set -exo pipefail

if [ -z "${1}" ]
then
  for d in */ ; do
    pushd "${d}";
    docker_ops &
    popd;
  done
else
  pushd "${1}";
  docker_ops;
  popd;
fi

wait