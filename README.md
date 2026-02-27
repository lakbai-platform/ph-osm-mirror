# ph osm mirror

> [!WARNING]
> **ARCHIVED**: This project is no longer maintained. The [lakbai-web](https://github.com/lakbai-platform/lakbai-web) project now uses MapTiler CN which already has OSRM built-in, making separate OSM data downloads unnecessary for running the application.

A simple Bash script that mirrors the latest OpenStreetMap (OSM) data for the Philippines from Geofabrik. The script uses MD5 checksum comparison to avoid unnecessary downloads, only fetching the `.osm.pbf` file when an update is detected.

Data source: https://download.geofabrik.de/asia/philippines.html

## Features

- Avoids unnecessary downloads using MD5 checksum comparison
- Safe to run repeatedly
- Suitable for cron jobs and local OSM pipelines
- No external dependencies beyond common Unix tools

## Requirements

The following tools must be available in your environment:

- `bash`
- `curl`
- `cmp`

### Supported Platforms

- Linux
- macOS
- Windows via Git Bash or WSL

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/osm-phil-files.git
cd osm-phil-files
```

### 2. Make the Script Executable

```bash
chmod +x update_ph_osm.sh
```

### 3. Run the Script

```bash
./update_ph_osm.sh
```

The script will download the latest Philippines OSM data file (e.g., `philippines-latest.osm.pbf`) and its MD5 checksum directly to the current directory, right alongside the script itself.
