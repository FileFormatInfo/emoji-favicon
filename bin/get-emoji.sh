#!/usr/bin/env bash
#
# download and convert google noto emoji
#

set -o errexit
set -o pipefail
set -o nounset

echo "INFO: starting at $(date -u +%Y-%m-%dT%H:%M:%SZ)"

EMOJI=${1:-BAD}
if [ "${EMOJI}" = "BAD"  ];
then
	echo "USAGE: get-emoji.sh EMOJI"
	echo "       EMOJI is one of the .env files with the variables for a set of emoji"
	exit 1
fi

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"
ENVFILE="${SCRIPT_HOME}/$(basename "${EMOJI}" .env).env"
if [ ! -f "${ENVFILE}" ]
then
    echo "ERROR: no .env file '${ENVFILE}'!"
    exit 1
fi

source "${ENVFILE}"

#
# REPO_DIR should only be needed if a repo is used more than once
#
if [ "${REPO_DIR:-BAD}" == "BAD" ]; then
    REPO_DIR=$(basename "${REPO_URL}")
fi

TMP_DIR=$(realpath "${SCRIPT_HOME}/../tmp")

TARGET_DIR=${TARGET_DIR:-_site}
DEST_DIR=$(realpath "${SCRIPT_HOME}/../${TARGET_DIR}/${REPO_DIR}")

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

LOCAL_DIR="${TMP_DIR}/${REPO_DIR}"
if [ ! -d "${LOCAL_DIR}" ]; then
    echo "INFO: cloning a fresh copy"
    git clone --depth 1 --branch "${REPO_BRANCH}" "${REPO_URL}.git" "${LOCAL_DIR}"
else
    echo "INFO: using existing clone"
fi

INDEX_FILE="${DEST_DIR}/index.json"

cat <<EOT >"${INDEX_FILE}"
{
    "data": [
EOT


SVG_FILES=($(find "${LOCAL_DIR}/${REPO_SUBDIR}" -name "*.svg" | sort))
echo "INFO: found ${#SVG_FILES[@]} SVGs"

if [ "${MAX_ICONS:-BAD}" != "BAD" ]; then
    SVG_FILES=("${SVG_FILES[@]:0:${MAX_ICONS}}")
    echo "INFO: truncating to ${MAX_ICONS}"
fi

echo -n "INFO processing..."
for SVG_FILE in "${SVG_FILES[@]}"
do
    #echo "DEBUG: processing ${SVG_FILE}..."
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
            "source": "${REPO_URL}/blob/${REPO_BRANCH}/${REPO_SUBDIR}/$(basename "${SVG_FILE}")",
            "icon": "$(basename ${ICO_FILE})",
            "search": "$(basename "${SVG_FILE}" ".svg" | sed -E -e 's/emoji_u|_/ /g')"
        }
EOT
done
echo ""

cat <<EOT >>"${INDEX_FILE}"
    ],
    "commit": "$(cd "${LOCAL_DIR}" && git rev-parse HEAD)",
    "count": ${#SVG_FILES[@]},
    "lastchecked": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "lastmodified": "$(cd "${LOCAL_DIR}" && git log -1 --format=%ad --date=format:"%Y-%m-%dT%H:%M:%SZ")",
    "license_text": "${LICENSE_TEXT}",
    "license_url": "${LICENSE_URL}",
    "repo_url": "${REPO_URL}"
}
EOT

echo "INFO: complete at $(date -u +%Y-%m-%dT%H:%M:%SZ)"
