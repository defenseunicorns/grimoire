#!/bin/bash

set -euxo pipefail

SKOPEO_YAML_PATH=$1
REGISTRY_URL=$2
if [ -z "${SKOPEO_YAML_PATH}" ] || [ -z "${REGISTRY_URL}" ]
then
  echo "The path to the skopeo yaml file and the url for the destination image registry must be provided. e.g."
  echo "./registrySync.sh skopeo.yaml registry.com/path/to/registry/"
  exit 1
else
  skopeo sync --src yaml --dest docker "${SKOPEO_YAML_PATH}" "${REGISTRY_URL}"
fi