# NOTORYX Core: competitive strategy and roadmap

**Research date:** 2026-11-07, against `dev` `21e5f380` (10.0.0-rc.33+85).

This is a research-only document. Nothing in the app was changed to produce it. Each item below is a proposal to be built in its own PR, with its own tests.

**Read with:**
- [COMPETITIVE_ANALYSIS.md](COMPETITIVE_ANALYSIS.md): ecosystem, competitor profiles, method and limits
- [FEATURE_MATRIX.md](FEATURE_MATRIX.md) and [feature_matrix.json](feature_matrix.json): 94-row comparison

**Contents**
1. [Competitive advantage opportunities](#1-competitive-advantage-opportunities)
2. [Competitor weakness report](#2-competitor-weakness-report)
3. [Innovation research](#3-innovation-research)
4. [NOTORYX Core internal audit](#4-notoryx-core-internal-audit)
5. [Prioritised roadmap (P0 to P3)](#5-prioritised-roadmap)
6. [Top 25 recommended improvements](#6-top-25-recommended-improvements)
7. [Quick wins](#7-quick-wins)
8. [Strategic scoring](#8-strategic-competitive-scoring)
9. [Executive summary](#9-executive-summary)

---

## 1. Competitive advantage opportunities

NOTORYX Core already has the **broadest feature set** of any MeshCore client: 25 of the 94 matrix rows are clearly ahead of every documented competitor. It is held back by **trust and reach**, not features:

- no iOS app and no store listing
- SharedPreferences storage
- Bluetooth-only auto-reconnect
- no recorded field validation

The best strategy is **"the most reliable and most explanatory MeshCore app"**, not "more features".

| Opportunity | Why it wins | Who does it today |
|---|---|---|
| **Explain every failed message, offline** | The top recurring complaint (MC1 #283 and #458, MeshCore #1834, MeshCore SAR #40). NOTORYX already has `DeliveryObservation`, timeout prediction and heard repeats, and only needs to *tell the user*. | Only MeshCore Companion, and only as a 24/7 web bridge |
| **Connection that heals itself on every transport** | Bluetooth fragility is the #1 complaint across apps. The official app needed v1.46 to fix iOS state restoration. | Official app (Bluetooth plus a Wi-Fi checkbox) |
| **Trip readiness check** | NOTORYX owns the safety niche. Nobody checks "radio charged, maps cached, SOS contacts reachable, preset right for here" before you leave. | Nobody |
| **Repeater owner care** | Battery watch, back-in-range and telemetry history are asked for (MeshCore Open #348) and done well only by MeshCore Companion. | MeshCore Companion, MeshCore One (charts) |
| **Free, complete remote admin** | The official app charges to skip the wait. NOTORYX already has ACLs, CLI and status for free. | MeshCore One and MeshCore Open (free, fewer tools) |
| **Accessible by design** | NOTORYX already has an Okabe-Ito palette and 18 languages. Nobody in the ecosystem advertises screen-reader support. | Nobody |
| **Trustworthy distribution** | F-Droid and IzzyOnDroid, Play and TestFlight are all requested elsewhere (MeshCore Open #113, #323, #508; MeshCore SAR #42). | Official, MeshTrax and MeshCore One are in stores |

---

## 2. Competitor weakness report

Ranked by how often each problem shows up across apps and how severe it is. "NX" is NOTORYX Core.

| # | Weakness | Apps affected (evidence) | Does NX have it? | How NX can do better | Benefit | Difficulty | Priority |
|---|---|---|---|---|---|---|---|
| W1 | **Bluetooth drops, silent disconnects, first message lost after a connect** | Official iOS ([mesh-sn.de](https://mesh-sn.de/en/news/details/meshcore-companion-apps-at-a-glance-meshcore-meshos-and-meshcore-one-for-ios-and-android); v1.46 fix), mesh-client [#426](https://github.com/Colorado-Mesh/mesh-client/issues/426) [#1142](https://github.com/Colorado-Mesh/mesh-client/issues/1142), Offband [#110](https://github.com/OffbandMesh/meshcore-client/issues/110) [#689](https://github.com/OffbandMesh/meshcore-client/issues/689), firmware [#1067](https://github.com/meshcore-dev/MeshCore/issues/1067) (63 comments) [#1166](https://github.com/meshcore-dev/MeshCore/issues/1166) | **Partly.** Bluetooth auto-reconnect exists with backoff. TCP and USB aren't retried. Android behaviour isn't field-verified. | Reconnect on all transports, a visible "reconnecting" state, a send gate until sync completes, and an exported connection log | Very high | Medium | **P0** |
| W2 | **No way to tell why a DM failed** | MC1 [#283](https://github.com/Avi0n/MeshCoreOne/issues/283) [#458](https://github.com/Avi0n/MeshCoreOne/issues/458), firmware [#1834](https://github.com/meshcore-dev/MeshCore/issues/1834), MeshCore SAR [#40](https://github.com/dz0ny/meshcore-sar/issues/40), MeshCore Open [#176](https://github.com/zjs81/meshcore-open/issues/176) | **Partly.** Status ticks and retries are there, and Observer reach works online only. No plain-words diagnosis. | A delivery diagnosis sheet: "never left your radio / heard by repeater X but no receipt / receipt came back". Fully offline from data the app already captures. | Very high | Medium | **P1** |
| W3 | **SharedPreferences used as a message database** | MeshCore Open README, Offband [#334](https://github.com/OffbandMesh/meshcore-client/issues/334), MeshCore Open [#202](https://github.com/zjs81/meshcore-open/issues/202) (CPU) | **Yes.** `lib/storage/message_store.dart:28` JSON-encodes the whole list on each save. | Move to SQLite with a one-time, verified migration | High (scale, battery, data safety) | High | **P0** |
| W4 | **Hard to get the app: no F-Droid, store or Windows builds** | MeshCore Open [#113](https://github.com/zjs81/meshcore-open/issues/113) (10 reactions) [#323](https://github.com/zjs81/meshcore-open/issues/323) [#508](https://github.com/zjs81/meshcore-open/issues/508), wardrive [#18](https://github.com/mintylinux/Meshcore-Wardrive-Android/issues/18), Offband [#159](https://github.com/OffbandMesh/meshcore-client/issues/159), MeshCore SAR [#42](https://github.com/dz0ny/meshcore-sar/issues/42) | **Yes.** APK, Obtainium and Mac only. No iOS. | IzzyOnDroid first (accepts prebuilt APKs), then TestFlight, then Play | High | Medium | **P1** |
| W5 | **Contacts drift from what the radio holds; table full** | Offband [#838](https://github.com/OffbandMesh/meshcore-client/issues/838) [#660](https://github.com/OffbandMesh/meshcore-client/issues/660) | **Unknown.** Same code lineage, not tested. | A periodic "radio truth" reconcile and a clear "radio table nearly full" warning with suggested removals | High | Medium | **P0** (test) / P1 (feature) |
| W6 | **Max-length message wedges Bluetooth writes** | Offband [#395](https://github.com/OffbandMesh/meshcore-client/issues/395) [#592](https://github.com/OffbandMesh/meshcore-client/issues/592) | **Unknown.** NX requests a larger MTU "only where the platform path supports it" (`meshcore_connector.dart:2721`). | A regression test that sends a max-length DM and channel post over a simulated 23-byte MTU | High | Low | **P0** (test) |
| W7 | **Remote admin timeouts and failures** | Offband [#473](https://github.com/OffbandMesh/meshcore-client/issues/473), firmware [#236](https://github.com/meshcore-dev/MeshCore/issues/236) [#983](https://github.com/meshcore-dev/MeshCore/issues/983) | **Unknown.** | Timeouts sized from path length and airtime (`lora_airtime.dart` already exists), auto-retry, and "still waiting… (hop 2 of 3)" progress | Medium | Low | P1 |
| W8 | **Multi-byte path confusion** | MeshCore Open [#421](https://github.com/zjs81/meshcore-open/issues/421) (16 reactions), Offband [#240](https://github.com/OffbandMesh/meshcore-client/issues/240) [#150](https://github.com/OffbandMesh/meshcore-client/issues/150) | **Mostly handled.** 26 references to path hash size, and path graph resolves 1-byte hops. | Keep the lead. Show the path-hash badge on every node, like MeshCore Companion does. | Medium | Low | P2 |
| W9 | **Telemetry is a snapshot, not a history** | MeshCore Open [#348](https://github.com/zjs81/meshcore-open/issues/348), MC1 [#386](https://github.com/Avi0n/MeshCoreOne/issues/386) | **Yes.** `node_telemetry_store.dart` keeps readings but there are no charts and no polling. | Charts, plus an opt-in poll schedule with an airtime budget | Medium | Medium | P1 |
| W10 | **Reactions cost airtime and don't interoperate** | MeshCore Open [#109](https://github.com/zjs81/meshcore-open/issues/109) [#521](https://github.com/zjs81/meshcore-open/issues/521), MC1 [#298](https://github.com/Avi0n/MeshCoreOne/issues/298) | **Yes** (inherited format) | A setting to keep reactions local-only, an airtime hint on EU presets, and a documented interop table | Medium | Low | P2 |
| W11 | **US/FCC-compliant presets** | MC1 [#420](https://github.com/Avi0n/MeshCoreOne/issues/420) (21 comments), Offband [#647](https://github.com/OffbandMesh/meshcore-client/issues/647) | **Handled.** `widgets/us_bandwidth_notice.dart` plus regional presets. | Already ahead; keep the notice accurate. | — | — | — |
| W12 | **Android background killed** | MeshCore Open [#58](https://github.com/zjs81/meshcore-open/issues/58) (25 comments) | **Handled.** Foreground service exists. | Verify on Samsung and Pixel battery optimisers, with a "battery optimisation" check in settings | Medium | Low | P1 |
| W13 | **Protocol crypto concerns** | firmware [#259](https://github.com/meshcore-dev/MeshCore/issues/259) (93 comments, open) | A firmware issue, which no app can fix | Honest privacy page: what MeshCore encrypts and what it doesn't. Signed posts already help authenticity. | Trust | Low | P2 |
| W14 | **Remote admin paywall** | Official app (mesh-sn.de) | **No.** NX is free. | Say so in the README and store text, factually and without disparaging anyone | Medium | — | Messaging |

---

## 3. Innovation research

The Feasibility column says **App** (buildable within stock companion firmware v1.16 to v1.18), **FW** (needs firmware changes), or **Ext** (needs an external service).

| Concept | Already offered elsewhere? | What would be different in NX | Feasibility | Battery / airtime | Privacy | Effort | Value |
|---|---|---|---|---|---|---|---|
| **Delivery diagnosis** | MeshCore Companion (bridge) | On the phone, offline, part of the chat | App: ACK codes, heard repeats and path already captured | None (passive) | Local only | M | ★★★★★ |
| **Route health score per contact** | mesh-client asked for it ([#223](https://github.com/Colorado-Mesh/mesh-client/issues/223)) | Uses `PathHistoryService` success rates, SNR per hop and age. Shown as Good / Weak / Stale with reasons. | App | None | Local | M | ★★★★ |
| **Repeater reliability ranking** | NX "best repeaters" partial; MeshCore Companion "who you hear" | Ranks by heard frequency, SNR trend and repeat success. Flags repeaters that went quiet. | App (passive RX) | None | Local; don't upload without opt-in | M | ★★★★ |
| **Mesh health dashboard** | mesh-client band, MeshCore Companion link health | One graded card on Home: link, airtime, noise, repeaters heard. Plain words, color-blind safe. | App | Low (stats poll already exists) | Local | M | ★★★★ |
| **Trip readiness check** | Nobody | Radio battery, firmware version, preset vs location, maps cached for the trip area, SOS recipients set *and* recently heard, phone battery, background permission | App | One-off | Local | M | ★★★★★ |
| **Network change detection** | Partly (regional preset "settings changed" notice) | Alerts on: a new repeater nearby, a favourite repeater silent for over 24 h, local preset changes, a sudden noise floor rise | App | None | Local | M | ★★★ |
| **Guided troubleshooting** | Nobody in MeshCore (Meshtastic has docs plus AI) | "Can't connect" / "messages not arriving" / "nobody hears me" decision trees that run live checks (permissions, Bluetooth state, preset, advert sent, repeaters heard) | App | None | Local | M | ★★★★ |
| **Predictive connectivity warnings** | No | Warns when the route health score falls or the target is stale before sending, and suggests flood. | App | None | Local | S once the score exists | ★★★ |
| **Coverage gap detection** | Wardrive apps show raw samples | Highlights hexes with no successful pings along a recorded track | App (data exists in coverage hexes) | None | Local unless uploaded | M | ★★★ |
| **Privacy-preserving shared intelligence** | LetsMesh and CoreScope (raw observer feeds) | Upload only aggregated hex results with the existing privacy delay; never DMs | App + Ext (user's own endpoint) | Low | Opt-in, aggregated | L | ★★ |
| **Intelligent reconnection** | Official (Bluetooth plus Wi-Fi) | All transports, reason-aware: no backoff storm when Bluetooth is off, and the radio isn't held after a manual disconnect (Offband #689) | App | Low | — | M | ★★★★★ |
| **Firmware-level SOS relay** | No | Repeat SOS at the repeater level | **FW**; maintainers resist companion repeat ([MeshCore #2396](https://github.com/meshcore-dev/MeshCore/issues/2396)) | — | — | L | ★★★ |
| **Firmware update in app** | Meshtastic apps; MC1 store listing reportedly (unverified) | nRF DFU over Bluetooth and ESP32 OTA, verified against official release hashes | App + Ext (release downloads) | One-off | Must verify signatures and hashes | L | ★★★ |
| **Voice clips (Codec2)** | MeshCore SAR | — | App, but heavy airtime | **High airtime** | — | L | ★ (don't) |

---

## 4. NOTORYX Core internal audit

### 4.1 Architecture

- **Framework:** Flutter (pubspec says 3.47 stable), Provider and ChangeNotifier.
- **Connector:** one connector class, [`lib/connector/meshcore_connector.dart`](../../lib/connector/meshcore_connector.dart), at **9,181 lines**, with TCP and USB helpers split out. It holds protocol, state, reconnect, SOS relay hooks and more.
- **Size:** 64 screens. The largest are `map_screen.dart` (4,218 lines), `channel_chat_screen.dart` (2,945) and `app_settings_screen.dart` (2,769).
- **Storage:** 15 store classes on `shared_preferences`, plus file stores for images, map tiles and translation models.
- **Code lineage:** about 68% MeshCore Open by blame (2026-11-05 audit). A clean-room rewrite is underway separately in `notoryx-core-independent`.

### 4.2 Already ahead (keep and protect)

- **Safety suite:** SOS with repeat and all-clear, signed SOS, SOS relay, check-ins with per-recipient results, trips, overdue alerts, the Android widget.
- **Network intelligence:** network scan, regional presets by location (map-sourced v2), path graph, Route Intelligence, Observer reach, coverage hexes, wardrive.
- **Admin:** access control, companion and remote CLI, flood corridor, Region setup, Repeater IDs.
- **MQTT:** multi-broker with keychain credentials, radio-signed LetsMesh auth, and observer sharing in the `meshcoretomqtt` format.
- **Inclusion:** 18 languages, Okabe-Ito, red-light theme, settings search.
- **Engineering:** about 1,236 tests, CI with `--fatal-infos` and format checks.

### 4.3 Behind (verified in source)

| Area | Finding | Evidence |
|---|---|---|
| Storage | JSON blobs in SharedPreferences, rewritten whole on each save, on the UI isolate | `lib/storage/message_store.dart:26-29` |
| Reconnect | Auto-reconnect only for the Bluetooth transport | `meshcore_connector.dart:3154-3158` |
| iOS identity | `PRODUCT_BUNDLE_IDENTIFIER = com.monitormx.meshcoreopen` (upstream's) | `ios/Runner.xcodeproj/project.pbxproj:450` |
| Validation | All physical tests are "required"; SOS relay not field-tested | [`docs/BASTION_FIELD_VALIDATION.md`](../BASTION_FIELD_VALIDATION.md), README |
| Accessibility | 65 `Semantics(` in 116k lines; one `TextScaler` use | grep on `lib/` |
| Missing features | RX log UI, telemetry charts, MGRS/UTM, GPX import/waypoints, sender block, @mention autocomplete, multiple radios, firmware update, app lock, at-rest encryption | grep on `lib/` (see matrix) |
| Bundle weight | `llamadart` and `flutter_onnxruntime` in every build | `pubspec.yaml` |
| Tech debt | 9k-line connector; `analysis_options.yaml` local drift noted in project memory | file sizes |

### 4.4 Greatest improvement for least effort

1. TCP/USB reconnect (reuses the existing Bluetooth reconnect path).
2. An RX log screen (the data is already parsed in `radio_rx_packet.dart` and `heard_channel_packet.dart`).
3. A delivery diagnosis sheet (the data is already captured).
4. Changing the iOS bundle ID.
5. Telemetry charts from `node_telemetry_store`.

---

## 5. Prioritised roadmap

Every item: one PR, `flutter analyze --fatal-infos` and `dart format` clean, tests added, no regressions to existing features, strings localised in 18 locales.

### P0: critical (reliability, data safety, broken assumptions)

#### P0-1 Move message history to SQLite
- **Problem:** whole-list JSON rewrites in SharedPreferences. This slows down and risks loss with long histories. Offband had to replace the same design ([#334](https://github.com/OffbandMesh/meshcore-client/issues/334)), and the official app uses SQLite (v1.43 "export app sqlite database").
- **Solution:** `drift` + `sqlite3` (already proven in `notoryx-core-independent` PR #5). Tables for messages, channel messages, contacts and unread. A one-time migration reads the old keys, writes rows, verifies the counts, and only then clears the old keys.
- **Code changes:** `lib/storage/*_store.dart` behind the same interfaces, a new `lib/storage/db/`, a migration service, and the `build_runner` freshness check in CI.
- **Dependencies:** none.
- **Complexity:** high.
- **Risks:** a migration bug loses history. Mitigate with a dry-run count check, by keeping the old keys for one release, and with the encrypted backup prompt before migrating.
- **Acceptance criteria:**
  - A copy of a real user database (500 contacts, months of channels) migrates with identical counts.
  - Cold start is not slower.
  - The app works when restarted mid-migration.
- **Tests:** a migration test on fixture prefs, an interrupted-migration test, and a 50k-message performance test.

#### P0-2 Auto-reconnect on every transport, and verify it on Android
- **Problem:** `_shouldAutoReconnect` is Bluetooth-only. The official app added Wi-Fi auto-reconnect (v1.44). Android reconnect failed in the sibling Independent app's test 5.
- **Solution:**
  - Extend the reconnect policy to TCP (same host and port) and USB (same device path, on attach events).
  - Make the reconnecting state visible in the UI.
  - Never retry after a manual disconnect.
  - Release the radio cleanly on a manual disconnect (Offband [#689](https://github.com/OffbandMesh/meshcore-client/issues/689)).
- **Code changes:** `meshcore_connector.dart`, `meshcore_connector_tcp.dart`, `meshcore_connector_usb.dart`, `auto_connect_service.dart`.
- **Complexity:** medium.
- **Risks:** reconnect storms. Mitigate by keeping the capped backoff (attempt ≤ 6).
- **Acceptance criteria:**
  - Pulling the TCP server or USB cable for 30 s and restoring it reconnects without a tap.
  - No sends happen while disconnected.
  - Messages keep accurate status.
- **Tests:** fake transport drop tests per transport, plus a physical check on an Android phone recorded in the field validation doc.

#### P0-3 Record the real-radio validation matrix
- **Problem:** safety features (SOS, SOS relay, check-ins) have no recorded physical-test evidence. Competitors don't do this either, so it's a trust differentiator.
- **Solution:** run every row in `BASTION_FIELD_VALIDATION.md` on at least 2 phones (Android plus Mac) and 2 radios (nRF52 and ESP32), and record the results in the doc.
- **Complexity:** medium, all on the operator side.
- **Acceptance criteria:** every row has a date, device, firmware, build and pass/fail.
- **Dependencies:** none.

#### P0-4 Regression tests for known Bluetooth and contact failures from sibling apps
- **Problem:** NX shares code with apps that hit these bugs:
  - [#395](https://github.com/OffbandMesh/meshcore-client/issues/395) max-length write wedge
  - [#592](https://github.com/OffbandMesh/meshcore-client/issues/592) MTU cap
  - [#838](https://github.com/OffbandMesh/meshcore-client/issues/838) contact drift
  - [mesh-client #426](https://github.com/Colorado-Mesh/mesh-client/issues/426) first message after a connect dropped
- **Solution:** a test for each, using the existing connector fakes. Fix any that fail.
- **Complexity:** low to medium.
- **Acceptance criteria:** all four scenarios are covered by tests and pass.

#### P0-5 Give iOS its own bundle ID
- **Problem:** the iOS target still uses upstream's `com.monitormx.meshcoreopen`, which would clash with MeshCore Open on TestFlight and the App Store.
- **Solution:** change it to the NOTORYX ID family (`com.bastionmesh.bastion`, matching macOS). Update entitlements and the share extension, if any.
- **Complexity:** low.
- **Acceptance criteria:** the CI iOS build is green with the new ID.

### P1: high-impact competitive improvements

| ID | Item | Problem / evidence | Approach | Complexity | Acceptance |
|---|---|---|---|---|---|
| P1-1 | **Delivery diagnosis sheet** | W2 | Tap a failed or pending DM → timeline: queued → sent (attempt n, direct or flood) → heard repeated by X (SNR) → ACK or none. A plain-words verdict. Uses `DeliveryObservation`, ACK codes, heard repeats and the path. | M | Each of the 4 outcome classes is shown correctly in widget tests; no network needed |
| P1-2 | **RX log and packet inspector** | MC1, MeshCore Companion and mesh-client have it; the official app reportedly lacks it | A ring buffer (for example 2,000 packets) from `LOG_RX_DATA`; filter by type or signed; hex plus decoded fields; export | M | Live view under 1 s of lag; buffer survives a screen change; export works |
| P1-3 | **Telemetry history and repeater battery watch** | MeshCore Open #348; MeshCore Companion battery watch | Charts from `node_telemetry_store`; opt-in poll per repeater with an interval floor (≥ 1 h) and an airtime budget; low-battery notification | M | Poll respects the budget; charts render 30 days; alert fires on a fixture |
| P1-4 | **Back-in-range and gone-quiet alerts for favourites** | MeshCore Companion | Reuse the overdue-alert logic; trigger on advert or message after silence of N h | S | Fires once per return; no spam on startup sync |
| P1-5 | **IzzyOnDroid → TestFlight → Play** | W4 | Reproducible APK metadata; a lite flavor without `llamadart`/`onnxruntime` for repos that reject heavy native blobs; TestFlight after P0-5 | M | Listed in IzzyOnDroid; TestFlight build installable |
| P1-6 | **@mention autocomplete and per-sender block** | Official, MC1, TEAM, MeshCore Companion and MeshTrax have them | Composer suggestions from the channel's recent senders; block list applied before notifications | S to M | Blocked senders never notify; mention inserts `@[name]` in the format other apps use |
| P1-7 | **Remote admin timeouts sized by path** | Offband #473; firmware #236 | Timeout = f(hops, airtime estimate) from `lora_airtime.dart`; auto-retry once; progress text | S | No 5 s false timeouts on 3-hop fixtures |
| P1-8 | **Contact table health** | Offband #660 and #838; MeshCore Companion auto-evict | Show the radio's used/max; warn at 90%; suggest the least recently heard to remove (never automatic without opt-in); reconcile with the radio on resync | M | Count matches the radio after resync on a fixture |
| P1-9 | **Coordinate formats (MGRS, UTM, Maidenhead)** | MeshCore Open, MeshTrax | Pure-Dart conversion with tests against known vectors; a display setting; copy in the chosen format | S | Round-trip tests within 1 m |
| P1-10 | **Battery-optimisation check (Android)** | MeshCore Open #58 | Detect `ignoringBatteryOptimizations`; show a one-tap fix in Diagnostics | S | Shown only when optimisation is on |

### P2: advanced differentiators

| ID | Item | Builds on | Notes |
|---|---|---|---|
| P2-1 | **Trip readiness check** | Field ops, map cache readiness, presets | A pre-departure checklist with live checks; part of "Plan your trip"; can't be skipped for SOS recipients |
| P2-2 | **Route health score and predictive warning** | PathHistoryService, Route Intelligence | Good / Weak / Stale with reasons; warns before sending on a stale route |
| P2-3 | **Mesh health card** | Diagnostics, stats, noise floor | Graded in plain words (like mesh-client and MeshCore Companion), color-blind safe |
| P2-4 | **Repeater reliability ranking and network change alerts** | Path graph, discovered list | "Repeater X went quiet 26 h ago", "new repeater Y heard nearby" |
| P2-5 | **Guided troubleshooting** | Connection log, diagnostics | Three decision trees with live checks; link from error states |
| P2-6 | **GPX/KML import, waypoints, shared routes** | Map, track log | MeshCore TEAM and MeshTrax do this; send waypoints as small structured channel posts with a documented format |
| P2-7 | **Team tracking to a private channel** | SOS position share | Opt-in, interval floor, auto-off after a trip; red-light map filter |
| P2-8 | **Accessibility pass** | Themes, l10n | Semantics on every tap target, 44 px targets, text scale to 200% without clipping, a TalkBack and VoiceOver walk-through |
| P2-9 | **Reactions airtime mode** | reaction_helper | "Send reactions over radio: on / off (local only)"; default off on EU duty-cycle presets |
| P2-10 | **Connector split** | meshcore_connector.dart | Extract protocol codec, reconnect policy and SOS hooks into separately tested units; no behaviour change |
| P2-11 | **Honest privacy page** | PRIVACY_POLICY.md | What MeshCore encrypts (links firmware #259); what NOTORYX stores and sends; MQTT opt-ins |

### P3: long-term innovations

| ID | Item | Requires | Notes |
|---|---|---|---|
| P3-1 | Firmware update in app (nRF DFU, ESP32 OTA) | External release downloads, signature and hash verification | High support burden; brick risk; only after P0-3 |
| P3-2 | Multiple radios at once | Connector refactor (P2-10) | Requested in MeshCore Open #119; mesh-client does it on desktop |
| P3-3 | At-rest encryption (SQLCipher) and app lock | P0-1 | Meaningful only after SQLite |
| P3-4 | iOS Live Activity, Siri, CarPlay | P0-5, a TestFlight base | Matches MC1 and Meshtastic Apple |
| P3-5 | Firmware-side SOS relay | MeshCore firmware PR | A draft feature request exists but has not been posted; upstream is resistant to companion repeat (#2396) |
| P3-6 | On-device RF coverage prediction (ITU-R P.1812-style) | Terrain data | Meshtastic Android Site Planner shows it's feasible on a phone |

---

## 6. Top 25 recommended improvements

Ranked by impact × feasibility × differentiation.

| Rank | Item | Priority | Why |
|---|---|---|---|
| 1 | SQLite message store (P0-1) | P0 | Data safety and scale; the foundation for search, encryption and export |
| 2 | Reconnect on all transports + Android verification (P0-2) | P0 | The #1 ecosystem complaint |
| 3 | Real-radio validation record (P0-3) | P0 | Safety features without evidence are a liability |
| 4 | Delivery diagnosis sheet (P1-1) | P1 | The most-requested missing capability; unique on a phone |
| 5 | Sibling-app regression tests (P0-4) | P0 | Cheap insurance against known shared bugs |
| 6 | iOS bundle ID (P0-5) | P0 | Unblocks iOS |
| 7 | RX log and packet inspector (P1-2) | P1 | Data already parsed; parity with MC1 and MeshCore Companion |
| 8 | Trip readiness check (P2-1) | P2 | Nobody has it; fits the safety identity |
| 9 | IzzyOnDroid, TestFlight, Play (P1-5) | P1 | Reach |
| 10 | Telemetry history and repeater battery watch (P1-3) | P1 | Repeater owners are the most engaged users |
| 11 | Contact table health (P1-8) | P1 | Prevents silent contact loss |
| 12 | Remote admin timeouts (P1-7) | P1 | Admin reliability; the free-admin advantage |
| 13 | Back-in-range alerts (P1-4) | P1 | Small, delightful |
| 14 | @mentions and blocking (P1-6) | P1 | Parity |
| 15 | Mesh health card (P2-3) | P2 | Makes existing data understandable |
| 16 | Route health score (P2-2) | P2 | Builds on Route Intelligence |
| 17 | Guided troubleshooting (P2-5) | P2 | Lowers support load |
| 18 | Accessibility pass (P2-8) | P2 | An unclaimed differentiator |
| 19 | Coordinate formats (P1-9) | P1 | SAR and backcountry users expect MGRS and UTM |
| 20 | Battery-optimisation check (P1-10) | P1 | Prevents "no notifications" reports |
| 21 | Connector split (P2-10) | P2 | Enables P3-2 and lowers regression risk |
| 22 | Waypoints, GPX import, routes (P2-6) | P2 | Closes the gap with MeshTrax and TEAM |
| 23 | Reactions airtime mode (P2-9) | P2 | Regulatory hygiene in the EU |
| 24 | Network change alerts and repeater ranking (P2-4) | P2 | Network intelligence lead |
| 25 | Honest privacy page (P2-11) | P2 | Trust |

---

## 7. Quick wins

Each needs no architectural change and is roughly 1 PR of ≤ 1 day:

1. Change the iOS bundle ID (P0-5).
2. TCP reconnect: reuse the Bluetooth backoff path for `MeshCoreTransportType.tcp` (part of P0-2).
3. A max-length send regression test over a small MTU (part of P0-4).
4. Back-in-range alerts for favourites (P1-4).
5. A battery-optimisation check (P1-10).
6. MGRS/UTM display and copy (P1-9).
7. A reactions local-only toggle (P2-9).
8. A basic RX log list from data already parsed; the inspector can come later (first half of P1-2).
9. A path-hash-size badge on node rows.
10. A remote CLI timeout scaled by hop count (P1-7).

---

## 8. Strategic competitive scoring

**Method.** Each 0 to 10 score measures **documented capability coverage** in that area, judged from the matrix. It is **not** measured quality: no competitor was tested hands-on, and NOTORYX itself lacks field validation. Where nothing was known, the cell is **—** rather than a guess. Confidence: **H** source-verified, **M** README or changelog, **L** third-party report.

**Rubric** (per area):
- 0–2: absent
- 3–4: basics only
- 5–6: solid basics plus a few extras
- 7–8: broad, with distinctive tools
- 9–10: best in class across the area, with evidence it works

**Reliability and performance can't score above 6 without field or benchmark evidence.**

| Area | NOTORYX now | Official | MeshCore Open | MeshCore One | MeshTrax | MeshCore Companion | mesh-client |
|---|---|---|---|---|---|---|---|
| 1 Ease of use | 6 (M) | 7 (L): onboarding v1.45, community default | 5 (M) | 6 (M) | 7 (M): unified inbox | 6 (M) | 5 (M) |
| 2 Messaging | 8 (H) | 7 (M) | 7 (M) | 8 (M) | 7 (M) | 8 (M) | 6 (M) |
| 3 Connectivity reliability | 5 (H): Bluetooth-only reconnect, unvalidated | 6 (L): v1.46 iOS fix, Wi-Fi reconnect | 4 (M): #58, #486 | — | 5 (M) | 6 (M): 24/7 bridge | 4 (M): #426, #1142 |
| 4 Mapping | 7 (H) | 6 (M) | 6 (M) | 5 (M) | 9 (M): topo, routing, POI | 2 (M) | 4 (M) |
| 5 Network diagnostics | 8 (H) | 6 (M) | 5 (M) | 8 (M) | 3 (M) | 9 (M) | 7 (M) |
| 6 Advanced features | 9 (H) | 6 (M) | 6 (M) | 6 (M) | 5 (M) | 6 (M) | 8 (M): multi-protocol |
| 7 Performance | 4 (H): SharedPreferences storage, 9k-line connector | — | 4 (M): #202 CPU | — | — | — | — |
| 8 Accessibility | 6 (H): Okabe-Ito, 18 languages, thin semantics | 5 (L): many languages | 4 (M) | 3 (L): English only | 5 (M) | — | 4 (M) |
| 9 Privacy and security | 7 (H): keychain, opt-ins, signed posts | 5 (L) | 5 (M) | 6 (M) | 5 (M) | 5 (M): self-hosted | 6 (M): key backup |
| 10 Overall functionality | 8 (H) | 7 (M) | 6 (M) | 7 (M) | 6 (M) | 6 (M) | 7 (M) |
| **Reach (not scored, context)** | Android APK, Mac | All platforms + stores | All platforms, Play | App Store | 3 stores | Self-host | Desktop |

**NOTORYX's realistic potential after P0 and P1:**
- Connectivity reliability 5 → **8**, once reconnect covers every transport and is field-validated.
- Performance 4 → **6**, with SQLite.
- Network diagnostics 8 → **9**, with delivery diagnosis and the RX log.
- Ease of use 6 → **7**, with guided troubleshooting and the readiness check.
- Accessibility 6 → **8**, after the accessibility pass.

Its **reach is the gap no feature closes**. Without TestFlight and a store listing, the official app stays the default.

---

## 9. Executive summary

**Which application is currently the strongest competitor?**
The **official MeshCore app** (Liam Cottle, v1.51.0, 2026-11-04). It's on every platform including iOS and the web, it's the community default, and it ships every few weeks. For iOS specifically, **MeshCore One** is the strongest open-source rival.

**What does it do better than NOTORYX Core?**
- Availability (iOS, web, stores).
- Default status and trust.
- A SQLite store with database export.
- A tested first-run onboarding.
- Wi-Fi auto-reconnect.
- Web push.
- Fast parity with new firmware features, since it ships alongside them.

**What does NOTORYX Core already do better?**
- Safety and trips: SOS, signed SOS, SOS relay, check-ins, overdue alerts.
- MQTT bridging with radio-signed auth.
- Network scan and location-aware regional presets.
- Path graph, Route Intelligence and Observer reach.
- Wardrive and coverage hexes.
- Free, complete repeater admin including ACLs.
- Bot Mode, the Android widget, 18 languages, and color-blind-safe design.

**What are the biggest gaps in the market?**
1. Explaining *why* a message failed, on the phone, offline.
2. Connections that heal on every transport without the user noticing.
3. A pre-trip readiness check.
4. Repeater owner care: battery watch, history, gone-quiet alerts.
5. Screen-reader-grade accessibility.
6. Trustworthy open distribution (F-Droid-class).

**Which competitor features should NOTORYX Core improve upon?**
- MeshCore Companion's delivery diagnostics and link health.
- MeshCore One's RX log and telemetry charts.
- mesh-client's graded health band.
- MeshTrax's coordinate formats and waypoint tools.
- MeshCore TEAM's shared waypoints and routes.
- MCO Advanced's lite/full build flavors.

**Which innovations could make NOTORYX Core stand out?**
- A delivery diagnosis timeline.
- A trip readiness check.
- Route health scores with predictive warnings.
- A graded mesh health card.
- Guided troubleshooting that runs live checks.

All are buildable **in the app on stock firmware**.

**What should be built first?**
P0-1 to P0-5 (storage, reconnect, validation, regression tests, iOS ID), then P1-1 (delivery diagnosis).

**What should NOT be built?**
- **Voice clips:** airtime-heavy and a duty-cycle risk.
- **Games** (chess, Pokémon): airtime with no safety value.
- **More themes**: five is enough.
- **Meshtastic or Reticulum in Core**: NOTORYX Connect and Notoryx-World already cover other protocols; keep Core focused.
- **Cloud sync of messages**: breaks the offline and privacy promise.
- **More on-device AI features**: ship a lite flavor instead.
- **Any feature that transmits automatically without an airtime budget.**

**What are the five most important actions to take immediately?**
1. **Migrate message storage to SQLite** with a verified, reversible migration (P0-1).
2. **Make reconnect work on Bluetooth, TCP and USB**, and confirm it on a real Android phone with the connection log (P0-2).
3. **Run and record the real-radio validation matrix**, starting with SOS, SOS relay and check-ins (P0-3).
4. **Fix the iOS bundle ID and get a TestFlight build out** (P0-5 → P1-5).
5. **Ship the delivery diagnosis sheet**, the single most valuable differentiator, using data the app already collects (P1-1).
