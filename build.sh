#!/usr/bin/env bash
#
# build for production
#

set -o errexit
set -o pipefail
set -o nounset

mkdir -p docs/_data

jq \
    --arg COMMIT "$(git rev-parse HEAD)" \
    --arg JEKYLL_VERSION "$(jekyll --version | awk '{print $NF}')" \
    --null-input \
    '{"commit":$COMMIT,"jekyll_version":$JEKYLL_VERSION}' \
    >docs/_data/build.json

jekyll build \
    --source docs

# LATER: remove MAX_ICONS
TARGET_DIR=_site MAX_ICONS=500 ./bin/noto-emoji.sh

