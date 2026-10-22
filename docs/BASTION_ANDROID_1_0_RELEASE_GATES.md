# NOTORYX Core Android 1.0 release gates

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
- [ ] App label is NOTORYX and launcher activity resolves correctly.
- [ ] Version code increases for each distributed update.
- [ ] Release APK is signed with the permanent release signing key, the original Bastion key, not the Android debug key.
- [ ] Record the release commit, artifact SHA-256 and signing certificate fingerprint.

## Gate B — physical-device smoke tests

Record the Android version, phone model, radio model, radio firmware, transport and pass/fail for each case.

- [ ] Fresh install opens without crashing and displays the approved NOTORYX Core icon.
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

### Field features added after 10.0.0-rc.5

Each needs at least two radios; note which ones.

- [ ] **SOS:** a tap does nothing, and a 2-second hold sends to the trip contacts and SOS channel. A repeat goes out 5 minutes later, including with the screen locked and the app in the background. A reply from a trip contact stops repeats and notifies. "I'm safe" sends one all clear.
- [ ] **Check-in reminder:** set it to 30 minutes, start a trip, then force-close NOTORYX Core. The notification arrives, possibly a few minutes late, and moves forward after each check-in.
- [ ] **Overdue alert:** with the contact's radio off, one alert arrives after the set time. Turning that radio back on (advert or message) clears it.
- [ ] **Check-in delivery:** the headline and chips match reality. With one recipient out of range, they show as not delivered and an alert fires. Resend reaches only them.
- [ ] **Remote command line (v1.18+ companions):** a command from a contact without permission is blocked and alerts. After allowing them, `get name` from their phone gets a reply.
- [ ] **Live sensor updates:** log in to a sensor, watch a reading, and confirm updates arrive when it changes and stop after Stop.
- [ ] **App icon shortcuts:** each of the four opens the right screen, both from a cold start and while the app is running.
- [ ] **Battery saver:** toggles without reconnecting. Messages still arrive at once.
- [ ] **Read aloud:** the menu reads a message. Auto mode reads new direct (and channel) messages while the app is open, not in the background, and skips muted channels.
- [ ] **Message search:** finds old messages beyond what the chat has loaded, and tapping opens that chat.

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

## One-time signing setup

Do this once, on your own computer. The key is the app's identity for its whole life: every update must be signed with it. Losing it means users must uninstall and reinstall.

1. Create the keystore (`keytool` comes with Java). Choose strong passwords when it asks, and store them in a password manager:

   ```bash
   keytool -genkeypair -v -keystore bastion-release.jks -alias bastion -keyalg RSA -keysize 4096 -validity 10000
   ```

2. Back up `bastion-release.jks` and the passwords in two safe places (for example, the password manager plus an offline drive). Never commit them.
3. Add four repository secrets (Settings → Secrets and variables → Actions):
   - `BASTION_KEYSTORE_BASE64`: the output of `base64 -i bastion-release.jks`
   - `BASTION_STORE_PASSWORD` and `BASTION_KEY_PASSWORD`
   - `BASTION_KEY_ALIAS`: `bastion`
4. Run **Bastion Signed Android Release** from the Actions tab. It checks format, analyze and tests, then builds:
   - a signed ARM64 APK
   - a Play Store App Bundle (`.aab`)
   - `SHA256SUMS.txt`
   - the signing certificate

   It refuses to finish if anything is debug-signed.

For Google Play, enroll in Play App Signing and upload the `.aab`. The store listing text is in `fastlane/metadata/android/en-US/`, and the changelog file is named after the version code.

## Evidence required to mark 1.0 complete

A green release workflow, an identified permanent signing certificate, recorded device-test results, reviewed privacy/attribution, and a published signed artifact with a checksum.
