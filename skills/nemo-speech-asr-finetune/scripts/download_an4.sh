#!/usr/bin/env bash
# Download and extract the AN4 dataset into data/an4/
set -euo pipefail

DATA_DIR="$(cd "$(dirname "$0")/.." && pwd)/data/an4"
mkdir -p "$DATA_DIR"

echo "Downloading AN4 dataset..."
wget -q --show-progress -O "$DATA_DIR/an4_sphere.tar.gz" \
    https://dldata-public.s3.us-east-2.amazonaws.com/an4_sphere.tar.gz

echo "Extracting..."
tar -xzf "$DATA_DIR/an4_sphere.tar.gz" -C "$DATA_DIR"
echo "Done. Dataset at: $DATA_DIR/an4/"
