# Forager ZMK Config

ZMK firmware configuration for the [Forager](https://github.com/carrefinho/forager), a 34-key split keyboard using Seeed Studio XIAO BLE (nRF52840) controllers.

## Firmware files

CI produces firmware artifacts for two configurations. Download the `.uf2` files from the [latest GitHub Actions run](https://github.com/brandjas/zmk-config/actions).

### Standalone mode (left-as-central)

The left half acts as the BLE central and USB host. The right half is a peripheral.

| Artifact | Flash onto | Role |
|----------|-----------|------|
| `xiao_ble-forager_left_rgbled_adapter-zmk` | Left half | Central, keymap processing, ZMK Studio |
| `xiao_ble-forager_right_rgbled_adapter-zmk` | Right half | Peripheral |

### Dongle mode (dedicated central)

A third XIAO BLE serves as a USB dongle. Both keyboard halves become peripherals.

| Artifact | Flash onto | Role |
|----------|-----------|------|
| `forager_dongle` | USB dongle (third XIAO BLE) | Central, keymap processing, ZMK Studio |
| `forager_left_dongle` | Left half | Peripheral (central role disabled) |
| `xiao_ble-forager_right_rgbled_adapter-zmk` | Right half | Peripheral |

The right half firmware is the same in both modes.

### Flashing

1. Connect the XIAO BLE via USB
2. Double-tap the reset button to enter UF2 bootloader (drive appears as `XIAO-SENSE`)
3. Copy the `.uf2` file to the drive

## Building locally

Requires the [dev container](.devcontainer/) or a configured ZMK/Zephyr toolchain.

```bash
# Build both halves (standalone mode)
.devcontainer/build.sh

# Build a single side
.devcontainer/build.sh left
.devcontainer/build.sh right
```

Output: `build/{left,right}/zephyr/zmk.uf2`

For the dongle:

```bash
west build -d build/dongle -s zmk/app -p -b xiao_ble -- \
    -DSHIELD="forager_dongle rgbled_adapter" \
    -DZMK_CONFIG="$(pwd)/config" \
    -DSNIPPET=studio-rpc-usb-uart
```

## Keymap

The keymap (`config/forager.keymap`) has 8 layers:

| Layer | Name | Purpose |
|-------|------|---------|
| 0 | CMK | Colemak base (Windows) |
| 1 | MAC | Colemak base (macOS) |
| 2 | SYM | Symbols |
| 3 | NUM | Numbers + operators |
| 4 | NAV | Arrow keys, navigation |
| 5 | FUN | F-keys, media, BT profiles, OS mode switch |
| 6 | DAN | Danger: BT clear, reset, bootloader, output toggle |
| 7 | LCK | Lock: all `&none`, escape via 4-key combo only |

Edit the keymap with [ZMK Studio](https://zmk.studio/) (connected via USB to the central device) or by modifying the `.keymap` file directly.
