#!/bin/bash
set -e

cd /workspaces/zmk-config

if [ ! -f .west/config ]; then
    echo "Initializing west workspace..."
    west init -l config
fi

echo "Updating west modules (this may take a while on first run)..."
west update

echo "Exporting Zephyr CMake package..."
west zephyr-export

echo "Installing pre-commit..."
uv tool install pre-commit --with pre-commit-uv --force
pre-commit install --install-hooks

echo "Workspace ready! Run .devcontainer/build.sh to build firmware."
