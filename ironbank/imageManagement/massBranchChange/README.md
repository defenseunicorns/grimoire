# Purpose
This script will checkout or create and checkout a specified branch (defaults to `development`) in all subfolders of the current directory. This can be useful when the upstream of a project in ironbank has updated and the IB projects need to have branches created.

# Usage
```
./branch.sh

-c, --create - When specified adds -b to the git checkout command to create the branch
```