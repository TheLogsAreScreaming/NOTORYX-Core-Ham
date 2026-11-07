# NOTORYX Core: competitive intelligence report

**Research date:** 2026-11-07
**NOTORYX Core build audited:** `dev` at `21e5f380` (10.0.0-rc.33+85)
**Scope:** research only. No application code was changed for this report.
**Companion files:** [FEATURE_MATRIX.md](FEATURE_MATRIX.md), [feature_matrix.json](feature_matrix.json), [COMPETITIVE_ROADMAP.md](COMPETITIVE_ROADMAP.md)

---

## 0. Method and limits

**What was done**

- Read the NOTORYX Core source on `dev` (116k lines of Dart outside `l10n/`, 162 test files, about 1,236 `test`/`testWidgets` cases) and its docs (`README.md`, `BASTION_ROADMAP.md`, `docs/BASTION_FIELD_VALIDATION.md`).
- Built the competitor list from the [awesome-meshcore](https://github.com/samuk/awesome-meshcore) index, the [MeshCore firmware README](https://github.com/meshcore-dev/MeshCore), and the [mesh-sn.de app comparison (2026-04-07)](https://mesh-sn.de/en/news/details/meshcore-companion-apps-at-a-glance-meshcore-meshos-and-meshcore-one-for-ios-and-android). Then checked each competitor with the GitHub API (stars, last push, license, latest release) and its README.
- Read the official app's public changelog ([app.meshcore.nz/assets/CHANGELOG.md](https://app.meshcore.nz/assets/CHANGELOG.md), 816 lines, v1.0 to v1.51.0).
- Pulled the most-discussed and most-upvoted GitHub issues from six competitor repos and from the MeshCore firmware repo, as evidence of real user problems.

**What was not done (limits)**

- **No hands-on testing of competitor apps.** Every competitor feature below comes from its own README, changelog, store listing or issue tracker. A listed feature may be buggy or unfinished, and an unlisted one may still exist.
- **Reddit and app-store reviews weren't usable.** Web search returned nothing relevant for MeshCore on Reddit, and app-store review text couldn't be fetched. User complaints come from GitHub issues, which skew toward technical users.
- **Proprietary apps** (the official app, MeshOS, Nelos, KIEKR, meshGO!, MeshMapper) can only be judged from changelogs, listings and third-party write-ups.
- **NOTORYX Core features** were checked in source. A feature present in code is not proof that it works on a real radio. The repo's own [field validation doc](../BASTION_FIELD_VALIDATION.md) lists every physical test as still required.

**Labels used in this report**

- **Verified (source):** seen in code or an official repo or changelog on the research date.
- **Reported:** a third party says so (an article or an issue), not checked further.
- **Unverified:** a claim that could not be confirmed.

---

## 1. Ecosystem map

The MeshCore app ecosystem is far bigger than it looks from the app stores. awesome-meshcore lists about 60 clients. Most are small, AI-assisted, single-developer projects. Only about ten are serious enough to compete with NOTORYX Core for users today.

### 1.1 Tier 1: MeshCore phone and desktop companions (direct competitors)

| # | App | Developer | Platforms | License | Latest verified release | Activity (GitHub) |
|---|---|---|---|---|---|---|
| 1 | **MeshCore (official app)** | Liam Cottle | Android, iOS, web ([app.meshcore.io](https://app.meshcore.io/)), Windows, macOS, Linux | Proprietary, freemium | v1.51.0, 2026-11-04 ([changelog](https://app.meshcore.nz/assets/CHANGELOG.md)) | Closed source; releases about every 2 to 6 weeks |
| 2 | **MeshCore Open** | zjs81 | Android, iOS, macOS, Windows, Linux, web (Flutter) | MIT | BETA-99.0.1, 2026-10-31 | [653★, 109 open issues, pushed 2026-11-07](https://github.com/zjs81/meshcore-open) |
| 3 | **MeshCore One (MC1)**, formerly PocketMesh | Avi0n | iOS, iPadOS, Apple-silicon Mac (Swift) | GPL-3.0 (app), MIT (Swift library) | v1.6.2, 2026-11-01; on the App Store | [205★, 95 open issues, pushed 2026-11-06](https://github.com/Avi0n/MeshCoreOne) |
| 4 | **MeshOS** | Andy Kirby | Android app plus standalone T-Deck firmware | Proprietary (£8 per device firmware license) | v0.4.3 (reported, April 2026) | Closed source. Reported by [mesh-sn.de](https://mesh-sn.de/en/news/details/meshcore-companion-apps-at-a-glance-meshcore-meshos-and-meshcore-one-for-ios-and-android), not re-verified |
| 5 | **MeshTrax** | venamartin | Android, iOS, Windows (all three stores), Linux | MIT | v1.10.0, 2026-11-06 | [13★, pushed 2026-11-07](https://github.com/venamartin/meshtrax) |
| 6 | **Offband Meshcore** | OffbandMesh | Android (Flutter, MeshCore Open lineage) | MIT | v1.7.0, 2026-10-27 | [11★, 356 open issues (used as a work tracker)](https://github.com/OffbandMesh/meshcore-client) |
| 7 | **MCO Advanced (MCOa)** | HDDen | Android, iOS, Windows, Linux (MeshCore Open fork) | MIT | 9.5.0-mod-1.12.0, 2026-10-29 | [6★, pushed 2026-11-06](https://github.com/HDDen/meshcore-open) |
| 8 | **MeshCore TEAM** | tmacinc | Android (Play), Flutter | Custom (NOASSERTION) | 1.2.0-beta6, 2026-10-22 | [24★, 20 open issues](https://github.com/tmacinc/MeshCore-TEAM) |
| 9 | **MeshCore SAR** | dz0ny | Android, iOS (TestFlight), desktop | No license file | No GitHub releases | [164★, last push 2026-09-18](https://github.com/dz0ny/meshcore-sar) |
| 10 | **mesh-client** | Colorado-Mesh | Windows, macOS, Linux (Electron); MeshCore, Meshtastic and Reticulum | GPL-3.0 | v6.6.0, 2026-11-03 | [146★, pushed 2026-11-07](https://github.com/Colorado-Mesh/mesh-client) |
| 11 | **MeshCore Companion** | edleeman17 | Self-hosted bridge plus web UI (PWA), any browser | MIT | v1.21.2, 2026-11-06 | [1★, pushed 2026-11-06](https://github.com/edleeman17/meshcore-companion) |

### 1.2 Tier 2: smaller or niche MeshCore clients (for ideas, not users)

| App | Platform | Notes | Source |
|---|---|---|---|
| meshcore-mobile-app (thatSFguy) | Android, Kotlin, AGPL-3.0 | Hardened, no Google Play Services | [repo](https://github.com/thatSFguy/meshcore-mobile-app) |
| SigurdOS Client | MeshCore Open fork | **Archived** on GitHub | [repo](https://github.com/hermes-gadget/SigurdOS-client) |
| PommeCore | iOS, SwiftUI | 3★ | [repo](https://github.com/mbedworth/PommeCore) |
| meshcore-gui | Desktop, Python, BLE | 32★ | [repo](https://github.com/pe1hvh/meshcore-gui) |
| QMeshcoreApp | Qt6/QML desktop | Last push 2026-01 | [repo](https://github.com/FelixvdDonk/QMeshcoreApp) |
| MC-WebUI | Web UI over meshcore-cli | 67★ | [repo](https://github.com/MarekWo/mc-webui) |
| meshtui, MeshTerm, tui-meshcore, MeshChaTUI, meshssi, QTC | Terminal clients | meshtui 43★ | [awesome-meshcore](https://github.com/samuk/awesome-meshcore) |
| Mycelium, MeshCorium, meshcore-webui, meshcore-web (aXistem), MeshConsole | Browser clients | Small | [awesome-meshcore](https://github.com/samuk/awesome-meshcore) |
| meshy (GTK4), MeshApp, PyMeshCoreGUI, mcIRC, MeshCoreQt, MeshCore Insights | Desktop | Small | [awesome-meshcore](https://github.com/samuk/awesome-meshcore) |
| Nelos, KIEKR, meshGO! | Proprietary | Nelos: people/pet tracking with offline maps; KIEKR: community toolbox | [awesome-meshcore](https://github.com/samuk/awesome-meshcore) |
| Sestriere (Haiku), MeshCore64 (C64), PicoMeshCore (MMBasic) | Novelty platforms | Not competitors | [awesome-meshcore](https://github.com/samuk/awesome-meshcore) |

### 1.3 Mapping, wardrive, analytics and admin tools

| Tool | What it does | Source |
|---|---|---|
| map.meshcore.io | Official public node map; owners self-report radio settings | NOTORYX already uses it for `regional_presets.json` v2 |
| config.meshcore.io | Official USB config tool for repeaters and room servers | [MeshCore README](https://github.com/meshcore-dev/MeshCore) |
| MeshCore Flasher | Official web flasher | [meshcore.io/flasher](https://meshcore.io/flasher) |
| Meshcore-Wardrive-Android (mintylinux) | Flutter wardrive and coverage app, 109★ | [repo](https://github.com/mintylinux/Meshcore-Wardrive-Android) |
| MeshMapper | Proprietary wardrive app | [Play](https://play.google.com/store/apps/details?id=net.meshmapper.app) |
| CoreScope | Packet analyzer, GPL-3.0, 207★ | [repo](https://github.com/Kpa-clawbot/CoreScope); NOTORYX uses it for Observer reach |
| meshcoretomqtt | Community observer-to-MQTT uploader, 114★ | [repo](https://github.com/Cisien/meshcoretomqtt); NOTORYX speaks its format |
| LetsMesh analyzer, MeshRank | Community MQTT analyzers | NOTORYX ships presets for both |
| meshcore-cli / meshcore_py / meshcore.js | Official libraries (212★ / 121★ / 51★) | [meshcore-dev](https://github.com/meshcore-dev) |
| meshcore-ha | Home Assistant integration, 282★ | [repo](https://github.com/meshcore-dev/meshcore-ha) |
| meshcore-bot (agessaman) | Python bot with Discord and Telegram bridging, 212★ | [repo](https://github.com/agessaman/meshcore-bot) |
| Remote Terminal for MeshCore | Repeater remote terminal with packet capture | [repo](https://github.com/MichTronics/Remote-Terminal-for-MeshCore) |

### 1.4 Meshtastic and Reticulum (not MeshCore; ideas only)

These apps speak **other protocols**. Their features are listed for design ideas only. Meshtastic modules such as Store & Forward, Range Test and Neighbor Info are **firmware features that MeshCore doesn't have**, and can't be copied into a MeshCore app.

| App | Version / activity | Ideas worth studying | Source |
|---|---|---|---|
| Meshtastic Android | v2.8.3, 2026-10-19, 1,913★, GPL-3.0 | In-app **firmware update**, waypoint **geofence alerts**, **Site Planner** coverage (ITU-R P.1812, on device), home-screen widget, local TAK server, onboarding module, Obtainium links | [repo](https://github.com/meshtastic/Meshtastic-Android) |
| Meshtastic Apple | 961★, GPL-3.0 | **CarPlay and Siri**, **Apple Watch** with fox-hunt compass, compact node list for meshes over 100 nodes, **Local Mesh Discovery** (cycles modem presets to audit the RF environment), offline in-app docs | [repo](https://github.com/meshtastic/Meshtastic-Apple) |
| Meshtastic Web | 875★ | Browser client over Web Bluetooth and serial | [repo](https://github.com/meshtastic/web) |
| MeshMonitor | v4.17.2, 2026-11-03, 723★ | Self-hosted monitor, multi-source, SSO and proxy auth, desktop tray apps | [repo](https://github.com/Yeraze/meshmonitor) |
| Sideband / Reticulum MeshChat | 1,904★ / 1,322★ | Propagation-node store and forward, paper messages, full offline-first design | [Sideband](https://github.com/markqvist/Sideband), [MeshChat](https://github.com/liamcottle/reticulum-meshchat) |

---

## 2. Competitor profiles

### 2.1 MeshCore official app (Liam Cottle): the strongest competitor

- **Why it's the strongest:** every platform (including iOS and the web), the community default, fast releases, and the author is close to the firmware project. Recent releases ([changelog](https://app.meshcore.nz/assets/CHANGELOG.md)):
  - **v1.51.0 (2026-11-04):** quick (canned) messages, a jump-to-my-GPS map button, a companion buzzer toggle (needs firmware v1.19), configurable direct and flood retry counts (now 4 + 4), a "they must add you first" banner, cancelling retries, forgetting the last advert, deep-link contact add, hop count and path hash shown under channel messages.
  - **v1.50.0:** remote command line to other companions with a permission flag, local companion CLI (firmware v1.18), Wi-Fi settings, region scopes in config import and export.
  - **v1.49.0:** trace the current path to a repeater, region names on received channel messages, repeater network settings (path hash size, default scope).
  - **v1.48.0:** resume a repeater session without logging in again, **web push notifications**, all telemetry on one page.
  - **v1.47.0:** map tab in the path viewer, `meshcore://` links from other apps, scanning MeshCore QR codes with the system camera, region scopes inside channel QR codes.
  - **v1.46.0:** "significantly improved background bluetooth connections on ios by fixing bug with ble state restoration", auto-delete of channel messages.
  - **v1.45.0:** new onboarding for first device setup. **v1.44.0:** USB on desktop, **Wi-Fi auto-reconnect checkbox**, redesigned composer. **v1.43.0:** **export the app's SQLite database**, message search.
- **Weaknesses:**
  - Closed source.
  - **Remote management over RF is freemium**: a fee removes the wait time ([mesh-sn.de](https://mesh-sn.de/en/news/details/meshcore-companion-apps-at-a-glance-meshcore-meshos-and-meshcore-one-for-ios-and-android)).
  - Reported iOS Bluetooth drops that "can drop for hours without the user noticing" (mesh-sn.de, April 2026). v1.46 claims a fix.
  - No RX log, and CLI access only indirect (mesh-sn.de, April 2026; v1.50 later added a local companion CLI).
  - No SOS, check-in or trip features in the changelog. No MQTT, wardrive, coverage hexes or network scan in the changelog.
- **Where NOTORYX Core is already ahead:** safety tools (SOS, signed SOS, SOS relay, check-ins, trips), MQTT bridging, wardrive and coverage, network scan, regional presets by location, path graph and Route Intelligence, Bot Mode, free remote administration, the Android widget, the color-blind-safe theme.
- **Where it beats NOTORYX Core:** iOS and web availability, store distribution, community trust and default status, a SQLite message store, a polished first-run flow, Wi-Fi auto-reconnect, and web push.

### 2.2 MeshCore Open (zjs81)

- **What it is:** NOTORYX Core's own upstream. NOTORYX was about 68% MeshCore Open code by blame in a 2026-11-05 audit.
- **Features:** an MIT Flutter app on every platform. Mesh images with recovery packets, a learned **message filter** (spam), regions, on-device translation, contact groups, reactions and replies, MGRS coordinates, Stadia offline maps, and a repeater hub ([README](https://github.com/zjs81/meshcore-open)).
- **Weaknesses:**
  - Its README says storage is "JSON in SharedPreferences for messages and contacts". NOTORYX Core inherited this.
  - [#202 "Uses a lot of CPU on Linux"](https://github.com/zjs81/meshcore-open/issues/202).
  - [#58 Android foreground service](https://github.com/zjs81/meshcore-open/issues/58) (25 comments, still open).
  - [#113 F-Droid request](https://github.com/zjs81/meshcore-open/issues/113) (10 reactions).
  - [#421 2-byte address request](https://github.com/zjs81/meshcore-open/issues/421) (16 reactions, the most-upvoted open issue).
  - [#486 auto-connect to the last radio](https://github.com/zjs81/meshcore-open/issues/486).
  - [#348 graphing telemetry from repeaters](https://github.com/zjs81/meshcore-open/issues/348).
  - [#119 more than one radio at a time](https://github.com/zjs81/meshcore-open/issues/119).
  - [#508 no Windows binaries](https://github.com/zjs81/meshcore-open/issues/508).
  - [#109 reactions waste airtime and risk EU duty-cycle limits](https://github.com/zjs81/meshcore-open/issues/109).
- **NOTORYX Core vs MeshCore Open:** NOTORYX already has a foreground service, auto-connect, multi-byte path handling, and many modules MeshCore Open lacks. It shares the storage weakness.

### 2.3 MeshCore One (Avi0n): the strongest open-source iOS client

- **Features:** native Swift on the App Store ([README](https://github.com/Avi0n/MeshCoreOne)): DMs with flood retry, heard-repeats tracking, @mentions, per-conversation notification levels, blocking of contacts and channel senders, Trace Path with saved paths, **Line of Sight with Fresnel zones**, **live RX log**, **noise floor monitor**, a CLI terminal, remote repeater configuration, **telemetry history charts**, battery OCV curves, **Live Activity**, push notifications with quick reply, and backup and restore.
- **Weaknesses:**
  - "almost all code is created with AI" (its README). No independent security audit.
  - iOS 18+ only.
  - Issues: [#283 ACKs for DMs not stable](https://github.com/Avi0n/MeshCoreOne/issues/283), [#458 help with failing DMs (delivery diagnosis)](https://github.com/Avi0n/MeshCoreOne/issues/458), [#386 location not updating from telemetry](https://github.com/Avi0n/MeshCoreOne/issues/386), [#252 iCloud sync](https://github.com/Avi0n/MeshCoreOne/issues/252), [#420 FCC-compliant US/Canada preset](https://github.com/Avi0n/MeshCoreOne/issues/420) (21 comments), [#461 Siri](https://github.com/Avi0n/MeshCoreOne/issues/461).
- **Threat:** if NOTORYX Core ships on iOS, this is the app iOS users compare it with.

### 2.4 MeshOS (Andy Kirby)

- Reported features: an Android app that also runs as T-Deck and T-Lora-Pager firmware, a multibyte path viewer, signal bars, no Google services needed, and sideloading onto keyboard phones. The firmware is £8 per device. No iOS. All of this is from [mesh-sn.de](https://mesh-sn.de/en/news/details/meshcore-companion-apps-at-a-glance-meshcore-meshos-and-meshcore-one-for-ios-and-android) and was not re-verified.

### 2.5 MeshTrax (venamartin)

- **Features** ([README](https://github.com/venamartin/meshtrax)): a unified Signal-style inbox, offline **USGS topo, contours, hillshade and NOAA charts**, offline **trail routing** with climb and elevation profile, offline POI search with Wikipedia text, **seven coordinate formats** (UTM, MGRS, Maidenhead and others), moderation (block and report), auto-connect, and a foreground service.
- **Distribution:** in the Google Play, App Store and Microsoft Store.
- **Threat:** it already does the best "backcountry map" work in the MeshCore space. That overlaps with NOTORYX's outdoor positioning.

### 2.6 Offband Meshcore

- **Features:** from the MeshCore Open lineage, but the README says it moved to "Local SQLite database for messages and contact data".
- **Issue tracker:** it's the best public record of the bugs a MeshCore Open-derived app hits on real radios:
  - [#334 SharedPreferences used as a database, all work on the UI isolate](https://github.com/OffbandMesh/meshcore-client/issues/334)
  - [#395 DM send wedges after a max-length message (BLE 170 > 169 write rejected)](https://github.com/OffbandMesh/meshcore-client/issues/395)
  - [#592 BLE composer limited by an MTU cap](https://github.com/OffbandMesh/meshcore-client/issues/592)
  - [#689 Android disconnect leaves the radio held, so it stops advertising](https://github.com/OffbandMesh/meshcore-client/issues/689)
  - [#838 long sessions drift from radio truth (~500 contacts shown that the radio doesn't have)](https://github.com/OffbandMesh/meshcore-client/issues/838)
  - [#660 contacts and favourites disappearing on RAK4630](https://github.com/OffbandMesh/meshcore-client/issues/660)
  - [#240 repeater routing breaks on 2-byte nets](https://github.com/OffbandMesh/meshcore-client/issues/240)
  - [#473 remote CLI timeouts far too short](https://github.com/OffbandMesh/meshcore-client/issues/473)
  - [#110 RAK3401 BLE session re-init loop](https://github.com/OffbandMesh/meshcore-client/issues/110)
  - [#647 FCC-compliant US preset](https://github.com/OffbandMesh/meshcore-client/issues/647)

  **NOTORYX Core shares the code lineage, so each of these is a test case worth checking** (see the roadmap).

### 2.7 MCO Advanced (HDDen)

- **Features** ([README](https://github.com/HDDen/meshcore-open)):
  - Three text compression schemes (cyr2lat, MCMP, MCOtxt).
  - Ed25519-signed messages.
  - Exact quotes and precise replies, text formatting.
  - **MCOimg** one-packet images with a canvas editor.
  - Built-in wardrive.
  - **Live path tracing** with per-hop SNR.
  - **Delivery progress for DMs**.
  - Last-hop signal on channel posts.
  - Scheduled or delayed send.
  - Channel groups and custom ordering.
  - A portable data folder.
  - **Lite, lite-aeic and full build flavors**, so users who don't want the on-device LLM get a smaller binary.
- **Lesson for NOTORYX Core:** NOTORYX bundles `llamadart` and `flutter_onnxruntime` in one build. A lite flavor is a proven pattern.

### 2.8 MeshCore TEAM (tmacinc)

- **Features** ([README](https://github.com/tmacinc/MeshCore-TEAM)): team location tracking to a private channel, contact path history trails, **waypoints and multi-point routes shared over the mesh**, **KMZ raster overlays** (Garmin-style custom maps), a red-light night mode that also red-filters map tiles, a phone or radio GPS source, and auto-purge of stale contacts. It also has app-managed "smart forwarding" and an "autonomous mode" that needs its own firmware.

### 2.9 MeshCore SAR (dz0ny)

- **Features:** Codec2 voice clips, AVIF images, SAR incident markers, tactical drawings and team trails ([README](https://github.com/dz0ny/meshcore-sar)).
- **Weaknesses:**
  - No license file, so it can't legally be reused.
  - No releases; the TestFlight is full ([#42](https://github.com/dz0ny/meshcore-sar/issues/42)).
  - [#45 Heltec V4 transmits constantly](https://github.com/dz0ny/meshcore-sar/issues/45).
  - [#40 DMs hit and miss](https://github.com/dz0ny/meshcore-sar/issues/40).
  - Last push 2026-09-18.

### 2.10 mesh-client (Colorado-Mesh)

- **Features:** an Electron desktop app for MeshCore, Meshtastic and Reticulum ([README](https://github.com/Colorado-Mesh/mesh-client)). SQLite history with retention, a **Diagnostics tab with a Healthy / Attention / Degraded health band**, routing-error counts, "foreign LoRa overhear" classification, MQTT profiles, and **per-node key backup and restore**.
- **Issues:**
  - [#426 Linux BLE: first message after every connect dropped](https://github.com/Colorado-Mesh/mesh-client/issues/426)
  - [#1142 Windows 11 Bluetooth not working](https://github.com/Colorado-Mesh/mesh-client/issues/1142)
  - [#289 Repeater unreachable: permanent wrong path](https://github.com/Colorado-Mesh/mesh-client/issues/289)
  - [#369 Client sending excess packets](https://github.com/Colorado-Mesh/mesh-client/issues/369)
  - [#223 path history and weighted scoring](https://github.com/Colorado-Mesh/mesh-client/issues/223)

### 2.11 MeshCore Companion (edleeman17): the diagnostics benchmark

It has only 1★, but it has the clearest ideas in the ecosystem about explaining what the mesh is doing ([README](https://github.com/edleeman17/meshcore-companion)):

- Every failed DM says whether it **"reached the mesh (no receipt)" or "never got repeated"**.
- A **journey diagram** per message (you → repeaters → them), each leg coloured by what is actually known.
- A repeat counter on channel posts: "↺ 2 repeats via X, Y".
- A **Link health card** graded good / ok / bad in plain words.
- **Airtime against the 10% EU duty-cycle limit**.
- A **packet inspector** (hex plus decoded fields).
- **Repeater battery watch**: polls every 3 h and notifies below a threshold.
- **Back-in-range alerts** for favourites not heard for 6+ h.
- Self-managing contacts: evicts the least recently heard when the radio table is nearly full.
- The radio clock is synced on every connect.

Its architecture is a 24/7 bridge (radio plus server), which is different from a phone app. **The ideas transfer; the architecture doesn't.**

---

## 3. Recurring weaknesses across the ecosystem

The full prioritised list is in [COMPETITIVE_ROADMAP.md §2](COMPETITIVE_ROADMAP.md#2-competitor-weakness-report). In short:

1. **Bluetooth fragility is the top complaint everywhere.** It shows up in the official app on iOS (mesh-sn.de; fixed in v1.46 by its own account), mesh-client (#426, #1142), Offband (#110, #395, #592, #689) and firmware crashes on Bluetooth disconnect ([MeshCore #1067](https://github.com/meshcore-dev/MeshCore/issues/1067) with 63 comments, [#1166](https://github.com/meshcore-dev/MeshCore/issues/1166) with 52).
2. **Users can't tell why a DM failed.** See MC1 #283 and #458, [MeshCore #1834 "failed delivery but still received"](https://github.com/meshcore-dev/MeshCore/issues/1834), MeshCore SAR #40, MeshCore Open #176, and the [MeshCore #1342 retransmission proposal](https://github.com/meshcore-dev/MeshCore/issues/1342). Only MeshCore Companion explains the failure stage.
3. **SharedPreferences as a database** in every MeshCore Open-derived app (MeshCore Open README, Offband #334, MeshCore Open #202 CPU).
4. **Distribution:** F-Droid and IzzyOnDroid requests (MeshCore Open #113, wardrive #18), Play Store requests (MeshCore Open #323, Offband #159), Windows binaries (MeshCore Open #508), a full TestFlight (MeshCore SAR #42).
5. **2-byte and multi-byte path confusion** (MeshCore Open #421, Offband #240 and #150, official v1.50 "tracing 3byte paths is not supported by protocol").
6. **Repeater remote admin is slow or flaky** (Offband #473 timeouts, [MeshCore #236 first message to a room after login always fails](https://github.com/meshcore-dev/MeshCore/issues/236), [MeshCore #983](https://github.com/meshcore-dev/MeshCore/issues/983)) and **paywalled** in the official app.
7. **Contact table truth:** the app and the radio disagree (Offband #838, #660), and tables fill up.
8. **Regulatory presets:** US/FCC compliance is the top preset ask (MC1 #420, Offband #647).
9. **Reactions and replies interoperability and airtime** (MeshCore Open #109 and #521, MC1 #298).
10. **Protocol security concerns** are open upstream ([MeshCore #259 "Security issues in encryption!"](https://github.com/meshcore-dev/MeshCore/issues/259), 93 comments). An app can't fix this, but it can be honest about it.

---

## 4. NOTORYX Core internal audit (summary)

The full detail is in [COMPETITIVE_ROADMAP.md §4](COMPETITIVE_ROADMAP.md#4-notoryx-core-internal-audit).

**Architecture**

- Flutter with Provider and ChangeNotifier.
- One connector class, [`lib/connector/meshcore_connector.dart`](../../lib/connector/meshcore_connector.dart), of **9,181 lines**: the main source of technical debt.
- 64 screens, 100+ services, and 15 storage classes on `shared_preferences`.

**Strengths, verified in source**

- **Safety:** SOS, signed SOS (GRP_DATA 0xAE51), SOS relay, check-ins and trips.
- **Mesh tools:** network scan, regional presets by location, path graph and Route Intelligence, Observer reach, coverage hexes, wardrive, antenna coverage, line of sight.
- **MQTT:** multi-broker MQTT with keychain credentials and LetsMesh radio-signed auth.
- **Repeaters:** repeater access control, companion CLI, flood corridor.
- **Other features:** Bot Mode, the Android widget, encrypted backup.
- **Reach and quality:** 18 languages, Okabe-Ito color-blind-safe palette, red-light theme, and about 1,236 tests with `--fatal-infos` CI.

**Weaknesses, verified in source**

1. **Message history is JSON in SharedPreferences.** [`message_store.dart:28-29`](../../lib/storage/message_store.dart) re-encodes the whole list on every save. It's the same pattern Offband had to replace (#334).
2. **Auto-reconnect only covers Bluetooth.** `_shouldAutoReconnect` requires `_activeTransport == MeshCoreTransportType.bluetooth` ([`meshcore_connector.dart:3154`](../../lib/connector/meshcore_connector.dart)), so TCP and USB drops aren't retried. The official app added Wi-Fi auto-reconnect in v1.44.
3. **The iOS bundle ID is still upstream's** (`com.monitormx.meshcoreopen` in `ios/Runner.xcodeproj/project.pbxproj`). It would collide with MeshCore Open and must change before any iOS distribution.
4. **No firmware update, no RX log or packet inspector screen** (raw RX is already parsed through `LOG_RX_DATA`), **no telemetry history charts, no MGRS/UTM, no GPX import, waypoints or routes, no sender blocking, no @mention autocomplete, no multiple radios, no app lock.**
5. **Thin accessibility semantics:** 65 `Semantics(` uses across 116k lines, and one `TextScaler` reference. There is a chat text-scale service. Contrast tests exist for themes.
6. **No physical-device validation recorded.** Every row in [BASTION_FIELD_VALIDATION.md](../BASTION_FIELD_VALIDATION.md) is still "required". SOS relay is "not yet field-tested on radios" (README).
7. **Bundle weight:** `llamadart` and `flutter_onnxruntime` ship in every build. They also make an F-Droid listing harder (prebuilt native libraries).

---

## 5. Answers in brief

The full executive summary is in [COMPETITIVE_ROADMAP.md §9](COMPETITIVE_ROADMAP.md#9-executive-summary).

- **Strongest competitor:** the official MeshCore app (platform reach, trust, release cadence).
- **Strongest open-source threats:** MeshCore One on iOS, MeshTrax for outdoor maps, and MeshCore Open as the upstream that keeps improving.
- **NOTORYX Core's clear lead:** safety and trip tools, MQTT, network and coverage intelligence, free remote admin, color-blind design, and breadth.
- **Biggest market gaps:**
  1. Explaining delivery failures on the phone, offline.
  2. Bluetooth that recovers without the user noticing on every transport.
  3. A pre-trip "am I ready?" check.
  4. Repeater health monitoring for owners.
  5. Honest, F-Droid-grade distribution.
