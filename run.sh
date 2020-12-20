#!/bin/bash
#
# run locally
#

set -o errexit
set -o pipefail
set -o nounset

jekyll serve \
    --port 4000 \
    --source docs \
	--trace \
    --watch
