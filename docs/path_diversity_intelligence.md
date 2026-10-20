# Path Diversity Intelligence — implementation contract

Status: design specification; not a completed feature.

## Goal
Make routing changes understandable without taking routing control away from MeshCore firmware. Preserve standard MeshCore compatibility and support Keymind Cascade through feature detection, not assumed firmware version strings.

## Existing foundations to inspect
- `lib/services/path_history_service.dart` and path graph screens
- `lib/services/message_retry_service.dart` and message delivery UI
- `lib/connector/meshcore_connector.dart` and packet/event models
- Existing telemetry and repeater tools

## Requirements
1. Show last **observed** path and timestamp, not a promised future route.
2. Record path changes and available alternatives from actual received protocol events. Never fabricate routes or hops.
3. Distinguish pending, acknowledged, timed out, and unknown delivery. A route discovery event is **not** proof of delivery.
4. Explain firmware-reported flood fallback separately from an app inference. If no explicit event exists, label it unknown.
5. Summarize path diversity using observed paths over a bounded window; show sample size and last-seen age. Avoid claims of guaranteed reliability.
6. Display RSSI/SNR only when available, with the measurement's source and timestamp.
7. Keep all analytics read-only initially. Do not change route selection, send extra floods, or retry messages automatically.
8. Do not expose Cascade-specific controls unless firmware support is positively verified. Default to standard MeshCore behavior.
9. Bound local history and provide a clear-data action; do not upload private route, contact or location history.
10. Make the feature usable offline, accessible, and compatible with current themes.

## Acceptance tests
- Simulated 3-hop then 2-hop paths are shown as separate observations.
- Missing path metadata shows 'Unknown', never a synthetic path.
- An ACK updates delivery status; path discovery alone does not.
- Out-of-order events do not incorrectly overwrite a newer observation.
- Duplicates and changing node identifiers are handled safely.
- Flood fallback is only labeled as confirmed when firmware explicitly reports it.
- Standard MeshCore devices are unaffected.
- No radio commands are issued by opening the dashboard.

## Delivery
Implement in small code changes with unit/widget tests, run Flutter analyze and tests, and verify on standard MeshCore and Cascade hardware before marking complete.
