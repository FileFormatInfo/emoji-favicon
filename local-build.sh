#!/bin/bash
#
# build for local testing
#

set -o errexit
set -o pipefail
set -o nounset

TARGET_DIR=docs MAX_ICONS=200 ./bin/noto-emoji.sh
