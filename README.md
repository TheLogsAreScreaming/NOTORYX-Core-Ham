# Bastion

Bastion is an independent MeshCore companion app built with Flutter.

It combines messaging, maps, coverage capture, route intelligence, repeater tools, diagnostics, and offline field features in one app.

## Status

Bastion is under active development. Android ARM64 is the primary release target today. Other Flutter-supported platforms remain part of the project architecture but may not have the same level of testing.

## Features

- MeshCore contacts, direct messages, and channels
- BLE, USB, and TCP companion connections
- Live mesh map and node discovery
- Coverage capture with saved sessions, recovery, maps, and export
- Route/path history and route intelligence
- Repeater status, telemetry, neighbors, settings, and CLI access
- Field statistics and diagnostics
- Offline map support
- QR sharing and region-aware workflows where supported
- Local persistence for app and mesh data

## Android build

The project uses Flutter 3.41.5 in its Android CI pipeline.

To build locally:

```bash
flutter pub get
dart run flutter_launcher_icons
flutter build apk --release --target-platform android-arm64 --target lib/main.dart
```

The Android application ID is:

```
com.bastionmesh.bastion
```

This identifier is kept for package continuity and does not represent in-app branding.

## Development

Run the app locally with:

```bash
flutter pub get
flutter run
```

Before submitting changes:

```bash
dart format .
flutter analyze
flutter test
```

## Project structure

- `lib/connector/` — MeshCore protocol and transport logic
- `lib/screens/` — Bastion UI
- `lib/services/` — coverage, routing, diagnostics, storage, notifications, and supporting services
- `lib/storage/` — persistent app/mesh data
- `lib/widgets/` — reusable UI components
- `android/`, `ios/`, `macos/`, `linux/`, `windows/`, `web/` — platform projects

## Issues and contributions

Use this repository's **Issues** tab for bugs, feature requests, and development discussion. See `CONTRIBUTING.md` before opening a pull request.

## Independence and attribution

Bastion is an independent community application. It is not an official MeshCore application and does not imply endorsement by MeshCore or other credited projects.

Bastion includes or builds on open-source work from other projects. Required license text, copyright notices, and source attribution are preserved in `THIRD_PARTY_NOTICES.md` and the app's Open Source Licenses screen.

## License

See the repository license and `THIRD_PARTY_NOTICES.md` for applicable licensing and third-party notices.
