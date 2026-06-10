#!/usr/bin/env bash
#
# Downloads the Contentstack regions registry from the official source and
# saves it to Sources/ContentstackUtils/Resources/regions.json.
#
# Run before building so SPM bundles the file into the module:
#   bash Scripts/download-regions.sh && swift build
#
# Also invoked manually to refresh the cached data:
#   bash Scripts/download-regions.sh
#
# Requires: curl (preferred) or wget as fallback

set -euo pipefail

URL="https://artifacts.contentstack.com/regions.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${SCRIPT_DIR}/../Sources/ContentstackUtils/Resources/regions.json"
DIR="$(dirname "$DEST")"

mkdir -p "$DIR"

data=""

# --- Attempt 1: curl (preferred) --------------------------------------------
if command -v curl &>/dev/null; then
    data=$(curl --silent --fail --location --max-time 30 "$URL") || data=""
fi

# --- Attempt 2: wget fallback -----------------------------------------------
if [[ -z "$data" ]] && command -v wget &>/dev/null; then
    data=$(wget --quiet --timeout=30 -O - "$URL") || data=""
fi

# --- Validate and write ------------------------------------------------------
if [[ -z "$data" ]]; then
    echo "contentstack/utils: Warning — could not download regions.json." >&2
    echo "  The SDK will attempt to download it at runtime on first use." >&2
    exit 0  # non-fatal: runtime fallback in Endpoint.swift handles it
fi

# Basic validation: must contain a "regions" key
if ! echo "$data" | grep -q '"regions"'; then
    echo "contentstack/utils: Warning — downloaded data is not valid regions.json." >&2
    exit 0
fi

echo "$data" > "$DEST"

region_count=$(echo "$data" | grep -o '"id"' | wc -l | tr -d ' ')
echo "contentstack/utils: regions.json downloaded (${region_count} regions)."
