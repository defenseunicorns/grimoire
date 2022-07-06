# Purpose
Uses [skopeo](https://github.com/containers/skopeo) to move containers between registries. This can be very useful when moving images from an upstream registry into the repo1 container registry during bigbang package work.

# Usage
`./registrySync.sh [path to skopeo-sync.yaml file] [url for downstream (e.g. repo1) registry]`

## Example
`./registrySync.sh ./skopeo-sync.yaml registry.dso.mil/projecturl/`