# Purpose
This script pushes all images build using the massBuildImages script in the adjacent folder. This is dependent on  the `-ib` suffix they are given, this isn't a great selector and may include false positives so be aware.

# Usage
Just run it: `./push.sh`.

# Notes
Like the build these pushes are also parallel so the terminal is gonna be a mess but it can save time.