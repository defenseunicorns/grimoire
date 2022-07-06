# Purpose
This script goes into all subdirectories from where the script was run and emulates an IB pipeline build. It should parse the hardening_manifest.yaml files to download whatever resources are in it. After that it runs a docker build using buildkit to make it faster. All builds and manifest downloads are executed in parallel to speed up the process. This means that your terminal will be an absolute mess but depending on the amount of images can save minutes.

# Usage
In the directory that contains the git repos of the IB projects you want to build `./build.sh`. You can also specify a specific project to build. `./build.sh [project(optional)]`.

# Notes
The script is currently written to only build for a third-party repo1 container registry on line 20. This can be changed, the rest of that url is parsed from the hardening manifest. Feel free to modify the script to accept arguments for changing that url further.