#!/bin/bash  -xue

cache_root_dir="/ramdisk/tmp.cache"
cache_dir="${cache_root_dir}/$(id -u)"

mkdir -p "${cache_root_dir}"
chmod 1777 "${cache_root_dir}"

mkdir -p "${cache_dir}"

pushd "${HOME}"
if [[ ! -f .agent ]] ; then
    ln -s "${cache_dir}/.agent"
fi
popd

