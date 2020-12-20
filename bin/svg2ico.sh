#!/usr/bin/env bash
#
# convert an svg to an ico with rsvg and graphicsmagic
#

set -o errexit
set -o pipefail
set -o nounset

IN_FILE=${1:-BAD}
OUT_FILE=${2:-BAD}
if [ "${IN_FILE}" = "BAD"  ] || [ ${OUT_FILE:-BAD} == "BAD" ]; then
	echo "usage: svg2ico.sh IN_FILE OUT_FILE"
	echo "       IN_FILE is SVG file to convert"
	echo "       OUT_FILE is icon file to create"
	exit 1
fi

TMP_DIR=$(mktemp -d)
SIZES=(16 32 64 128)

PNG_FILES=""
for SIZE in "${SIZES[@]}"
do
    #echo "INFO: creating PNG in ${SIZE}"
	rsvg-convert \
		--format=png \
		--keep-aspect-ratio \
		--height=${SIZE} \
		--output=${TMP_DIR}/svg2ico-${SIZE}.png \
		--width=${SIZE} \
		"${IN_FILE}"

	PNG_FILES="${PNG_FILES} ${TMP_DIR}/svg2ico-${SIZE}.png"
done

convert ${PNG_FILES} "${OUT_FILE}"
