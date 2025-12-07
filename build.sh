#!/bin/bash

set -e

echo "Cleaning previous builds..."

rm -rf build dist __pycache__ *.pyc
rm -rf scripts/__pycache__ scripts/*/__pycache__

echo "Clean complete"

echo "Compiling with PyInstaller..."

if pyinstaller --onefile -n marble-shell \
  --add-data "colors.json:." \
  --add-data "theme:theme" \
  --add-data "tweaks:tweaks" \
  --hidden-import scripts \
  --hidden-import scripts.config \
  --hidden-import scripts.utils.color_converter.color_converter_impl \
  --hidden-import scripts.utils.theme.theme \
  --hidden-import scripts.utils.is_photo \
  --clean install.py; then
  echo "Compilation successful"
else
    echo "Compilation failed!"
    exit 1
fi