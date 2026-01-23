#!/bin/bash
set -e

# Directory where you store data
DATA_DIR="data"
mkdir -p "$DATA_DIR"

BASE_URL="https://download.geofabrik.de/asia"
MD5_URL="$BASE_URL/philippines-latest.osm.pbf.md5"
PBF_URL="$BASE_URL/philippines-latest.osm.pbf"

LOCAL_MD5_FILE="$DATA_DIR/philippines-latest.osm.pbf.md5"
LOCAL_PBF_FILE="$DATA_DIR/philippines-latest.osm.pbf"

echo "[INFO] Checking for updated OSM data..."

# Download remote md5
curl -s -L "$MD5_URL" -o "$DATA_DIR/remote.md5"

# Compare with local md5
if [[ -f "$LOCAL_MD5_FILE" ]]; then
    if cmp -s "$DATA_DIR/remote.md5" "$LOCAL_MD5_FILE"; then
        echo "[INFO] No update detected. Data is current."
        rm "$DATA_DIR/remote.md5"
        exit 0
    fi
fi

echo "[INFO] Update detected. Downloading new .osm.pbf..."

# Download the new PBF
curl -L "$PBF_URL" -o "$LOCAL_PBF_FILE"

# Move new md5 into place
mv "$DATA_DIR/remote.md5" "$LOCAL_MD5_FILE"

echo "[INFO] Update complete."
