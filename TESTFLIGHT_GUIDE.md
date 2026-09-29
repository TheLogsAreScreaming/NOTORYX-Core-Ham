# Bastion TestFlight and App Store Deployment Guide

This guide is a release checklist for future iOS distribution. Values such as Bundle ID, signing team, support URL, privacy URL, SKU, and App Store metadata must be confirmed before submission.

## Prerequisites

- Apple Developer account
- Xcode
- Apple Transporter
- App Store Connect access
- Bastion app icons and launch assets
- Final iOS Bundle ID and signing configuration
- Public privacy-policy URL
- Support URL

## 1. Confirm iOS identity

Before creating the App Store Connect record, confirm the Bundle ID in the Xcode project and make sure it is intended for Bastion.

Do not reuse inherited MeshCore Open identifiers for a public Bastion release unless that identifier is intentionally owned and configured for this app.

## 2. Register the Bundle ID

In Apple Developer:

1. Open Certificates, Identifiers & Profiles.
2. Create or select the Bastion App ID.
3. Use the final explicit Bundle ID.
4. Enable only the capabilities Bastion actually requires.

## 3. Create the App Store Connect app

Create a new app named **Bastion** and select the registered Bastion Bundle ID.

Choose a unique SKU and complete the required app-access settings.

## 4. Build the IPA

From the repository root:

```bash
flutter clean
flutter pub get
flutter build ipa --release
```

The generated IPA should appear under `build/ios/ipa/`.

## 5. Upload

Use Apple Transporter or Xcode to upload the IPA to App Store Connect.

Wait for Apple processing to complete before assigning the build to TestFlight.

## 6. App Store metadata

Prepare:

- Bastion name and subtitle
- App description
- screenshots
- privacy policy URL
- support URL
- category
- age rating
- encryption/export-compliance answers
- review contact information

Do not reuse inherited MeshCore Open marketing copy. Bastion's listing should describe Bastion specifically.

## 7. TestFlight

### Internal testing

Create an internal tester group, assign the processed build, and verify:

- install/update behavior
- launcher icon and launch screen
- BLE permissions and connection
- USB/TCP behavior where applicable
- messaging
- maps
- coverage capture
- route intelligence
- repeater tools
- diagnostics
- background behavior
- privacy prompts

### External testing

Add an external testing group, provide beta review information, and submit the build for Beta App Review.

## 8. Public release

Before App Review:

- verify production signing
- verify version/build number
- confirm privacy disclosures
- confirm screenshots and listing text
- confirm support and privacy URLs
- complete export-compliance questions
- provide review notes for hardware-dependent functionality

## Updating Bastion

Increment the version/build number in `pubspec.yaml`, build a new IPA, upload it, and create/select the corresponding App Store version.

## Troubleshooting

For Apple signing, App Store Connect, or TestFlight problems, use Apple's current developer documentation and support resources. For Flutter iOS build issues, use Flutter's current iOS deployment documentation.

For Bastion-specific bugs, use this repository's **Issues** tab.
