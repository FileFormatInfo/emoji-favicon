#!/bin/bash
#
# run locally
#

set -o errexit
set -o pipefail
set -o nounset

ICO_FILES=($(find docs/noto-emoji -name "*.ico"))
if [ "${#ICO_FILES[@]}" == "0" ];
then
    echo "INFO: rerunning download..."
    TARGET_DIR=docs MAX_ICONS=${MAX_ICONS:-100} ./bin/noto-emoji.sh
    echo "INFO: download complete"
fi

jekyll serve \
    --port 4000 \
    --source docs \
	--trace \
    --watch
