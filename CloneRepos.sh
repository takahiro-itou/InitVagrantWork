#!/bin/bash  -xue

script_dir=$(readlink -f "$(dirname "$0")")

##  Both HG and GIT Repository

for repo in  \
        DocViewTemplate     \
; do
    /bin/bash -xue "${script_dir}/_clone_repo_setup.sh" "${repo}"
done

##  Only GIT Repository

for repo in  \
        CI-Sample1          \
; do
    /bin/bash -xue "${script_dir}/_clone_repo_setup.sh" '-' "${repo}"
done
