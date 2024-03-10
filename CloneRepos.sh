#!/bin/bash  -xue

script_dir=$(readlink -f "$(dirname "$0")")

pushd "${HOME}"
if [[ ! -e Program ]] ; then
    if [[ -d '/ext-hdd/data' ]] ; then
        mkdir -p "/ext-hdd/data/Program"
        ln -s    "/ext-hdd/data/Program"
    else
        mkdir -p Program
    fi
fi
pushd "${HOME}/Program"

##  Both HG and GIT Repository

for repo in  \
        DocViewTemplate     \
        HouseholdAccounts   \
; do
    /bin/bash -xue "${script_dir}/_clone_repo_setup.sh" "${repo}"
done

##  Only GIT Repository

for repo in  \
        CI-Sample1          \
        CalcOdsWriter       \
        Csv2ColorOds        \
        InitCMake           \
        InitM4              \
        PedometerCalc       \
        Picross             \
        Score4              \
        ToyCode             \
; do
    /bin/bash -xue "${script_dir}/_clone_repo_setup.sh" '-' "${repo}"
done

popd
