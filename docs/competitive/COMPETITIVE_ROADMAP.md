# NOTORYX Core Ham: competitive strategy and roadmap

Researched 2026-11-07 against `dev` d064a55. Evidence is in [COMPETITIVE_ANALYSIS.md](COMPETITIVE_ANALYSIS.md) and [FEATURE_MATRIX.md](FEATURE_MATRIX.md). Everything here is a proposal; nothing in this PR changes code. Regulatory points are an engineering reading of Part 97, not legal advice.

## Status, 2026-11-08

The research below is kept as written on 2026-11-07. This table tracks what has shipped since. "Open PR" means the code is written but not yet merged into `dev`.

| Item | Status | Where |
|---|---|---|
| P0-1 Sync with Core | Done, now at Core rc.37 (54 commits after rc.33) | #16, #25 |
| P0-2 Merge the redesign | Done | #8–#19 |
| P0-3 SQLite message store | Done, through the Core sync | #25 |
| P0-4 On-air validation record | **Open: needs two stations.** Template in the test kit | — |
| P1-1 Pre-transmit checklist | Done. Firmware is the first check | #14, #28 |
| P1-2 Station ID on every frame | Done, on the message path screen and RX log | #14, #30 |
| P1-3 Trailer/name mismatch alert | Done, for direct adverts (relays carry the repeater's call) | #26 |
| P1-4 ERP with antenna and feedline | Done | `amateur_power.dart` |
| P1-5 iOS bundle ID | Done | #13 |
| W4 Stock-network warning | Done | #31 |
| Station log, ADIF/CSV export | Done. ADIF has no LoRa mode, so MODE is left out | #29 |
| Licensed Operator strings translated | Done, all 18 languages | — |
| Plain-text hint on the composer | Done | #27 |
| Coordination checklist from first run | Done | #32 |
| Firmware flag check on connect | Done: stock MeshCore is flagged by its version | #28 |
| Ham band-plan presets | **Open: needs coordinator-agreed channels.** The file is empty on purpose | `assets/regional_presets.json` |
| Hardware matrix doc | Done. No board has an on-air record yet | `docs/hardware/HARDWARE_MATRIX.md` |
| Measured PA tables | **Open: needs a dummy load** | — |
| Station G2/G3 BLE size | Open (firmware) | — |
| macOS release | Open: CI builds macOS; only Android is released | — |
| APRS-IS gateway, third-party traffic | Researched: own position only is a go; nothing into RF. Not built | `docs/licensed-operator/APRS_IS_RESEARCH.md` |
| Third-party traffic policy | Written. Bot Mode and weather posts under review | `docs/licensed-operator/THIRD_PARTY_POLICY.md` |
| Bluetooth-only auto-reconnect fix | Done, via Core | #25 |
| Phone screen-reader check | **Open: needs a phone.** Checklist in the test kit | — |

Releases: test.6 (2026-11-08) is the latest published build.

## 1. Competitive advantage opportunities

| Opportunity | Why it is open | Head start |
|---|---|---|
| **"Compliant by construction"** | No competitor checks band, power and location before transmitting | `amateur_power.dart`, `amateur_location.dart`, firmware TX lock and band lock |
| **Every frame identified, relays included** | Meshtastic and Reticulum ID periodically | Firmware call trailer at send |
| **Password never on air** | Plaintext networks make passwords readable | Login proof (firmware PR #2) |
| **Station log** | Hams expect logs; no LoRa mesh app keeps one | RX log already shows payload version (`ble_debug_log_screen.dart:310`) |
| **Bridge to existing ham maps** | LoRa APRS users get APRS-IS for free | Core's MQTT bridge code is inherited |

## 2. Competitor weakness report

| # | Weakness | Affected | Evidence | NOTORYX Ham today | Better answer | Difficulty | Priority |
|---|---|---|---|---|---|---|---|
| W1 | Legality left to the operator | MT, RS, LA | No band/power/location checks found in docs | Ahead (cautions, locks) | Pre-transmit checklist that blocks until resolved | S | P1 |
| W2 | Periodic, not per-frame ID | MT, RS | NodeInfo; `id_interval` | Ahead (firmware trailer) | Show "identified as <CALL>" on each RX line | S | P1 |
| W3 | Spoofable licensed flag | MT | CVE-2025-55292 | Unverified: call sign comes from node name + trailer | Flag frames whose trailer call ≠ the advertised name | S | P1 |
| W4 | Mixed networks confuse users | MT | Licensed/unlicensed can't talk | Partial: banner and card | Detect stock (encrypted) traffic on the frequency and say "you're on a stock network" | M | P2 |
| W5 | Fragmented phone tooling | LA | Separate TNC + app | n/a | Keep everything in one app | — | — |
| W6 | Inherited Core reliability debt | NX | 70 commits behind Core `dev` | Behind | Regular Core → Ham merges | M | P0 |

## 3. Innovation research

| Concept | Elsewhere? | Needs firmware change? | Effort | Notes |
|---|---|---|---|---|
| Pre-transmit compliance checklist | No | No (app) | S | Call sign valid, band, ERP under the 10 W SS ceiling (§97.311(d)), location cautions, firmware has `AMATEUR_RADIO` |
| Per-frame station ID display | No | No | S | Parse trailer in the RX path (`amateur_radio.dart:41`) |
| Station log (ADIF-style export) | Not on LoRa mesh | No | M | Contacts heard, time, freq, SNR; export ADIF or CSV |
| ERP calculator with antenna and cable loss | No | No | S | Extend `amateur_power.dart` with antenna gain and feedline loss |
| Trailer-vs-name mismatch alert | No | No | S | W3 |
| APRS-IS position gateway | LA iGates | No (app + internet) | L | Needs an APRS-IS passcode and care to avoid flooding; opt-in |
| Automatic band-plan presets by region | Partly (regional presets in Core) | No | S | Ham presets for US 70 cm / 33 cm |
| Third-party traffic rules | No | Maybe | M | Research §97.115 before relaying for unlicensed users via MQTT; default off |
| Higher-power board support with measured PA tables | No | No (app) | M | Needs measurements on a dummy load |

## 4. Internal audit

### 4.1 Architecture
Same as NOTORYX Core rc.24: `meshcore_connector.dart` (9,134 lines) owns transport, protocol and much state; screens read it directly. Ham code is small and isolated in `lib/utils/amateur_*.dart` plus four widgets/screens, which makes rebasing on Core practical.

### 4.2 Ahead (protect)
Per-frame ID, TX lock, band lock, login proof, power and location cautions, coordination docs, mcsim tests in the firmware repo.

### 4.3 Behind (verified)
1. JSON messages in SharedPreferences (`lib/storage/message_store.dart:29`).
2. iOS bundle ID `com.monitormx.meshcoreopen` (`ios/Runner.xcodeproj/project.pbxproj`).
3. 70 Core commits not merged (rc.25–rc.33 features and fixes).
4. In-app version is 0.1.0-test.3; not yet tested on air with a second station beyond mcsim (as far as this repo records).
5. Station G2/G3 BLE companion firmware over partition size (also on stock v1.18.0).

### 4.4 Most improvement for least effort
Merge Core `dev` into Ham `dev` (then the ham commits on top); per-frame ID display; pre-transmit checklist.

## 5. Prioritised roadmap

### P0: critical

**P0-1 Sync with Core.** *Problem:* 70 commits of fixes and features missing. *Solution:* merge Core `dev` (rc.33) into a `chore/sync-core-rc33` branch and resolve conflicts with the ham files; keep the app ID, name and release URLs. *Accept:* analyze clean, all tests pass, Licensed Operator screen unchanged. *Tests:* full suite + ham util tests. **M**

**P0-2 Merge the redesign in order.** Retarget #9 to `dev` after #8 merges. *Accept:* both merged, test.4 built. **S**

**P0-3 Message store** (shared with Core P0): move to SQLite once Core does, then pull it in through P0-1. **M**

**P0-4 On-air validation record.** Two real stations on a dummy load or low power: TX lock, trailer, login proof, relay ID. *Accept:* results in `docs/licensed-operator/` for test.4. **S**

### P1: high-impact

| ID | Item | Approach | Accept | Effort |
|---|---|---|---|---|
| P1-1 | Pre-transmit checklist | One screen gating first transmit: call sign, band, ERP, location cautions, firmware flag | Each failing check blocks with a reason | S |
| P1-2 | Per-frame station ID in RX views | Show the trailer call on messages and the RX log | Every amateur frame shows its call | S |
| P1-3 | Trailer/name mismatch alert | Compare trailer call to the contact's advertised name | Mismatch fixture raises an alert | S |
| P1-4 | ERP with antenna gain and feedline loss | Extend `amateur_power.dart` | ERP shown in W and dBm; warns over 10 W SS | S |
| P1-5 | iOS bundle ID | `com.bastionmesh.ham` on iOS too | Xcode project uses the new ID | S |

### P2: differentiators

- Station log with ADIF/CSV export. **M**
- Detect stock (encrypted) MeshCore traffic on the operating frequency and warn. **M**
- US ham band-plan presets (70 cm, 33 cm) in regional presets. **S**
- Licensed Operator strings translated. **S**

### P3: long-term

- APRS-IS position gateway (opt-in, passcode, rate-limited). **L**
- Measured PA tables for 1 W boards (RAK3401 booster etc.). **M**
- Third-party traffic policy (research §97.115 first). **M**
- Station G2/G3 BLE companion size reduction. **M**

## 6. Top 25 recommended improvements

1. P0-1 Sync with Core rc.33
2. P0-4 On-air validation record
3. P0-2 Merge redesign #8 → #9
4. P1-1 Pre-transmit checklist
5. P1-2 Per-frame station ID display
6. P1-3 Trailer/name mismatch alert
7. P1-5 iOS bundle ID
8. P0-3 SQLite message store (via Core)
9. P1-4 ERP with antenna and feedline
10. Ham band-plan presets
11. Stock-network detection warning
12. Station log + ADIF export
13. Translate Licensed Operator strings
14. Show "plaintext: anyone can read this" on the composer
15. Coordination checklist linked from first run
16. Firmware version/flag check on connect (refuse amateur features on stock firmware)
17. Release test.4 with the Core sync
18. Hardware matrix doc (which boards were tested)
19. Measured PA tables
20. Station G2/G3 size fix
21. Bluetooth-only auto-reconnect fix (via Core)
22. macOS release of the Ham app
23. APRS-IS gateway research spike
24. Third-party traffic research
25. Regular Core → Ham sync cadence (each Core release)

## 7. Quick wins

- iOS bundle ID change.
- Per-frame call display (parser exists).
- Composer hint "plaintext on air".
- Ham band-plan presets in `regional_presets.json` for this app's releases repo.

## 8. Innovation backlog

| Concept | Open question |
|---|---|
| APRS-IS gateway | Rate limits, duplicate suppression, passcode handling |
| Third-party traffic | §97.115 limits for unlicensed users bridged over MQTT |
| Automatic station ID audit | Can the app prove every transmission carried a call sign? |
| Higher power | Board-by-board measurements needed |

**Do not build:** any encryption on amateur frequencies; a "licensed" switch that can be turned on without a valid call sign; silent bridging of unlicensed users.

## 9. Strategic scoring

0–10. Confidence H = source read, M = docs/README, L = community guide only. "?" = not enough evidence.

| Area | NOTORYX Ham | Meshtastic licensed | LoRa APRS | Reticulum/Sideband |
|---|---|---|---|---|
| Ease of use | 6 (H) | 8 (M) | 5 (M) | 5 (M) |
| Messaging | 7 (H) | 7 (M) | 4 (M) | 8 (M) |
| Connectivity reliability | 6 (H) | 7 (M) | 7 (M) | 7 (M) |
| Mapping | 7 (H) | 7 (M) | 8 (M) | ? |
| Network diagnostics | 8 (H) | 6 (M) | 5 (M) | ? |
| Part 97 tooling | 9 (H) | 4 (M) | 6 (M) | 4 (M) |
| Performance | 6 (H) | 7 (M) | 8 (M) | ? |
| Accessibility | 6 (H) | 7 (M) | ? | ? |
| Privacy and security (for a plaintext service) | 8 (H) | 5 (M) | 5 (M) | ? |
| Overall | 7 | 7 | 6 | 6 |

**After P0 + P1:** about 8 overall (ease of use 7, reliability 7, Part 97 tooling 10).

## 10. Executive summary

- **Strongest competitor:** Meshtastic licensed mode.
- **What it does better:** reach, iOS, simplicity, the hardware base.
- **What NOTORYX Ham already does better:** every frame identified (relays included), transmit lock, band lock, password-free login, power and location cautions.
- **Biggest gaps in the market:** software that helps operators stay legal; trustworthy station ID; a station log for mesh traffic.
- **Build first:** sync with Core rc.33, then record on-air validation.
- **Don't build:** encryption on amateur frequencies, unlicensed bridging, a licensed switch without a call sign.
- **Five actions now:**
  1. Merge Core `dev` into Ham `dev` on a sync branch.
  2. Merge redesign #8 then #9 (retarget first).
  3. Record a two-station on-air test.
  4. Ship the pre-transmit checklist and per-frame ID display.
  5. Change the iOS bundle ID.
