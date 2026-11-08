# Hardware matrix

**NOTORYX Core Ham is for licensed amateur radio operators, and should only be used after a great deal of coordination with the people and services around you.** Read [COORDINATION.md](../licensed-operator/COORDINATION.md) before you transmit.

This page says what has been built and what has been proven. They are not the same thing.

**No board has a completed on-air test record yet.** "Built" means CI compiled the firmware and it was published. It doesn't mean the build has transmitted, relayed or passed a Part 97 check on that board. A completed record goes in `docs/testing/on-air-YYYY-MM-DD.md`.

## Published firmware (v1.18.0-ham-test.2)

| Board | MCU | Companion | Repeater | How to flash | On-air record |
|---|---|---|---|---|---|
| Heltec V4 | ESP32-S3 | BLE | Yes | Merged `.bin` at `0x0` | None |
| Heltec T114 | nRF52840 | BLE | Yes | `.uf2` | None |
| RAK4631 | nRF52840 | BLE | Yes | `.uf2` | None |
| RAK WisMesh 1W Booster (RAK3401) | nRF52840 | BLE | Yes | `.uf2` | None |
| SenseCAP T1000-E | nRF52840 | BLE | No | `.uf2` | None |
| Station G2 | ESP32-S3 | USB only (see below) | Yes | Merged `.bin` at `0x0` | None |
| Station G3 | ESP32-S3 | USB only (see below) | Yes | Merged `.bin` at `0x0` | None |

## Station G2 and G3 over Bluetooth

The published G2 and G3 Bluetooth companion did not fit its 1.25 MB app partition, so only USB was released. The firmware fix moves those two Bluetooth builds to the 16 MB partition layout. It isn't in a published release yet.

Flash with **Erase flash** ticked. The layout moves the storage area, so anything saved on the radio, including its identity and contacts, is lost.

## Power figures

Output power below is what the board source files say. None of it has been measured, and it isn't a substitute for your own measurement into a dummy load (§97.313, §97.13).

| Board | Source file says |
|---|---|
| Heltec V4 | Setting of 10 gives about 22 dBm final output |
| Station G2 | Setting of 7 gives about 27 dBm (about 0.5 W); never above 19 |
| Station G3 | Final output depends on the external PA level |
| RAK WisMesh 1W Booster | External 1 W stage; final output not stated |

## Band fit

The firmware locks transmit to 420–450 MHz and 902–928 MHz on every board. That is a software limit, and it doesn't make a board suitable for a band. The radio chip may tune to both, while the board's filters, amplifier and antenna are usually built for one. Confirm the variant you own covers the band you plan to use, and check SWR and output on that frequency.

## Not covered

- Boards in the firmware tree that aren't listed above have no published ham build.
- App connections: Android is the only released app build tested in CI for signing and packaging. macOS builds in CI, and iOS builds without signing. None has been run against a radio on record.
