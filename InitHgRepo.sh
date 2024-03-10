#!/bin/bash  -xue

script_dir=$(readlink -f "$(dirname "$0")")
ssh  hgvagrant  /bin/bash  -xue  ${script_dir}/_hg_init.sh
