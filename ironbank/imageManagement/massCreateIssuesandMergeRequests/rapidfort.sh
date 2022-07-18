#!/bin/bash

set -ex

GITLAB_PROJECTS_API_ENDPOINT="https://repo1.dso.mil/api/v4/projects"
PROJECT_IDS=( "7434" "7435" "7431" "7432" "7430" "7429" "7428" "7433" )
IMAGE_NAMES=( "aggregator-exe" "backend-exe" "frontrow" "iso-master-exe" "rfapi-exe" "rf-scan-exe" "rfpubsub-exe" "runner" )
REPO1_TOKEN="enter_your_token_here" # Add your Repo1 token. Reminder to NOT commit/push credentials.

function get_image_digests() {
    IMAGE_REGISTRY="public.ecr.aws"
    IMAGE_REPO="rapidfort"
    IMAGE_TAG="1.1.11-rfhardened" # Update as needed.
    
    echo "Collecting image digests for Rapidfort images..."

    for image in "${IMAGE_NAMES[@]}"
    do
        IMAGE_DIGEST=$(skopeo inspect docker://${IMAGE_REGISTRY}/${IMAGE_REPO}/${image}:${IMAGE_TAG} --no-tags | jq -r '.Digest')
        IMAGE_DIGESTS+=( ${IMAGE_DIGEST} )
        echo "Update ${image} to ${IMAGE_DIGEST}" >> rapidfort-image-digests.txt
    done

    cat rapidfort-image-digests.txt
    rm rapidfort-image-digests.txt
}

function create_issues() {
    for project_id in "${PROJECT_IDS[@]}"
    do
        curl --request POST --header "PRIVATE-TOKEN: ${REPO1_TOKEN}" "${GITLAB_PROJECTS_API_ENDPOINT}/${project_id}/issues?title=Upstream%20update"
    done 
}

function create_merge_requests() {
    SOURCE_BRANCH="" # This will be the name of the branch used to make the updates that will be merged into the Ironbank repo's "development" branch.
    TARGET_BRANCH="development"

    for project_id in "${PROJECT_IDS[@]}" 
    do
        curl --request POST --header "PRIVATE-TOKEN: ${REPO1_TOKEN}" "${GITLAB_PROJECTS_API_ENDPOINT}/${project_id}/merge_requests?source_branch=${SOURCE_BRANCH}&target_branch=${TARGET_BRANCH}&title=Upstream%20update"
    done 
}

function main() {
    get_image_digests
    create_issues
    create_merge_requests
}

main