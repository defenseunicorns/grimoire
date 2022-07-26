# Purpose
Automate the creation of issues and merge requests via the GitLab API and gather sha256 sums from upstream images. This script gets a list of image digests from upstream Rapidfort images, appends them to `rapidfort-image-digests.txt`, prints the file to the terminal to help identify what sha256 hashes will be needed in the `hardening-manifest.yaml` in the Ironbank repo, and removes the file. It then creates issues and merge requests via the GitLab API.

# Usage
Provide your Repo1 personal access token as an argument when executing this script. You should be able to run this script from anywhere in your filesystem. The only modifications it makes to your local filesystem will be creating the `rapidfort-image-digests.txt` file and deleting it shortly after it prints the contents to the terminal.

# Notes
This script has a ton of hardcoded values that are specific to Rapidfort images at the moment. Ideally, this will be improved upon to be extensible and applicable to other repos without having to manually change a bunch of values.