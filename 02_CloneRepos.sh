#!/bin/bash  -xue

script_dir=$(readlink -f "$(dirname "$0")")

/bin/bash -xue "${script_dir}/setup-directory.sh"

pushd "${HOME}/Program"

##  Both HG and GIT Repository

for repo in  \
        DocViewTemplate     \
        HouseholdAccounts   \
        Score4              \
        Settings            \
; do
    /bin/bash -xue  \
        "${script_dir}/.helpers/clone-repo-setup.sh" "${repo}"  \
    ||  echo  "SKIP: HG Repo ${repo} already exists"  1>&2

    /bin/bash -xue  \
        "${script_dir}/.helpers/make-build-dirs.sh" "${repo}"  \
    ;
done

##  Only GIT Repository

for repo in  \
        CI-Sample1          \
        CalcOdsWriter       \
        Csv2ColorOds        \
        Hashes              \
        InitCMake           \
        InitM4              \
        PedometerCalc       \
        Picross             \
        ToyCode             \
        WpfTest             \
; do
    /bin/bash -xue  \
        "${script_dir}/.helpers/clone-repo-setup.sh" '-' "${repo}"  \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2

    /bin/bash -xue  \
        "${script_dir}/.helpers/make-build-dirs.sh" "${repo}"  \
    ;
done

##  Template Projects

mkdir -p Template
pushd    Template

for repo in  \
        CppUnitDriver       \
        DocViewTemplate     \
        FrontEndTemplate    \
        LibraryTemplate     \
        GraphicsTemplate    \
; do
    /bin/bash -xue  \
        "${script_dir}/.helpers/clone-repo-setup.sh"  \
        '-'  "${repo}"  'templates'  'yes'            \
        'git@gitlab.com:takahiro-itou-templates'      \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2

    /bin/bash -xue  \
        "${script_dir}/.helpers/make-build-dirs.sh" "${repo}"  \
    ;
done

popd

##  DTV Projects

mkdir -p DTV
pushd    DTV

for repo in  \
        TsSplitterView  \
; do
    /bin/bash -xue  \
        "${script_dir}/.helpers/clone-repo-setup.sh" '-' "${repo}"  \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2
done

for repo in  \
        TsSplitter  \
; do
    /bin/bash -xue  \
        "${script_dir}/.helpers/make-build-dirs.sh" "${repo}"  \
    ;
done

popd

##  GBA Projects

mkdir -p GBA
pushd    GBA

for repo in  \
        DisAsm          \
; do
    /bin/bash -xue  \
        "${script_dir}/.helpers/clone-repo-setup.sh" '-' "${repo}"  \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2

    /bin/bash -xue  \
        "${script_dir}/.helpers/make-build-dirs.sh" "${repo}"  \
    ;
done

for repo in  \
        DebuggerView    \
; do
    /bin/bash -xue  \
        "${script_dir}/.helpers/clone-repo-setup.sh" '-' "${repo}"  \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2
done

for repo in  \
        GbDebugger      \
; do
    /bin/bash -xue  \
        "${script_dir}/.helpers/make-build-dirs.sh" "${repo}"  \
    ;
done

popd

##  Vagrant Projects

vagrant_url_base='git@gitlab.com:takahiro-itou-vagrant'

mkdir -p Vagrant
pushd    Vagrant

for repo in  \
        vagrant-ubuntu-develop  \
        vagrant-ubuntu-docker  \
        vagrant-box-rocky-develop  \
        vagrant-box-rocky-pbspro   \
        vagrant-rocky-develop  \
        vagrant-rocky-pbspro   \
; do
    if ! /bin/bash -xue  \
            "${script_dir}/.helpers/clone-repo-setup.sh"    \
            '-' "${repo}" 'no'  \
    ; then
        echo  "SKIP: Git Repo ${repo} already exists"  1>&2
        continue
    fi
    pushd  "${repo}"
    git remote add bit "${vagrant_url_base}/${repo##vagrant-}.git"
    popd
done

popd

##  Blog/Pages Projects

mkdir -p Pages
pushd    Pages

for repo in  \
        BlogProjects  GithubPages-Test  \
; do
    /bin/bash -xue  \
        "${script_dir}/.helpers/clone-repo-setup.sh" '-' "${repo}"  \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2
done

for repo in  \
        PagesTemplate  \
; do
    /bin/bash -xue  \
        "${script_dir}/.helpers/clone-repo-setup.sh"  \
        '-'  "${repo}"  'templates'  'no'             \
        'git@gitlab.com:takahiro-itou-templates'      \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2
done


popd

##  Done

popd
