#!/usr/bin/env bash
#
# download and convert google noto emoji
#

set -o errexit
set -o pipefail
set -o nounset

echo "INFO: starting at $(date -u +%Y-%m-%dT%H:%M:%SZ)"

# LATER: convert to args
REPO_URL=https://github.com/googlefonts/noto-emoji
SLUG=noto-emoji
REPO_SUBDIR=svg

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"
TMP_DIR=$(realpath "${SCRIPT_HOME}/../tmp")

TARGET_DIR=${TARGET_DIR:-_site}
DEST_DIR=$(realpath "${SCRIPT_HOME}/../${TARGET_DIR}/${SLUG}")

if [ -d "${TMP_DIR}" ]; then
    echo "WARNING: re-using existing tmp directory ${TMP_DIR}"
else
    echo "INFO: creating tmp directory ${TMP_DIR}"
    mkdir -p "${TMP_DIR}"
fi

if [ ! -d "${DEST_DIR}" ]; then
    echo "INFO: creating output directory ${DEST_DIR}"
    mkdir -p "${DEST_DIR}"
fi

REPO_DIR="${TMP_DIR}/${SLUG}"
if [ ! -d "${REPO_DIR}" ]; then
    echo "INFO: cloning a fresh copy"
    git clone --depth 1 ${REPO_URL}.git ${TMP_DIR}/${SLUG}
else
    echo "INFO: using existing clone"
fi

INDEX_FILE="${DEST_DIR}/index.json"

cat <<EOT >"${INDEX_FILE}"
{
    "data": [
EOT


SVG_FILES=($(find ${TMP_DIR}/${SLUG}/${REPO_SUBDIR} -name "*.svg"))
echo "INFO: found ${#SVG_FILES[@]} SVGs"

if [ "${MAX_ICONS:-BAD}" != "BAD" ]; then
    SVG_FILES=("${SVG_FILES[@]:0:${MAX_ICONS}}")
    echo "INFO: truncating to ${MAX_ICONS}"
fi

echo -n "INFO processing..."
for SVG_FILE in "${SVG_FILES[@]}"
do
    echo "DEBUG: processing ${SVG_FILE}..."
    ICO_FILE="${DEST_DIR}/$(basename "${SVG_FILE}" ".svg").ico"

    if [ ! -f "${ICO_FILE}" ]; then
        echo -n "."
        ${SCRIPT_HOME}/svg2ico.sh "${SVG_FILE}" "${ICO_FILE}"
    fi

    if [ "${SVG_FILE}" != "${SVG_FILES[0]}" ]; then
        echo "," >>"${INDEX_FILE}"
    fi

    cat <<EOT >>"${INDEX_FILE}"
    {
        "source": "${REPO_URL}/${REPO_SUBDIR}/$(basename "${SVG_FILE}")",
        "icon": "$(basename ${ICO_FILE})",
        "search": "$(basename "${SVG_FILE}" ".svg")"
    }
EOT
done
echo ""

cat <<EOT >>"${INDEX_FILE}"
    ],
    "commit": "$(cd "${REPO_DIR}" && git rev-parse HEAD)",
    "count": ${#SVG_FILES[@]},
    "lastchecked": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "lastmodified": "$(cd "${REPO_DIR}" && git log -1 --format=%ad --date=format:"%Y-%m-%dT%H:%M:%SZ")",
    "repo": "${REPO_URL}"
}
EOT

echo "INFO: complete at $(date -u +%Y-%m-%dT%H:%M:%SZ)"
