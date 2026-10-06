# BCS Connect MeshCore

Open-source Flutter client for MeshCore LoRa mesh networking, maintained by **BackCountrySignal**.

## Overview

**BCS Connect MeshCore** is a cross-platform MeshCore client focused on reliable off-grid communication, field usability, emergency communications, and a clean user experience. It communicates with compatible MeshCore LoRa devices through Bluetooth Low Energy (BLE), USB, or TCP and supports peer-to-peer messaging, public channels, maps, node management, and repeater tools.

**Website:** [backcountrysignal.org](https://backcountrysignal.org/)  
**Repository:** [backcountrysignal/BCS-Connect-MeshCore](https://github.com/backcountrysignal/BCS-Connect-MeshCore)

### Project Direction

BCS Connect is being developed with an emphasis on:

- Reliable field and backcountry operation
- Simple, low-distraction controls
- Offline-friendly tools and mapping
- Mesh diagnostics and network visibility
- Emergency and community communications
- Automation, including optional bot / auto-responder capabilities
- Privacy and open-source development

> **Upstream credit:** BCS Connect MeshCore is derived from the open-source [MeshCore Open](https://github.com/zjs81/meshcore-open) project. We appreciate the work of its developers and the broader MeshCore community. BCS Connect maintains its own branding, enhancements, and development direction while retaining applicable upstream licensing and attribution.

## Screenshots

<table>
  <tr>
    <td><img src="docs/screenshots/contacts.jpg" width="200"/><br/><p align="center"><b>Contacts</b></p></td>
    <td><img src="docs/screenshots/chat1.jpg" width="200"/><br/><p align="center"><b>Chat</b></p></td>
    <td><img src="docs/screenshots/chat2.jpg" width="200"/><br/><p align="center"><b>Reactions</b></p></td>
    <td><img src="docs/screenshots/map.jpg" width="200"/><br/><p align="center"><b>Map</b></p></td>
    <td><img src="docs/screenshots/channels.jpg" width="200"/><br/><p align="center"><b>Channels</b></p></td>
  </tr>
</table>

## Features

### Core Functionality

- **Direct Messaging**: Private encrypted conversations with individual contacts
- **Public Channels**: Broadcast messages to channel subscribers on the mesh network
- **Contact Management**: Organize contacts, track last seen times, and manage conversation history
- **Contact Groups**: Create custom groups to organize your mesh network contacts
- **Message Reactions**: React to messages with emoji responses
- **Message Replies**: Thread conversations with inline reply functionality

### Mesh Network

- **Path Visualization**: View routing paths and signal quality for each contact
- **Route Management**: Manual path overriding and automatic route rotation
- **Signal Metrics**: Real-time SNR (Signal-to-Noise Ratio) tracking
- **Node Discovery**: Automatic detection of nearby mesh nodes
- **Repeater Support**: Connect to and manage repeater nodes for extended range

### Map & Location

- **Live Map View**: Real-time visualization of mesh network nodes on an interactive map
- **Node Filtering**: Filter by node type (chat, repeater, sensor) and time range
- **Location Sharing**: Share GPS coordinates and custom markers with contacts
- **Offline Maps**: Download map tiles for offline use in remote areas (with [StadiaMaps](https://stadiamaps.com/pricing/) Free Subscription API-Key)
- **MGRS Coordinates**: Support for Military Grid Reference System coordinate format

### Device Management

- **BLE, USB, TCP Connection**: Scan and connect to MeshCore devices via Bluetooth, USB or TCP
- **Device Settings**: Configure radio parameters, power settings, and network options
- **Battery Monitoring**: Real-time battery status with chemistry-specific voltage curves
- **Firmware Updates**: Over-the-air firmware updates via BLE (coming soon)

### Repeater Hub

- **CLI Access**: Full command-line interface to repeater nodes
- **Settings Management**: Configure repeater behavior, power limits, and network settings
- **Statistics Dashboard**: View repeater traffic, connected clients, and system health
- **Remote Management**: Administer repeaters from anywhere on the mesh network

## Technical Details

### Architecture

- **Framework**: Flutter 3.38.5 / Dart 3.10.4
- **State Management**: Provider pattern with ChangeNotifier
- **BLE Protocol**: Nordic UART Service (NUS) over Bluetooth Low Energy
- **Storage**: Local SQLite database for messages and contact data
- **Encryption**: End-to-end encryption for private messages using the MeshCore protocol

### Platform Support

| Feature            | Android (API 21+) | iOS (12+) | Linux | Windows | macOS |                Web                |
|--------------------|:-----------------:|:---------:|:-----:|:-------:|:-----:|:---------------------------------:|
| BLE companion      | ✅                | ✅        | ✅   | ✅      | ✅    | ✅                                |
| USB companion      | ✅                | 🚧        | ✅   | ✅      | ✅    | ✅                                |
| TCP companion      | ✅                | 🚧        | ✅   | ✅      | ✅    | ❌<br>(requires websocket bridge) |
| Core Functionality | ✅                | ✅        | ✅   | ✅      | ✅    | ✅                                |
| Mesh Network       | ✅                | ✅        | ✅   | ✅      | ✅    | ✅                                |
| Map & Location     | ✅                | ✅        | ✅   | ✅      | ✅    | ✅                                |
| Device Management  | ✅                | ✅        | ✅   | ✅      | ✅    | ✅                                |
| Repeater Hub       | ✅                | ✅        | ✅   | ✅      | ✅    | ✅                                |

### Dependencies

| Package | Purpose |
|---------|---------|
| flutter_blue_plus | Bluetooth Low Energy communication |
| provider | State management |
| shared_preferences | Local key-value storage (scoped per device) |
| flutter_map | Interactive map display |
| latlong2 | Geographic coordinate handling |
| flutter_local_notifications | Background notification support |
| pointycastle | Cryptographic operations |
| llamadart | On-device LLM message translation |
| intl | Internationalization and date formatting |

## Getting Started

### Prerequisites

- Flutter SDK 3.38.5 or later
- Android Studio / Xcode (for mobile development)
- A MeshCore-compatible LoRa device

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/backcountrysignal/BCS-Connect-MeshCore.git
   cd BCS-Connect-MeshCore
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

### Building for Release

**Android APK:**

```bash
flutter build apk --release
```

**iOS:**

```bash
flutter build ios --release
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── connector/
│   ├── meshcore_connector.dart  # BLE communication & state management
│   ├── meshcore_protocol.dart   # Protocol definitions & frame parsing
│   └── meshcore_uuids.dart      # Device names and IDs (add prefixes here!)
├── screens/
│   ├── scanner_screen.dart      # Device scanning (home screen)
│   ├── contacts_screen.dart     # Contact list
│   ├── chat_screen.dart         # Direct messaging
│   ├── channels_screen.dart     # Public channels
│   ├── map_screen.dart          # Network visualization map
│   ├── settings_screen.dart     # Device settings
│   └── repeater_hub_screen.dart # Repeater management
├── models/
│   ├── contact.dart             # Contact data model
│   ├── message.dart             # Message data structure
│   └── channel.dart             # Channel definitions
├── services/
│   ├── notification_service.dart      # Push notifications
│   ├── message_retry_service.dart     # Automatic message retry
│   ├── background_service.dart        # Background BLE connection
│   └── map_tile_cache_service.dart    # Offline map storage
└── storage/
    ├── message_store.dart       # Message persistence
    ├── contact_store.dart       # Contact database
    └── unread_store.dart        # Unread message tracking
```

## BLE Protocol

### Nordic UART Service (NUS)

- **Service UUID**: `6e400001-b5a3-f393-e0a9-e50e24dcca9e`
- **RX Characteristic**: `6e400002-b5a3-f393-e0a9-e50e24dcca9e` (Write to device)
- **TX Characteristic**: `6e400003-b5a3-f393-e0a9-e50e24dcca9e` (Notify from device)

### Device Discovery

Devices are discovered by scanning for BLE advertisements with known MeshCore device name prefixes. These are currently:
    - `MeshCore-`
    - `Whisper-`
    - `WisCore-`
    - `HT-`
    - `LowMesh_MC_`
    - `NRF52`

New device prefixes can be added in `lib/connector/meshcore_uuids.dart`.


### Message Format

Messages are transmitted as binary frames using a custom protocol optimized for LoRa transmission. See `meshcore_protocol.dart` for frame structure definitions.

## Configuration

### App Settings

- **Theme**: System default, light, or dark mode
- **Language**: Use one of 15 languages (English, Chinese, French, Spanish, Portuguese, German, Dutch, Polish, Swedish, Italian, Slovak, Slovene, Bulgarian, Russian, Ukrainian)
- **Notifications**: Configurable for messages, channels, and node advertisements
- **Battery Chemistry**: Support for NMC, LiFePO4, and LiPo battery types
- **Message Retry**: Automatic retry with configurable path clearing

### Device Settings

- **Radio Power**: Transmit power adjustment (10-30 dBm)
- **Frequency**: LoRa frequency configuration
- **Bandwidth**: Channel bandwidth selection
- **Spreading Factor**: Range vs. speed trade-off
- **Network ID**: Mesh network identifier

## Contributing

This is an open-source project. Contributions are welcome!

### Development Guidelines

- Follow the Flutter style guide
- Use Material 3 design components
- Write clear commit messages
- Test on both Android and iOS before submitting PRs

### Code Style

- Prefer `StatelessWidget` with `Consumer` for reactive UI
- Use `const` constructors where possible
- Keep functions small and focused
- Avoid premature abstractions
- Run dart format on all changes before submitting

## Support

For issues, questions, compatibility reports, or feature requests, please use the [BCS Connect MeshCore GitHub Issues](https://github.com/backcountrysignal/BCS-Connect-MeshCore/issues) page.

For BackCountrySignal project information and resources, visit [backcountrysignal.org](https://backcountrysignal.org/).

## License and Upstream Attribution

BCS Connect MeshCore is based on open-source upstream software. This project is intended to retain and comply with all applicable upstream license, copyright, and attribution requirements.

See the repository's license and source files for complete licensing information. The upstream MeshCore Open project is available at [zjs81/meshcore-open](https://github.com/zjs81/meshcore-open).

## Acknowledgments

- Built with [Flutter](https://flutter.dev/)
- Map tiles from [OpenStreetMap](https://www.openstreetmap.org/)
