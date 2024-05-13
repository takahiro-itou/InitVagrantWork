#!/bin/bash  -xue

repo_name=$1
mkdir_build=${2:-'yes'}

##  ビルド用ディレクトリを生成する

if [[ "X${mkdir_build}Y" != 'XnoY' ]] ; then

    build_base_dir="/ramdisk/Build/${repo_name}"
    mkdir -p  "${build_base_dir}"
    pushd     "${build_base_dir}"
    mkdir -p  \
        AutoMake/Debug-WithCppUnit      \
        AutoMake/Release-WithCppUnit    \
        AutoMake/Debug-NoCppUnit        \
        AutoMake/Release-NoCppUnit      \
        CMake/Debug-WithCppUnit         \
        CMake/Release-WithCppUnit       \
        CMake/Debug-NoCppUnit           \
        CMake/Release-NoCppUnit         \
    ;

fi

popd
