#!/bin/bash  -xue

script_dir=$(readlink -f "$(dirname "$0")")

/bin/bash -xue "${script_dir}/setup-directory.sh"

pushd "${HOME}/Program"

##  Both HG and GIT Repository

for repo in  \
        DocViewTemplate     \
        HouseholdAccounts   \
        Score4              \
; do
    /bin/bash -xue  \
            "${script_dir}/helpers/_clone_repo_setup.sh" "${repo}"  \
    ||  echo  "SKIP: HG Repo ${repo} already exists"  1>&2
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
        ToyCode             \
; do
    /bin/bash -xue  \
            "${script_dir}/helpers/_clone_repo_setup.sh" '-' "${repo}"  \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2
done

popd
