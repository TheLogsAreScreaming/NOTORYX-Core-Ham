# NOTORYX Core — Stage 1 baseline audit

Date: 2026-10-20. Integration branch: `dev`.

## Confirmed existing functionality (documented, not hardware-verified)
- Flutter application with Bluetooth, USB, and TCP MeshCore transports.
- Messaging with local search, drafts, reactions, and delivery states.
- Offline map packs, path graph, repeater tools, trip contacts, check-ins, and SOS.
- Local notification and foreground-task dependencies in `pubspec.yaml`.

## Known limitations / release gates
- `docs/BASTION_FIELD_VALIDATION.md` explicitly lists physical BLE reconnection, USB/TCP outages, weak radio paths, locked-phone behavior, offline maps, and upgrade/data retention as **not yet validated**.
- Background operation must be assessed separately for each OS; foreground-task dependencies do not guarantee delivery while the app is suspended.
- Radio acceptance and mesh acknowledgement are not read receipts; never display them as such.
- Do not change Android application ID `com.bastionmesh.bastion`, signing identity, Dart package name, storage keys, or attribution in Stage 1.

## Baseline verification checklist
- [ ] `flutter pub get`
- [ ] `dart format --output=none --set-exit-if-changed lib test`
- [ ] `flutter analyze`
- [ ] `flutter test`
- [ ] Confirm Android, Linux and Web CI jobs on the PR
- [ ] Confirm Apple platform builds on their configured workflow
- [ ] Record actual CI failures and fix only reproducible root causes
- [ ] Record real-device tests separately; do not mark them passed from simulation

## Planned follow-on pull requests
1. BLE lifecycle: disconnect detection, bounded backoff, reconnect cancellation, app lifecycle and device switching; unit/widget tests.
2. Background notifications: permissions, duplicate suppression, Android lifecycle, explicit platform limits and device tests.
3. Delivery queue: persisted states, acknowledgement correlation, idempotent retries, bounded backoff and offline recovery.

## Safety and merge policy
- Target `dev`; keep each PR independently reviewable.
- Never imply SOS is guaranteed or that an acknowledgement means the recipient read a message.
- Do not silently enable location transmission or background radio activity.
- Require automated checks and separately documented real-device evidence before release.
- Keep upstream MeshCore Open attribution and third-party notices intact.

This audit is an initial baseline based on repository documentation and manifest. It is **not** a complete file-by-file code audit or a claim that CI was executed.
