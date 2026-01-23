#!/bin/bash
set -e

BASE_URL="https://download.geofabrik.de/asia"
MD5_URL="$BASE_URL/philippines-latest.osm.pbf.md5"
PBF_URL="$BASE_URL/philippines-latest.osm.pbf"

echo "[INFO] Checking for updated OSM data..."

# Download remote md5
curl -s -L "$MD5_URL" -o "remote.md5"

# Find existing local PBF file (dated or latest)
LOCAL_PBF_FILE=$(ls philippines-*.osm.pbf 2>/dev/null | head -n 1)

# If we have a local file, check if it matches the remote checksum
if [[ -n "$LOCAL_PBF_FILE" ]]; then
    echo "[INFO] Found local file: $LOCAL_PBF_FILE"
    # Calculate local file's MD5
    LOCAL_MD5=$(md5sum "$LOCAL_PBF_FILE" | cut -d' ' -f1)
    # Get remote MD5 (first field)
    REMOTE_MD5=$(cut -d' ' -f1 "remote.md5")
    
    if [[ "$LOCAL_MD5" == "$REMOTE_MD5" ]]; then
        echo "[INFO] No update detected. Data is current."
        rm "remote.md5"
        exit 0
    fi
    echo "[INFO] Update detected. Old file will be replaced."
    rm "$LOCAL_PBF_FILE"
fi

echo "[INFO] Downloading new .osm.pbf..."

# Download the new PBF (it will have the dated filename from the redirect)
curl -L -O -J "$PBF_URL"

# Save the MD5 checksum file
NEW_PBF_FILE=$(ls philippines-*.osm.pbf 2>/dev/null | head -n 1)
mv "remote.md5" "${NEW_PBF_FILE}.md5"

echo "[INFO] Update complete: $NEW_PBF_FILE"
