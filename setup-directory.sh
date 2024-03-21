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
popd
