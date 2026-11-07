# NOTORYX Core Ham: competitive intelligence report

Researched 2026-11-07 against NOTORYX Core Ham `dev` d064a55 (0.1.0-test.3) and the NOTORYX ham firmware (`NOTORYX-Core-Ham-Firmware` main, PRs #1–#4 merged). This is a research document: no app or firmware code was changed.

Companion files: [FEATURE_MATRIX.md](FEATURE_MATRIX.md) / [feature_matrix.json](feature_matrix.json) (25 rows) and [COMPETITIVE_ROADMAP.md](COMPETITIVE_ROADMAP.md).

> Regulatory statements here are an engineering reading of 47 CFR Part 97, not legal advice. See [licensed-operator/COORDINATION.md](../licensed-operator/COORDINATION.md): operate only after a great deal of coordination.

## 0. Method and limits

- **Our app and firmware:** read from source; claims point at files.
- **Competitors:** GitHub API (stars, last push, license) on 2026-11-07, official docs, project READMEs and community guides found by web search.
- **Not done:** no competitor was tested on air. App-store reviews and Reddit weren't retrieved. "U" in the matrix means unknown, not missing.
- **Scope:** NOTORYX Core Ham's market is *licensed operators who want a LoRa mesh on amateur frequencies.* The general MeshCore app comparison (official app, MeshCore One, MeshCore Open and so on) is in notoryx-core PR 217 and is not repeated here. Stock MeshCore apps can't legally carry encrypted traffic on amateur frequencies, so they appear only for contrast.

## 1. Ecosystem map: amateur LoRa and amateur mesh options

| Option | What it is | Platforms | License | Activity (2026-11-07) |
|---|---|---|---|---|
| **Meshtastic licensed mode** | `is_licensed` user setting: call sign as the node name, encryption off; licensed nodes and the default encrypted mesh can't talk to each other | Official Android (v2.8.3), Apple (v2.7.27), web, CLI | GPL-3.0 | Very active ([docs](https://meshtastic.org/docs/configuration/radio/user/)) |
| **LoRa APRS** trackers and iGates | APRS frames over LoRa on 70 cm (e.g. 433.775 MHz), plaintext, source call in every frame | ESP32 boards; phones via BLE KISS TNC to APRSdroid (Android) or aprs.fi (iOS) | GPL-3.0 firmware | [LoRa_APRS_Tracker 521★](https://github.com/richonguzman/LoRa_APRS_Tracker), [LoRa_APRS_iGate 532★](https://github.com/richonguzman/LoRa_APRS_iGate), both pushed 2026-10-29; [APRSdroid 607★](https://github.com/ge0rg/aprsdroid) |
| **Reticulum + Sideband on an RNode** | Encrypted-by-design network stack; RNode interface can ID with `id_callsign` / `id_interval` | Sideband: Android, Linux, macOS, Windows | Reticulum's own license | [Reticulum 7,682★](https://github.com/markqvist/Reticulum), [Sideband 2.2.0, 2026-10-01](https://github.com/markqvist/Sideband) |
| **AREDN** | Amateur mesh over Wi-Fi-band hardware (not LoRa) | Routers | Open source | [aredn/aredn, pushed 2026-10-29](https://github.com/aredn/aredn) |
| **JS8Call / Winlink / packet (AX.25)** | HF/VHF keyboard and store-and-forward modes | Desktop | Mixed | JS8Call last push 2025-12-05 |
| **Stock MeshCore apps** | Encrypted mesh; not a Part 97 option on amateur frequencies | All | Mixed | See notoryx-core PR 217 |

## 2. Profiles

### 2.1 Meshtastic licensed mode: the strongest competitor
- **Strengths:** built into the official apps everyone already has; one switch; large hardware base; community licensed-operations guides (e.g. [bayme.sh](https://bayme.sh/docs/licensed-operations/)).
- **Weaknesses (documented):**
  - Sources disagree on whether turning it on also clears the primary channel key automatically, so operators have to check their own channel PSK ([user config docs](https://meshtastic.org/docs/configuration/radio/user/); community guides).
  - Call sign identification relies on NodeInfo broadcasts, not every frame.
  - [CVE-2025-55292](https://db.gcve.eu/vuln/CVE-2025-55292): a forged NodeInfo could advertise ham mode on behalf of a victim node.
  - Admin with signatures in licensed mode is still being aligned in the Apple app ([Meshtastic-Apple #2067](https://github.com/meshtastic/Meshtastic-Apple/issues/2067)).
- **No evidence found** of transmit lock without a call sign, band locking, ERP estimation or §97.303 location checks.

### 2.2 LoRa APRS
- **Strengths:** mature, worldwide APRS-IS internet backbone, call sign in every frame, works with existing APRS maps and phone apps.
- **Weaknesses:** not a mesh (digipeating only), short messages, the phone side depends on separate TNC apps.
- **Lesson for NOTORYX:** iGate-style internet linking and showing stations on existing ham maps are things hams already expect.

### 2.3 Reticulum + Sideband
- **Strengths:** robust multi-transport stack, store-and-forward, interface-level call sign ID.
- **Unknown:** whether LXMF traffic can be sent fully unencrypted for Part 97 use. We found no primary source, so it is marked U.

### 2.4 Where NOTORYX Core Ham stands
NOTORYX Core Ham is the only option we found that combines a **MeshCore-style mesh** with:
- **identification on every frame, relays included** (firmware call trailer)
- a **transmit lock** until a valid US call sign is set
- **band-locked frequencies** (420–450 and 902–928 MHz)
- **login without sending the password** (an HMAC proof)
- **power and location cautions** in the app

Its weak points are the ones it inherited: it is based on NOTORYX Core rc.24 and is 70 commits behind Core `dev`.

## 3. Recurring weaknesses in amateur LoRa options

1. **Operators have to work out what is legal themselves.** No competitor checks band, power or location in software.
2. **Identification is periodic, not per frame** (Meshtastic NodeInfo, Reticulum `id_interval`). That leaves room for doubt about relayed traffic.
3. **Mixed networks confuse people.** Licensed and unlicensed nodes can't talk to each other in Meshtastic either. Users need the app to say so clearly.
4. **Spoofable "licensed" flags** (CVE-2025-55292).
5. **Fragmented phone tooling** for LoRa APRS (separate TNC firmware plus a separate APRS app).

## 4. Internal audit (summary)

- **App:** ~113k hand-written Dart lines (outside `lib/l10n`); the licensed-operator code is ~650 lines across `lib/utils/amateur_{radio,power,location}.dart` and `lib/screens/licensed_operator_screen.dart`, plus `operator_profile`, `operator_setup_banner` and `licensed_operator_card`. The connector (`meshcore_connector.dart`, 9,134 lines) is the inherited hotspot.
- **Firmware:** `AMATEUR_RADIO` build flag, `src/helpers/AmateurStation.*`, login proof; 53 native tests plus mcsim runs for relay, plaintext, call trailer, TX lock and login.
- **Inherited P0s from Core:** messages in SharedPreferences (`lib/storage/message_store.dart:29`); auto-reconnect Bluetooth-only; iOS bundle ID still `com.monitormx.meshcoreopen`.
- **Missing core-to-ham ports:** everything in Core rc.25–rc.33. That includes quick messages, stop retrying, network scan, map regional presets, multi-add discovered contacts, separate flood attempts, buzzer switch, meshcore:// links and interactive path graph (Core #191–#216).
- **Release state:** 0.1.0-test.1 to test.3 published as pre-releases in NOTORYX-Core-Ham-Releases; the redesign is in PRs #8 and #9, which are stacked.

## 5. Answers in brief

- **Strongest competitor:** Meshtastic licensed mode, because it is already in everyone's pocket.
- **What it does better:** reach, hardware support, iOS, simplicity, a big community.
- **What NOTORYX Core Ham does better:** per-frame identification including relays, the transmit lock, band lock, password-free login proof, power and location cautions, and a coordination guide.
