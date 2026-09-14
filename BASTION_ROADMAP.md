# Bastion

Bastion is the Bastion all-in-one MeshCore client.

## Product direction

Bastion combines a full MeshCore companion experience with mapping, wardriving, network analysis, repeater administration, offline field tools, and region-aware workflows in one branded application.

## Design

- Product name: Bastion
- Brand: Bastion
- Theme: dark charcoal/black, white, cyan/teal accents matching the Bastion website
- Launcher icon: approved Bastion fortress icon
- Mobile-first with Android as the first release target; retain cross-platform Flutter architecture for iOS/desktop/web where practical

## Integration principles

1. Preserve upstream copyright notices and required attribution.
2. Reuse MIT-licensed MeshCore Open, MeshMapper, and MeshCore components where technically appropriate.
3. Reimplement behavior inspired by proprietary clients rather than copying proprietary source/assets.
4. Keep upstream-derived components isolated enough to make future upstream merges practical.
5. Keep core messaging and radio connectivity stable while advanced modules are added incrementally.

## Target modules

### Core communications
- BLE connection
- USB serial connection
- TCP/network connection
- reconnect and saved connections
- contacts
- direct messages
- channels
- replies and reactions where protocol/client support permits
- unread state and notifications
- QR contact/channel/config sharing
- local encrypted history where feasible
- multiple radios/identities

### Mesh map
- live contacts/nodes/repeaters/rooms/sensors
- node detail sheets
- RSSI/SNR and last-seen information
- route/path visualization
- multi-byte paths
- manual path tools
- telemetry overlays
- location sharing
- map search/filter/favorites
- high-contrast/dark maps
- offline map downloads/cache

### Coverage / MeshMapper
- GPS wardrive sessions
- TX/RX/discovery ping markers
- repeater echo detection
- passive RX logging
- coverage observations
- persistent upload queue
- offline collection and later upload
- session history
- device model/power identification
- export/import where supported
- opt-in community contribution

### Network intelligence
- unknown repeater/hash resolution using permitted public sources
- multiple reception/path analysis
- hop analysis
- network/repeater activity statistics
- region discovery
- region-aware channel/contact configuration
- message region indicators
- reply using sender region where supported
- repeater-neighbor visualization

### Repeater / room administration
- status
- telemetry
- neighbors
- settings
- admin/guest permissions
- ACL management where firmware supports it
- CLI console
- identity/key management
- remote administration over mesh

### Field tools
- offline-first mode
- diagnostics
- raw packet/log viewer
- connection diagnostics
- GPS status
- battery/device information
- firmware/device information
- firmware update workflows where supported
- backup/restore

### Observer / integrations
- observer mode
- optional MQTT forwarding where compatible
- privacy controls
- explicit opt-in for network/community uploads

## Initial implementation sequence

1. Bastion branding and design tokens
2. Launcher icon + splash
3. Preserve and verify core MeshCore connectivity/messaging
4. Consolidated map shell
5. MeshMapper wardrive module
6. Offline maps
7. Network/path intelligence
8. Region-aware workflows
9. Repeater/room administration
10. Diagnostics, observer/MQTT, backup/restore
11. Android signed APK pipeline
12. iOS validation/package work

## Licensing / attribution

Maintain a THIRD_PARTY_NOTICES file and in-app Open Source Licenses screen. Confirm each imported component's exact license at the commit used before merging source.
