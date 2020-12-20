#!/bin/bash
#
# build for production
#

set -o errexit
set -o pipefail
set -o nounset

jekyll build \
    --source docs

# LATER: remove MAX_ICONS
TARGET_DIR=_site MAX_ICONS=500 ./bin/noto-emoji.sh

