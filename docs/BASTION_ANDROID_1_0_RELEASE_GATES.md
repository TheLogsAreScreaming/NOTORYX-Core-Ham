# Bastion Android 1.0 release gates

This document is a release checklist, not a claim that the app has passed device testing.

## Release scope

Android ARM64 is the first production target. iOS/desktop and optional observer/MQTT/community upload functionality are separate milestones unless implemented and tested before release.

## Gate A — automated checks

- [ ] Flutter analyzer succeeds on the release commit.
- [ ] Full existing Flutter test suite succeeds; failures are fixed or documented before release.
- [ ] Coverage session persistence/recovery tests succeed.
- [ ] Path selection, route scoring and message retry tests succeed.
- [ ] BLE, USB and TCP transport tests succeed.
- [ ] Launcher and adaptive icon resources are present in the APK.
- [ ] App label is Bastion and launcher activity resolves correctly.
- [ ] Version code increases for each distributed update.
- [ ] Release APK is signed with the permanent Bastion signing key (not the Android debug key).
- [ ] Record the release commit, artifact SHA-256 and signing certificate fingerprint.

## Gate B — physical-device smoke tests

Record the Android version, phone model, radio model, radio firmware, transport and pass/fail for each case.

- [ ] Fresh install opens without crashing and displays the approved Bastion icon.
- [ ] Upgrade from a previous build preserves messages, contacts, settings and coverage sessions when signed with the same key.
- [ ] BLE scan, connect, disconnect, reconnect and permission denial/recovery.
- [ ] USB connection, cable unplug/replug and permission denial/recovery on a supported phone.
- [ ] TCP connection, timeout, loss of network and reconnect.
- [ ] Direct message send/receive, channel send/receive, unread count and notifications.
- [ ] App background/foreground, locked-screen operation and Android battery restrictions.
- [ ] Map loads, node positions render and offline map packs work without internet.
- [ ] Coverage session start/stop, GPS availability, observations, save, restore after force-close, export and deletion.
- [ ] Route history persists across restarts and displays success/failure accurately.
- [ ] Repeater login, status, neighbors, telemetry and CLI on an authorized repeater.
- [ ] Diagnostics export contains no credentials, private keys or sensitive message bodies.
- [ ] No inherited app branding in launcher, splash, screens, notifications, settings or translated strings.
- [ ] Airplane mode/offline operation fails gracefully where internet is required.

## Gate C — privacy, licensing and distribution

- [ ] Verify the privacy policy against actual code and any configured network endpoints.
- [ ] Review location, Bluetooth, notifications, foreground service and camera permissions.
- [ ] Check logs, exported diagnostics, backups and coverage files for sensitive data.
- [ ] Confirm third-party license text and in-app notices.
- [ ] Publish installation, update and rollback instructions.
- [ ] Publish changelog, known limitations and a support/bug-report channel.
- [ ] Test the exact signed release APK on at least two Android devices when available.

## Signing and update compatibility

The RC GitHub workflow can fall back to debug signing because `android/app/build.gradle.kts` uses the debug key when `android/key.properties` is absent. **Do not distribute those RC artifacts as the permanent 1.0 release.** Use the manual signed-release workflow after provisioning GitHub Actions secrets. Keep the release keystore backed up securely and never commit it or its passwords. APKs signed with different keys cannot be installed as an in-place update over one another; testers moving from a debug-signed RC to a production-signed release may need to export data and uninstall the RC first.

## Evidence required to mark 1.0 complete

A green release workflow, an identified permanent signing certificate, recorded device-test results, reviewed privacy/attribution, and a published signed artifact with a checksum.
