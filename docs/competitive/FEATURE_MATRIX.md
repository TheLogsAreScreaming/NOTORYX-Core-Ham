# NOTORYX Core Ham: master feature comparison matrix

Researched 2026-11-07 (NOTORYX Core Ham `dev` d064a55, 0.1.0-test.3; open PRs #8/#9 are UI only). Machine-readable copy: [`feature_matrix.json`](feature_matrix.json).

## How to read this

- NX cells come from source (app `lib/`, firmware `src/helpers/AmateurStation.*` on NOTORYX-Core-Ham-Firmware main). Competitor cells are I/S/F/M only when a primary source says so; otherwise U.
- MC is included only for contrast: stock MeshCore encrypts all traffic, so it is not a Part 97 option on amateur frequencies.
- This is an engineering comparison, not legal advice. Part 97 points must be checked against the current eCFR text.
- No competitor app was installed and tested hands-on for this report.

| Code | Meaning |
|---|---|
| I | Implemented |
| P | Partial |
| M | Missing |
| S | Superior |
| F | Inferior |
| U | Unverified |
| NA | Not applicable |
| O | In open PR |

**Apps:** **NX** = NOTORYX Core Ham + NOTORYX ham firmware; **MT** = Meshtastic licensed mode (official apps + firmware); **LA** = LoRa APRS (trackers/iGates + APRSdroid / aprs.fi); **RS** = Reticulum + Sideband on an RNode; **MC** = Stock MeshCore apps (official, MeshCore One)

**NOTORYX Core Ham + NOTORYX ham firmware totals (25 rows):** 13 implemented, 4 superior, 3 inferior, 3 partial, 1 unverified, 1 missing

## Part 97 operation

| Feature | NX | MT | LA | RS | MC | Evidence / note |
|---|---|---|---|---|---|---|
| Unencrypted content on air | I | I | I | U | M | NX firmware sends plaintext with a 2-byte MAC kept; MT licensed mode clears encryption (meshtastic.org user config docs); APRS is plaintext by design; MC encrypts everything |
| Call sign carried by every transmitted frame, including relays | S | P | I | P | M | NX: 8-byte call trailer added in firmware at send, so repeaters ID themselves; MT: call sign in NodeInfo broadcasts; APRS: source call in every frame; RS: periodic interface ID (`id_callsign`) |
| Transmit blocked until a valid call sign is set | I | U | U | U | NA | NX firmware TX inhibit; app `isUsCallsign()` in `lib/utils/amateur_radio.dart:63` |
| Remote login without sending the password | S | U | NA | U | M | NX login proof: HMAC-SHA256 over timestamp and both keys (firmware PR #2, merged) |
| Frequency locked to amateur bands | I | U | U | U | NA | NX firmware 420–450 / 902–928 MHz; app `isAmateurFrequencyMHz()` |
| Chip power vs antenna output estimate | S | U | U | U | M | `lib/utils/amateur_power.dart`: per-board amplifier gain, dBm→W, 10 W spread-spectrum ceiling (§97.311(d)) |
| Location cautions (§97.303 33 cm exclusion areas, Line A) | S | U | U | U | NA | `lib/utils/amateur_location.dart` |
| Coordination guide for operators | I | P | U | U | NA | `docs/licensed-operator/COORDINATION.md`; MT has community guides (bayme.sh licensed operations) |
| Spoof-resistant licensed flag | U | F | U | U | NA | MT CVE-2025-55292: forged NodeInfo could advertise ham mode |

## Messaging and mesh

| Feature | NX | MT | LA | RS | MC | Evidence / note |
|---|---|---|---|---|---|---|
| Mesh routing (multi-hop, flood + direct) | I | I | P | I | I | Inherited from NOTORYX Core; APRS uses digipeaters, not mesh routing |
| Direct and channel messages | I | I | P | I | I | APRS messages are point-to-point with ACK |
| Delivery acknowledgements and retries | I | I | P | I | I | Inherited from Core (rc.24 retry logic) |
| Message storage engine | F | U | U | U | U | Inherited `lib/storage/message_store.dart:29` JSON in SharedPreferences |
| Interop with the stock network on the same frequency | F | F | NA | U | NA | By design: payload version 2 frames are not readable by stock MeshCore; MT licensed nodes can't talk to the encrypted mesh |

## Mapping, internet and tools

| Feature | NX | MT | LA | RS | MC | Evidence / note |
|---|---|---|---|---|---|---|
| Map with nodes and positions | I | I | I | U | I | Inherited Core map |
| Internet gateway / bridge | P | I | S | I | P | NX inherits multi-broker MQTT from Core; APRS-IS iGates are the mature, worldwide ham option |
| Path / route diagnostics | I | P | P | U | I | Inherited Core Route Intelligence (rc.24 version) |
| Raw packet log with payload version | I | U | U | U | P | `lib/screens/ble_debug_log_screen.dart:310` |

## Platform and distribution

| Feature | NX | MT | LA | RS | MC | Evidence / note |
|---|---|---|---|---|---|---|
| Android | I | I | I | I | I | NX test builds in NOTORYX-Core-Ham-Releases (test.1–test.3) |
| iOS | M | I | P | M | I | NX iOS bundle ID still `com.monitormx.meshcoreopen`; aprs.fi iOS works with a BLE KISS TNC; Sideband has no iOS build |
| Desktop | P | I | P | I | I | NX macOS build exists (inherited workflow), not released |
| Firmware for the boards | P | I | I | I | I | NX ham firmware builds 7 boards; Station G2/G3 BLE companion over partition size |
| Open source | I | I | P | I | P | aprs.fi app is proprietary; MC official app is proprietary, MC1 is GPL-3.0 |
| Translations | I | I | U | U | I | Inherited Core locales; new Licensed Operator strings English-first |
| Tracks upstream app fixes | F | NA | NA | NA | NA | NX app is based on Core rc.24 and is 70 commits behind Core `dev` (rc.33) |
