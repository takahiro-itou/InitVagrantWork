#!/bin/bash  -xue

script_dir=$(readlink -f "$(dirname "$0")")
target_dir=~hg

scp  ${script_dir}/.helpers/hg-init.sh  hgvagrant:${target_dir}/hg-init.sh
scp  ${script_dir}/.helpers/hggrpos.ls  hgvagrant:${target_dir}/hgrepos.ls
ssh  hgvagrant  /bin/bash -xue ${target_dir}/hg-init.sh
