#!/bin/bash
#
# run locally
#

set -o errexit
set -o pipefail
set -o nounset

ICO_FILES=($(find docs/noto-flags -name "*.ico"))
if [ "${#ICO_FILES[@]}" == "0" ];
then
    echo "INFO: refetching emoji..."
    TARGET_DIR=docs MAX_ICONS=${MAX_ICONS:-100} ./bin/get-emoji.sh noto-flags
    echo "INFO: fetch complete"
fi

ICO_FILES=($(find docs/twemoji -name "*.ico"))
if [ "${#ICO_FILES[@]}" == "0" ];
then
    echo "INFO: refetching emoji..."
    TARGET_DIR=docs MAX_ICONS=${MAX_ICONS:-100} ./bin/get-emoji.sh twemoji
    echo "INFO: fetch complete"
fi

jekyll serve \
    --port 4000 \
    --source docs \
	--trace \
    --watch
