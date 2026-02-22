#!/bin/bash
set -e

ZMK_APP="/workspaces/zmk-config/zmk/app"
ZMK_CONFIG="/workspaces/zmk-config/config"
BUILD_DIR="/workspaces/zmk-config/build"

build_side() {
    local side=$1
    shift
    local extra_args=("$@")

    echo "Building ${side}..."
    west build -d "${BUILD_DIR}/${side}" -s "${ZMK_APP}" -p -b xiao_ble -- \
        -DSHIELD="${side} rgbled_adapter" \
        -DZMK_CONFIG="${ZMK_CONFIG}" \
        "${extra_args[@]}"

    echo "Firmware: ${BUILD_DIR}/${side}/zephyr/zmk.uf2"
}

case "${1:-all}" in
    left)
        build_side forager_left -DSNIPPET=studio-rpc-usb-uart
        ;;
    right)
        build_side forager_right
        ;;
    all)
        build_side forager_left -DSNIPPET=studio-rpc-usb-uart
        build_side forager_right
        ;;
    *)
        echo "Usage: $0 [left|right|all]"
        exit 1
        ;;
esac

echo "Done!"
