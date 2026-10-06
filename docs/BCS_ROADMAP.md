# Bastion delivery roadmap

Bastion helps people connect, communicate, locate and operate off-grid.
The inherited MeshCore protocol, transport support and application identifiers
remain the compatibility baseline. All new features ship through focused PRs.

## Current implementation: local Bot Mode

App Settings → Bastion Bot Mode provides a master toggle (off by default), an away
auto-responder, individually enabled commands, exact/keyword reply rules,
per-contact rules and an optional contact allowlist. Built-ins include `!ping`,
`!status`, `!battery`, `!help`, `!info`, `!checkin` and `!repeater`.
`!where` requires explicit location sharing; it reports advertised radio
coordinates, labelled as potentially stale, rather than claiming current GPS.

The first release is direct-message-only and accepts known chat contacts.
It excludes rooms, channels, CLI/reactions, self messages, initial reconnect
backlog and messages older than two minutes. Replies are labelled `[Bastion Bot]`.
Per-contact cooldown defaults to five minutes and the global cap to three
replies per minute. Budgets persist across restart; replies use the existing
message queue and retries. A queued reply is not proof of radio delivery.
Turning Bot Mode off prevents new bot sends; already queued transmissions
retain the normal messaging lifecycle.

No subscription or cloud service is required. The app must remain running and
connected. Background execution is OS-dependent; this is not an unattended
firmware bot or a guaranteed always-on service. Native background scheduling
and hardware validation are separate release gates.

## 9.6 — ownership and reliability

- Complete visible BCS branding while retaining upstream license/credits.
- Resolve image-link test failures and establish passing analyzer/test/build CI.
- Produce a reviewable Android build; check BLE, USB/TCP and reconnect handling.
- Verify release signing and upgrade paths before any bundle-ID migration.

## 9.7 — field dashboard and free automations

- Dashboard: transport/connection, radio battery, advertised location freshness,
  last sync, unread messages, contacts and repeaters. Distinguish unknown from zero.
- Extend Bot Mode with opt-in channels/mentions and channel airtime budgets.
- Rules for reconnect, disconnect, low battery, new nodes and repeater events.
- Scheduled check-ins with missed-job visibility and explicit background limits.
- Add a visual WHEN / FROM / IF / THEN builder, individual toggles, activity log
  and dry-run preview. Add hop restrictions only where receive metadata supports them.

## 9.8 — teams and one-tap check-ins

- Local expedition/team profiles and favorites for hiking, hunting, events,
  family and SAR use; last-known positions, last contact and available telemetry.
- Buttons for I'm OK, Delayed, At Camp, Heading Back and Need Help.
- Preview recipients, timestamp, location and optional battery before sending.
- Overdue-member rules; distinguish missing telemetry from a failed check-in.
- Private emergency/trip information card. Mesh messages do not replace 911,
  SAR or a satellite SOS service and delivery is never implied.

## 9.9 — maps and field measurements

- Build on existing offline-map cache: download/manage regions, topo/trails,
  camps, vehicles, trailheads, waypoints and breadcrumbs, respecting tile licensing.
- Repeater distance/bearing and signal history; message-path visualization
  limited to observed data. Never present a historical repeater as online.
- GPS/SNR/RSSI range-test sessions and dead-zone logging; reproducible exports.
- Local trip recording with mesh observations and clear retention controls.

## 10.0 — field intelligence and optional website integration

- Explain network health with evidence, freshness and confidence; no invented routes.
- Field Log records observations, check-ins, repeaters and measured successful/
  failed links. Allow users to delete/export local logs.
- Optional, previewed, selective sync to BackCountrySignal.org after reconnect.
  Define the server API, authentication, consent and location minimization before
  transmitting observations. Default remains local and private.
- Later geofences, arrival/departure triggers and explicit opt-in webhooks.

## Release gates

Every release requires analyzer/format/test CI and a platform build. Radio-facing
features also require physical MeshCore tests: fresh DM, backlog reconnect,
duplicate reception, disconnect during send, disabled state, and airtime limits.
OS sleep/kill behavior must be documented and tested separately. No completed
roadmap checkbox means a feature has shipped unless its implementation and
validation can be linked.
