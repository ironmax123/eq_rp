#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="${SCRIPT_DIR}/build_output"

echo "==> Docker イメージをビルドします..."
docker build -t eq_rp_linux_builder "${SCRIPT_DIR}"

echo "==> Linux バイナリを取り出します... -> ${OUTPUT_DIR}"
mkdir -p "${OUTPUT_DIR}"
docker run --rm \
  -v "${OUTPUT_DIR}:/export" \
  eq_rp_linux_builder \
  bash -c "cp -r /app/build/linux/*/release/bundle/. /export/"

echo ""
echo "✅ ビルド完了！ 成果物: ${OUTPUT_DIR}"
ls -lh "${OUTPUT_DIR}"

echo "==> ZIPアーカイブを作成します..."
cd "${OUTPUT_DIR}"
zip -r ../linux_app.zip .
cd ..
echo "✅ ZIP作成完了！ 成果物: ${SCRIPT_DIR}/linux_app.zip"
