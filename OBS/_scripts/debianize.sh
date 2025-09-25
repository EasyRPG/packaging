#!/bin/sh

set -e

DEBTAR="debian.tar.gz"

echo "Creating ${DEBTAR}:"

tar -cvzf "${DEBTAR}" debian
