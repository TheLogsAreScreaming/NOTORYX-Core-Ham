# Master feature comparison matrix

**Research date:** 2026-11-07. Machine-readable copy: [feature_matrix.json](feature_matrix.json) (94 rows, generated from the same data).
Background and sources: [COMPETITIVE_ANALYSIS.md](COMPETITIVE_ANALYSIS.md).

## How to read this

| Code | Meaning |
|---|---|
| **Y** | Implemented. For NOTORYX (NX), verified in source on `dev` `21e5f380`. For others, documented in that project's README, changelog or store listing. |
| **S** | NOTORYX only: implemented, and broader or deeper than any competitor's documented version. |
| **P** | Partial. |
| **N** | Missing. For NOTORYX, searched for in source and not found. For competitors, used only where their own open issue asks for it. |
| **?** | **Not documented by that project.** This is *not* evidence that the feature is missing. |
| **NA** | Not applicable (for example, Android-only features in an iOS-only app). |

**NX vs field:** **S** superior, **=** parity, **I** inferior (at least one competitor documents a better or present version), **U** unverified.

**Totals for NOTORYX across 94 features:** 25 superior, 39 parity, 25 inferior, 4 unverified, 1 not applicable.

**Columns:**
- **NX** NOTORYX Core 10.0.0-rc.33
- **OFF** official MeshCore app v1.51.0 ([changelog](https://app.meshcore.nz/assets/CHANGELOG.md))
- **MCO** MeshCore Open BETA-99.0.1 ([repo](https://github.com/zjs81/meshcore-open))
- **MC1** MeshCore One v1.6.2 ([repo](https://github.com/Avi0n/MeshCoreOne))
- **MTX** MeshTrax v1.10.0 ([repo](https://github.com/venamartin/meshtrax))
- **MCOA** MCO Advanced 9.5.0-mod-1.12.0 ([repo](https://github.com/HDDen/meshcore-open))
- **TEAM** MeshCore TEAM 1.2.0-beta6 ([repo](https://github.com/tmacinc/MeshCore-TEAM))
- **MCC** MeshCore Companion v1.21.2, a web bridge ([repo](https://github.com/edleeman17/meshcore-companion))
- **MSC** mesh-client v6.6.0, desktop ([repo](https://github.com/Colorado-Mesh/mesh-client))

**Caveats:**
- The official app is closed source. Its column only reflects what its changelog mentions, so many basics show **?** even though the app almost certainly has them.
- No competitor app was tested hands-on.
- MeshOS, MeshCore SAR and Offband are left out of the grid because their documentation was too thin, too old or too similar to MeshCore Open. See the analysis for those apps.


### Messaging

| Feature | NX | OFF | MCO | MC1 | MTX | MCOA | TEAM | MCC | MSC | NX vs field | NOTORYX evidence | Note |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|---|
| Direct messages | Y | Y | Y | Y | Y | Y | Y | Y | Y | = | `lib/screens/chat_screen.dart` |  |
| Channels (public/hashtag/private) | Y | Y | Y | Y | Y | Y | Y | Y | Y | = | `lib/screens/channels_screen.dart` |  |
| Delivery status / ACK ticks | Y | Y | Y | Y | Y | Y | ? | Y | Y | = | `lib/widgets/message_status_icon.dart` |  |
| Configurable direct+flood retries | Y | Y | P | Y | Y | ? | ? | Y | ? | = | `lib/services/message_retry_service.dart` | OFF v1.51 4+4; NX has flood-attempts setting (#212) |
| Cancel / stop retrying | Y | Y | ? | ? | ? | ? | ? | ? | ? | = | `README: stop retrying` |  |
| Offline send queue (radio down) | P | P | ? | ? | ? | Y | ? | Y | ? | I | `messages fail when disconnected (no persistent queue); MQTT has offline queue` | MCOA scheduled send; MCC bridge holds radio 24/7 |
| Failed-DM diagnosis (which stage) | P | ? | ? | P | ? | Y | ? | Y | ? | I | `lib/models/delivery_observation.dart, timeout_prediction_service.dart, Observer reach (online only)` | MCC: 'reached mesh' vs 'never repeated'; MC1 #458 open |
| Heard repeats on channel posts | Y | Y | ? | Y | ? | Y | ? | Y | ? | = | `lib/screens/channel_message_path_screen.dart` |  |
| Signed messages / posts | Y | ? | ? | ? | ? | Y | ? | Y | ? | = | `lib/services/signed_posts.dart (Ed25519 via radio key, GRP_DATA 0xAE51)` | MCOA (MCMP v3) and MCC also sign; formats differ, not interoperable |
| Message search | Y | Y | ? | ? | ? | Y | ? | Y | Y | = | `lib/screens/message_search_screen.dart` |  |
| Drafts | Y | Y | ? | ? | ? | ? | ? | ? | ? | = | `lib/storage/draft_store.dart` |  |
| Quick / canned messages | Y | Y | ? | ? | ? | Y | ? | ? | ? | = | `lib/widgets/quick_messages.dart` |  |
| Reactions | Y | ? | Y | Y | Y | ? | ? | ? | ? | = | `lib/helpers/reaction_helper.dart` | airtime/interop concerns MCO #109 |
| Replies / quotes | P | ? | Y | ? | Y | Y | Y | ? | ? | I | `ReplyInfo.parseReplyMention in lib/models/channel_message.dart` | MCOA exact quotes |
| @mention autocomplete | N | Y | ? | Y | ? | Y | Y | Y | ? | I | `not found in composer` | OFF v1.44 auto-space; TEAM autocomplete |
| Block sender / moderation | P | ? | Y | Y | Y | Y | ? | ? | ? | I | `lib/services/inbound_spam_policy.dart (spam rules only; no per-sender block)` |  |
| Images over mesh | Y | ? | Y | Y | ? | Y | ? | ? | ? | = | `lib/services/image_codec_service.dart` |  |
| Translation (on-device) | Y | ? | Y | ? | ? | Y | ? | ? | ? | = | `lib/services/translation_service.dart` |  |
| Read aloud | Y | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/services/read_aloud_service.dart` |  |
| Notifications + per-chat mute | Y | Y | Y | Y | Y | ? | Y | Y | ? | = | `lib/services/notification_service.dart` |  |
| Notification quick reply | ? | ? | ? | Y | ? | ? | ? | ? | ? | U | `not verified in NX` |  |
| Channel directory / discovery | S | ? | ? | ? | ? | ? | ? | Y | ? | S | `lib/screens/channel_directory_screen.dart (+Active online via analyzer)` |  |
| Room servers | Y | Y | Y | Y | ? | ? | ? | Y | ? | = | `lib/widgets/room_login_dialog.dart` |  |

### Mesh networking

| Feature | NX | OFF | MCO | MC1 | MTX | MCOA | TEAM | MCC | MSC | NX vs field | NOTORYX evidence | Note |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|---|
| Node discovery / discovered list | Y | Y | Y | Y | Y | Y | Y | Y | Y | = | `lib/screens/discovery_screen.dart` |  |
| Multi-byte (2-byte) path hashes | Y | Y | P | ? | ? | ? | ? | Y | ? | = | `26 refs to pathHashBytes/hash size` | MCO #421 most-upvoted open issue |
| Path trace / ping | Y | Y | Y | Y | Y | Y | ? | Y | ? | = | `lib/screens/repeater_ping_screen.dart, path_trace_map.dart` |  |
| Path graph / route visualisation | S | Y | Y | Y | ? | Y | ? | Y | ? | S | `lib/screens/path_graph_screen.dart, widgets/path_sankey.dart` |  |
| Route Intelligence (learned routes) | S | ? | P | ? | Y | ? | Y | Y | P | S | `lib/services/path_history_service.dart` | MCO auto route rotation; MSC #223 weighted scoring |
| Network scan across presets | S | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/screens/networks_screen.dart` | Meshtastic Apple has the same idea (Local Mesh Discovery) |
| Noise floor monitor | Y | Y | ? | Y | ? | ? | ? | Y | ? | = | `lib/screens/companion_radio_stats_screen.dart` |  |
| RX log / packet inspector | P | ? | ? | Y | ? | Y | ? | Y | Y | I | `raw RX parsed (models/radio_rx_packet.dart) + BLE debug log; no user packet log/inspector` | mesh-sn.de: official lacks RX log |
| Airtime / duty-cycle meter | P | ? | ? | ? | ? | ? | ? | Y | ? | I | `lib/utils/lora_airtime.dart (estimates), diagnostics screen` |  |
| Mesh health summary | P | ? | ? | ? | ? | ? | ? | Y | Y | I | `lib/screens/bastion_diagnostics_screen.dart (counts, not graded)` | MSC Healthy/Attention/Degraded |
| Observer reach via analyzer | S | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/widgets/observer_reach_sheet.dart, services/corescope.dart` |  |
| Contact table full handling | P | ? | ? | ? | ? | ? | Y | Y | ? | I | `room-left check on multi-add only` | MCC auto-evicts least recent; TEAM auto-purge |
| Repeater remote admin (free) | S | P | Y | Y | ? | Y | ? | Y | ? | S | `lib/screens/repeater_hub_screen.dart` | OFF charges to skip wait |
| Repeater access control (ACL) | S | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/screens/access_control_screen.dart` |  |
| Telemetry history charts | P | Y | ? | Y | ? | ? | ? | Y | Y | I | `lib/services/node_telemetry_store.dart keeps readings; no charts` | MCO #348 requested |
| Repeater battery watch alerts | N | ? | ? | ? | ? | ? | ? | Y | ? | I | `—` |  |
| Back-in-range alerts | P | ? | ? | ? | ? | ? | ? | Y | ? | I | `overdue trip-contact alerts only` |  |
| Regions / scopes | Y | Y | Y | Y | ? | Y | ? | ? | ? | = | `lib/screens/region_management_screen.dart` |  |
| Flood corridor (geo-limited) | S | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/screens/flood_corridor_screen.dart` | needs corridor firmware |
| Multiple radios at once | N | ? | N | ? | ? | ? | ? | ? | Y | I | `—` | MCO #119 requested |
| Firmware update from app | N | ? | ? | ? | ? | ? | ? | ? | ? | I | `—` | Meshtastic apps do this; MC1 listing reportedly ESP32 OTA (unverified) |

### Mapping & location

| Feature | NX | OFF | MCO | MC1 | MTX | MCOA | TEAM | MCC | MSC | NX vs field | NOTORYX evidence | Note |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|---|
| Interactive map | Y | Y | Y | Y | Y | Y | Y | ? | Y | = | `lib/screens/map_screen.dart` |  |
| Offline maps | Y | ? | Y | Y | S | ? | Y | ? | ? | I | `lib/screens/map_cache_screen.dart` | MTX topo/contours/NOAA by region |
| Jump to my GPS | Y | Y | ? | ? | ? | ? | Y | ? | ? | = | `README (rc.23)` |  |
| Track log + GPX export | Y | ? | ? | ? | Y | ? | Y | ? | ? | = | `lib/services/track_log_service.dart, utils/gpx_export.dart` |  |
| GPX/KMZ import, waypoints, routes | N | ? | ? | ? | Y | ? | Y | ? | ? | I | `—` |  |
| Coordinate formats (MGRS/UTM) | N | ? | Y | ? | Y | ? | ? | ? | ? | I | `—` |  |
| Offline trail routing / POI search | N | ? | ? | ? | Y | ? | ? | ? | ? | I | `—` |  |
| Wardrive / coverage capture | S | ? | ? | ? | ? | Y | ? | ? | ? | S | `lib/screens/wardrive_screen.dart, coverage_hex_screen.dart` |  |
| Line of sight / antenna coverage | Y | Y | ? | Y | Y | ? | ? | ? | ? | = | `lib/screens/line_of_sight_map_screen.dart, antenna_coverage_screen.dart` | MC1 Fresnel zone |
| Map telemetry overlays | Y | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/widgets/map_telemetry.dart` |  |
| Team position tracking | P | ? | ? | ? | ? | ? | Y | ? | ? | I | `SOS/check-in share position; no continuous team tracking` | TEAM, SAR |
| Location privacy controls | Y | ? | ? | Y | ? | ? | Y | ? | ? | = | `position omitted unless opted in (field validation doc); coverage privacy delay` |  |

### Device connectivity

| Feature | NX | OFF | MCO | MC1 | MTX | MCOA | TEAM | MCC | MSC | NX vs field | NOTORYX evidence | Note |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|---|
| Bluetooth LE | Y | Y | Y | Y | Y | Y | Y | Y | Y | = | `lib/connector/meshcore_connector.dart` |  |
| USB serial | Y | Y | Y | ? | Y | Y | ? | ? | Y | = | `lib/connector/meshcore_connector_usb.dart` |  |
| TCP / Wi-Fi | Y | Y | Y | Y | Y | Y | ? | ? | Y | = | `lib/connector/meshcore_connector_tcp.dart` |  |
| Auto-connect at launch | Y | Y | N | ? | Y | ? | ? | Y | ? | = | `lib/services/auto_connect_service.dart` | MCO #486 requested |
| Auto-reconnect on link drop | P | Y | ? | ? | ? | ? | ? | Y | ? | I | `_shouldAutoReconnect requires bluetooth transport (meshcore_connector.dart:3154)` | OFF v1.44 Wi-Fi auto-reconnect |
| Android foreground service | Y | Y | N | ? | Y | ? | ? | NA | ? | = | `flutter_foreground_task; services/background_service.dart` | MCO #58 open |
| Battery monitoring | Y | Y | Y | Y | Y | ? | Y | Y | ? | = | `lib/widgets/battery_indicator.dart` |  |
| Connection log / troubleshooting | Y | ? | ? | ? | ? | ? | ? | Y | Y | = | `lib/screens/ble_debug_log_screen.dart, app_debug_log_screen.dart` |  |
| Radio clock sync on connect | Y | ? | ? | ? | ? | ? | ? | Y | ? | = | `tz/clock refs in meshcore_connector.dart (verify on device)` |  |
| Companion CLI / Wi-Fi setup | Y | Y | ? | Y | ? | ? | ? | ? | ? | = | `lib/screens/companion_cli_screen.dart, wifi_settings_screen.dart` |  |

### UI/UX & accessibility

| Feature | NX | OFF | MCO | MC1 | MTX | MCOA | TEAM | MCC | MSC | NX vs field | NOTORYX evidence | Note |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|---|
| Onboarding flow | Y | Y | ? | ? | ? | ? | Y | ? | ? | = | `lib/screens/bastion_setup_screen.dart, field_guide_screen.dart` |  |
| Dark / light / red-light themes | S | ? | Y | Y | Y | ? | Y | ? | ? | S | `lib/theme/bastion_themes.dart (5 themes incl. Red light, Okabe-Ito)` |  |
| Color-blind-safe palette | S | ? | ? | ? | ? | ? | ? | ? | ? | S | `Okabe-Ito node colours + theme` |  |
| Languages | S | Y | Y | N | Y | ? | Y | ? | Y | S | `18 locales (lib/l10n)` | MC1 English only per mesh-sn.de |
| Screen-reader semantics | P | ? | ? | ? | ? | ? | ? | ? | ? | U | `65 Semantics( uses in 116k lines; not audited` |  |
| Settings search | Y | ? | ? | ? | ? | ? | ? | ? | ? | S | `More tab search box` |  |
| Home-screen widget | Y | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/services/home_widget_sync.dart (Android)` | Meshtastic Android has one |
| Live Activity / CarPlay / Siri | NA | ? | ? | Y | ? | ? | ? | ? | ? | NA | `no iOS build shipped` |  |

### Advanced

| Feature | NX | OFF | MCO | MC1 | MTX | MCOA | TEAM | MCC | MSC | NX vs field | NOTORYX evidence | Note |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|---|
| MQTT bridge (multi-broker) | S | ? | ? | ? | ? | ? | ? | Y | Y | S | `lib/services/mqtt_broker_service.dart` |  |
| Bots / auto-replies | S | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/services/bot_engine.dart` |  |
| Weather | Y | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/services/weather_service.dart` |  |
| Config / data export | Y | Y | ? | Y | ? | Y | ? | ? | Y | = | `lib/screens/encrypted_backup_screen.dart` | OFF exports SQLite DB |
| Text compression | Y | ? | ? | ? | ? | S | ? | ? | ? | I | `lib/helpers/smaz.dart, cyr2lat.dart` | MCOA 3 schemes |

### Safety & emergency

| Feature | NX | OFF | MCO | MC1 | MTX | MCOA | TEAM | MCC | MSC | NX vs field | NOTORYX evidence | Note |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|---|
| SOS with repeat + all-clear | S | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/widgets/sos_panel.dart` |  |
| SOS relay | S | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/services/sos_relay_service.dart (not field-tested)` |  |
| Check-ins + overdue alerts | S | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/services/field_ops_service.dart` |  |
| Pre-trip readiness check | P | ? | ? | ? | ? | ? | ? | ? | ? | S | `offline map readiness check only (BASTION_FIELD_VALIDATION.md)` |  |

### Privacy & security

| Feature | NX | OFF | MCO | MC1 | MTX | MCOA | TEAM | MCC | MSC | NX vs field | NOTORYX evidence | Note |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|---|
| Credentials in OS keychain | Y | ? | ? | ? | ? | ? | ? | ? | ? | S | `lib/services/secure_mqtt_credentials_store.dart` |  |
| Encrypted backup | Y | ? | ? | Y | ? | ? | ? | ? | Y | = | `lib/services/encrypted_backup_service.dart` |  |
| At-rest history encryption | N | ? | ? | ? | ? | ? | ? | ? | ? | U | `—` |  |
| App lock (biometric/PIN) | N | ? | ? | ? | ? | ? | ? | ? | ? | U | `—` |  |
| Link previews off by default | Y | ? | ? | ? | ? | ? | ? | ? | ? | S | `README` |  |

### Distribution & platform

| Feature | NX | OFF | MCO | MC1 | MTX | MCOA | TEAM | MCC | MSC | NX vs field | NOTORYX evidence | Note |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|---|
| Android | Y | Y | Y | NA | Y | Y | Y | Y | NA | = | `APK + Obtainium` |  |
| iOS | N | Y | Y | Y | Y | Y | ? | Y | NA | I | `builds in CI only; bundle id com.monitormx.meshcoreopen (upstream)` |  |
| macOS / Windows / Linux / web | P | Y | Y | P | Y | P | ? | Y | Y | I | `macOS released; others CI only` |  |
| App-store listing | N | Y | Y | Y | Y | ? | Y | NA | ? | I | `not on Play/App Store` |  |
| F-Droid / IzzyOnDroid | N | ? | N | ? | ? | ? | ? | NA | NA | = | `—` | MCO #113 requested |
| Message storage engine | P | Y | P | Y | ? | ? | ? | Y | Y | I | `shared_preferences JSON (lib/storage/message_store.dart:28)` | OFF SQLite (v1.43 export); Offband moved to SQLite #334 |