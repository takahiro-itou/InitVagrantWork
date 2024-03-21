#!/bin/bash  -xue

script_dir=$(readlink -f "$(dirname "$0")")

/bin/bash -xue "${script_dir}/setup-agent.sh"

/bin/bash -xue "${script_dir}/setup-directory.sh"
