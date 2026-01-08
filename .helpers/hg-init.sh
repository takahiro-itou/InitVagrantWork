#!/bin/bash

script_dir=$(readlink -f "$(dirname "$0")")

pushd  /home/hg

if [[ ! -e repos ]] ; then
    if [[ -d '/ext-hdd/data' ]] ; then
        mkdir -p '/ext-hdd/data/hg/repos'
        ln -s    '/ext-hdd/data/hg/repos'
    else
        mkdir -p 'repos'
    fi
fi

popd

pushd  /home/hg/repos

for repo in  \
        $(cat "${script_dir}/hgrepos.ls")  \
; do
    if [[ -d "${repo}/.hg" ]] ; then
        continue
    fi
    hg init "${repo}"
done

popd
