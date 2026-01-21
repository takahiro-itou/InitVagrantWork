#!/bin/bash

set  -ue

script_dir=$(readlink -f "$(dirname "$0")")

/bin/bash -xue "${script_dir}/setup-directory.sh"

pushd "${HOME}/Program"

##----------------------------------------------------------------
##    Both HG and GIT Repository

for entry in  \
        $(cat "${script_dir}/clone.d/BothHgGit")  \
; do
    trg_dir=$(dirname "${entry}")
    repo=$(basename "${entry}")

    pushd  "${trg_dir}"  1>&2

    /bin/bash -xue  \
        "${script_dir}/.helpers/clone-repo-setup.sh" "${repo}"  \
    ||  echo  "SKIP: HG Repo ${repo} already exists"  1>&2

    /bin/bash -xue  \
        "${script_dir}/.helpers/make-build-dirs.sh" "${repo}"  \
    ;

    popd  1>&2
done


##----------------------------------------------------------------
##    Only GIT Repository

for entry in  \
        $(cat "${script_dir}/clone.d/Defaults")  \
; do
    trg_dir=$(dirname "${entry}")
    repo=$(basename "${entry}")

    hg_repo_name='-'
    git_repo_name="${repo}"
    git_repo_grp=''
    mkdir_build='yes'
    gitlab_url_base='git@gitlab.com:takahiro-itou'

    pushd  "${trg_dir}"  1>&2

    /bin/bash -xue  \
    "${script_dir}/.helpers/clone-repo-setup.sh"    \
        "${hg_repo_name}"       \
        "${git_repo_name}"      \
        "${git_repo_grp}"       \
        "${mkdir_build}"        \
        "${gitlab_url_base}"    \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2

    /bin/bash -xue  \
    "${script_dir}/.helpers/make-build-dirs.sh"     \
        "${repo}"               \
        "${mkdir_build}"        \
    ;

    popd  1>&2
done


##----------------------------------------------------------------
##    HgGit Project

for entry in  \
        $(cat "${script_dir}/clone.d/HgGit")  \
; do
    trg_dir=$(dirname "${entry}")
    repo=$(basename "${entry}")

    hg_repo_name='-'
    git_repo_name="${repo}"
    git_repo_grp=''
    mkdir_build='no'
    gitlab_url_base='git@gitlab.com:takahiro-itou-hggit'

    pushd  "${trg_dir}"  1>&2

    /bin/bash -xue  \
    "${script_dir}/.helpers/clone-repo-setup.sh"    \
        "${hg_repo_name}"       \
        "${git_repo_name}"      \
        "${git_repo_grp}"       \
        "${mkdir_build}"        \
        "${gitlab_url_base}"    \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2

    /bin/bash -xue  \
    "${script_dir}/.helpers/make-build-dirs.sh"     \
        "${repo}"               \
        "${mkdir_build}"        \
    ;

    popd  1>&2
done


##----------------------------------------------------------------
##    Template Projects

mkdir -p Template
pushd    Template

for entry in  \
        $(cat "${script_dir}/clone.d/Template")  \
; do
    trg_dir=$(dirname "${entry}")
    repo=$(basename "${entry}")

    pushd  "${trg_dir}"  1>&2

    /bin/bash -xue  \
        "${script_dir}/.helpers/clone-repo-setup.sh"  \
        '-'  "${repo}"  'templates'  'yes'            \
        'git@gitlab.com:takahiro-itou-templates'      \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2

    /bin/bash -xue  \
        "${script_dir}/.helpers/make-build-dirs.sh" "${repo}"  \
    ;

    popd  1>&2
done

popd


##----------------------------------------------------------------
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


##----------------------------------------------------------------
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


##----------------------------------------------------------------
##  Vagrant Projects

vagrant_url_base='git@gitlab.com:takahiro-itou-vagrant'

mkdir -p Vagrant
pushd    Vagrant

for repo in  \
        $(cat "${script_dir}/clone.d/Vagrant")  \
; do
    hg_repo_name='-'
    git_repo_name="${repo}"
    git_repo_grp=''
    mkdir_build='no'
    gitlab_url_base='git@gitlab.com:takahiro-itou'

    if ! /bin/bash -xue  \
            "${script_dir}/.helpers/clone-repo-setup.sh"    \
                "${hg_repo_name}"       \
                "${git_repo_name}"      \
                "${git_repo_grp}"       \
                "${mkdir_build}"        \
                "${gitlab_url_base}"    \
    ; then
        echo  "SKIP: Git Repo ${repo} already exists"  1>&2
        continue
    fi
    pushd  "${repo}"
    git remote add bit "${vagrant_url_base}/${repo##vagrant-}.git"
    popd
done

popd


##----------------------------------------------------------------
##  Blog/Pages Projects

mkdir -p Pages
pushd    Pages

for repo in  \
        $(cat "${script_dir}/clone.d/Pages")  \
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


##----------------------------------------------------------------
##  Installer Projects

mkdir -p Installer
pushd    Installer

for repo in  \
        $(cat "${script_dir}/clone.d/Installer")  \
; do
    hg_repo_name='-'
    git_repo_name="${repo}"
    git_repo_grp=''
    mkdir_build='no'
    gitlab_url_base='git@gitlab.com:takahiro-itou'

    /bin/bash -xue  \
    "${script_dir}/.helpers/clone-repo-setup.sh"    \
        "${hg_repo_name}"       \
        "${git_repo_name}"      \
        "${git_repo_grp}"       \
        "${mkdir_build}"        \
        "${gitlab_url_base}"    \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2
done

popd


##----------------------------------------------------------------
##  WebService Projects

mkdir -p WebService
pushd    WebService

for repo in  \
        $(cat "${script_dir}/clone.d/WebService")  \
; do
    hg_repo_name='-'
    git_repo_name="${repo}"
    git_repo_grp=''
    mkdir_build='no'
    gitlab_url_base='git@gitlab.com:takahiro-itou-webservice'

    /bin/bash -xue  \
    "${script_dir}/.helpers/clone-repo-setup.sh"    \
        "${hg_repo_name}"       \
        "${git_repo_name}"      \
        "${git_repo_grp}"       \
        "${mkdir_build}"        \
        "${gitlab_url_base}"    \
    ||  echo  "SKIP: Git Repo ${repo} already exists"  1>&2
done

popd


##----------------------------------------------------------------
##  Done

popd
