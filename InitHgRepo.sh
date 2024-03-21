#!/bin/bash  -xue

script_dir=$(readlink -f "$(dirname "$0")")
target_dir=~hg

scp  ${script_dir}/helpers/_hg_init.sh  hgvagrant:${target_dir}/_hg_init.sh
ssh  hgvagrant  /bin/bash -xue ${target_dir}/_hg_init.sh
