#!/bin/bash
set -e

# Inherit Miui/Leica Camera
echo "Cloning MiuiCamera..."
git clone https://github.com/Eida-at-22-00/vendor_xiaomi_miuicamera-sweet vendor/xiaomi/miuicamera-sweet/

echo "Pulling LFS files..."
cd vendor/xiaomi/miuicamera-sweet/ && git lfs pull && cd ../../..

echo "Cloning Signed-keys"
git clone https://github.com/Evolution-X-djl/vendor_lineage-priv_keys vendor/lineage-priv/keys/

echo "All operations completed successfully!"
