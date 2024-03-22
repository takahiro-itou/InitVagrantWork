#!/bin/bash  -xue

hg_repo_name=$1
git_repo_name=${2-'-'}
git_repo_grp=${3:-''}

gitlab_url_base='git@gitlab.com:takahiro-itou'
github_url_base='git@github.com:takahiro-itou'
bitbucket_url_base="git@bitbucket.org:takahiro_itou"

if [[ "X${hg_repo_name}Y" != 'X-Y' ]] ; then
    repo_name="${hg_repo_name}"
    if [[ -d "${repo_name}" ]] ; then
        exit  2
    fi

    hg clone "ssh://hgvagrant/repos/${repo_name}"
    git init "${repo_name}"
    pushd    "${repo_name}"
    git remote add origin "${gitlab_url_base}/${repo_name}.git"
    popd
elif [[ "X${git_repo_name}Y" != 'X-Y' ]] ; then
    repo_name="${git_repo_name}"
    if [[ -d "${repo_name}" ]] ; then
        exit  2
    fi

    git_url="${gitlab_url_base}/${repo_name}.git"
    git clone --recursive "${git_url}"
else
    echo "FATAL : No repository name was given!"  1>&2
    exit  2
fi

if [[ "X${git_repo_name}Y" = 'X-Y' ]] ; then
    git_repo_name="${hg_repo_name}"
fi

pushd "${repo_name}"
git remote add github "${github_url_base}/${repo_name}.git"
# git remote add bit "${bitbucket_url_base}/${repo_name}.git"
popd

build_base_dir="/ramdisk/Build/${repo_name}"
mkdir -p  "${build_base_dir}"
pushd     "${build_base_dir}"
mkdir -p  \
      AutoMake/Debug-WithCppUnit    \
      AutoMake/Release-WithCppUnit  \
      AutoMake/Debug-NoCppUnit      \
      AutoMake/Releaes-NoCppUnit    \
      CMake/Debug-WithCppUnit       \
      CMake/Release-WithCppUnit     \
      CMake/Debug-NoCppUnit         \
      CMake/Release-NoCppUnit       \
      ;
popd
