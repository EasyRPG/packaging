#!/bin/bash

set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"&>/dev/null && pwd)
source ${SCRIPT_DIR}/_lib.sh

get_project $1

echo $(get_version)
