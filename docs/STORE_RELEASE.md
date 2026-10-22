# Store release checklist

These are the steps that need the maintainer's own accounts. Everything the repo can do is already automated.

## Google Play

**One-time setup** (Play Console, $25 developer fee):

1. Create the app "NOTORYX Core" with the package `com.bastionmesh.bastion`. The package can never change after the first upload.
2. Enrol in **Play App Signing** and choose "Use my own key" / upload key. The upload key is the release key in the maintainer's offline "Bastion signing" folder (alias `bastion`, certificate SHA-256 `01834f7d…6787`). Updates to the sideloaded APKs on GitHub keep working because they're signed with the same key.
3. Fill in the listing from `fastlane/metadata/android/en-US/`: `title.txt`, `short_description.txt`, `full_description.txt`, and `changelogs/<versionCode>.txt` for each release.
4. Add the graphics Play requires:
   - App icon (512 × 512): `fastlane/metadata/android/en-US/images/icon.png`.
   - Feature graphic (1024 × 500): `fastlane/metadata/android/en-US/images/featureGraphic.png`.
   - At least 2 phone screenshots. `docs/screenshots/` has candidates.

   Both graphics are rendered from `branding/notoryx-icon-source.png`. The other files in `branding/` are the outputs: the full-bleed icon, the Android adaptive foreground, the macOS tile and the feature graphic.
5. Privacy policy URL: publish `docs/PRIVACY_POLICY.md` on a public page (for example GitHub Pages on the releases repo) and paste the link.
6. **Data safety:**
   - Location is used on the device for maps and positions. It's shared over the mesh only when the user sends it, and with an MQTT broker only if observer sharing is on.
   - No ads, no analytics.
   - MQTT credentials stay on the device.
7. **Permission declarations:**
   - Foreground service type `connectedDevice` (radio link).
   - Bluetooth scan without location inference is not claimed.
   - Camera is used for QR contact codes.
8. Content rating questionnaire and target audience (not for children).

**Each release:**

1. Merge the version bump into `dev`. The "Build NOTORYX Core APK" workflow uploads an `NOTORYX-Core-Android-AAB` artifact on every `dev` push. It's debug-signed.
2. Download the artifact and check `SHA256SUMS.txt`, then sign it on the maintainer's Mac:

   ```bash
   ~/Documents/"Bastion signing"/sign-aab.sh NOTORYX-Core.aab NOTORYX-Core-<version>.aab
   ```

   The script should print `jar verified.` and certificate SHA-256 `01:83:4F:7D…:67:87`.
3. Upload the signed `.aab` to an internal or closed testing track first, then promote it.

## macOS notarization

GitHub builds are ad-hoc signed today, so the first launch needs **Open Anyway** (System Settings → Privacy & Security). Notarization removes that step.

1. Join the Apple Developer Program ($99/year) and create a **Developer ID Application** certificate.
2. Make an app-specific password (or App Store Connect API key) for `notarytool`.
3. Sign with the hardened runtime instead of ad hoc:

   ```bash
   codesign --deep --force --options runtime --sign "Developer ID Application: …" "NOTORYX Core.app"
   ```

   Keep the existing sandbox entitlements (`macos/Runner/Release.entitlements`).
4. Notarize and staple:

   ```bash
   ditto -c -k --keepParent "NOTORYX Core.app" notarize.zip
   xcrun notarytool submit notarize.zip --keychain-profile notoryx --wait
   xcrun stapler staple "NOTORYX Core.app"
   ```

5. Zip again and attach the result to the release. `bastion-macos-release.yml` can do steps 3–5 once the certificate and notary credentials are available to CI. A repo admin has to add the secrets.

## iOS

Not built yet: this needs a Mac with Xcode and the same Apple Developer account.
