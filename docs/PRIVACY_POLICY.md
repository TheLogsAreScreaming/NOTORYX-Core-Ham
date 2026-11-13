# NOTORYX Core Ham privacy policy (release review draft)

**Last reviewed:** November 9, 2026  
**Status:** Draft for code and distribution review before public release.

## About NOTORYX Core Ham

NOTORYX Core Ham is an independent MeshCore companion app. It communicates with compatible mesh radios and provides messaging, maps, route intelligence, diagnostics and coverage capture. No NOTORYX Core account is required for the current companion workflows.

## Information stored on the device

Depending on the features you use, NOTORYX Core can store messages, contact identifiers, channel settings, routing/path history, coverage sessions and observations, mesh node positions, app preferences, cached map tiles and optional diagnostic logs. Coverage observations can contain the connected radio's GPS coordinates and nearby signal measurements. A radio's GPS position is not necessarily the phone's position.

The app uses device storage and operating-system protections. Encrypted message history is optional and off by default; it covers the message database on this device, not the other settings, logs or exports. Anyone with access to an exported file, or to the unlocked device, may be able to read its contents.

## Radio communication and sharing

**Amateur radio traffic is plain text. Anyone listening can read it, and every transmission carries your call sign.** Encrypted history only protects the copy on this device.

Messages and other information sent over a MeshCore network are transmitted to compatible radio devices. Their reach and visibility depend on the protocol, radio configuration, recipients and network participants. NOTORYX Core can let you export coverage data or diagnostics; sharing those files with other people or services is your choice.

## Device permissions

- **Bluetooth:** discover and communicate with supported MeshCore radios.
- **Location:** support platform-specific BLE discovery requirements and location-related features where enabled. Coverage capture currently records the connected radio's reported GPS location when available.
- **Internet:** retrieve online maps, optional downloads, elevation data and other internet-dependent features.
- **Notifications:** display incoming-message notifications when permitted.
- **Foreground service / wake lock:** maintain a connected-device session in the background where Android permits it.
- **Camera:** scan QR codes when that feature is used.
- **Face ID or device passcode:** unlock the app when App lock is on. The check is done by the operating system and the app never sees your biometric data.
- **Photos:** attach an image when you choose to.

Permissions can be managed through the phone's settings, although denying a permission may disable the associated feature.

## Third-party network services

Depending on the features and settings used, the app may request map tiles from OpenStreetMap or Stadia Maps, terrain elevation from Open-Meteo, trail and place data from the OpenStreetMap Overpass service when you download an area for trail routing, optional models from Hugging Face, and GIF results from Giphy. Those requests can reveal your IP address and relevant request data (for example, map tile coordinates, selected path coordinates or a GIF search query) to the provider. Review each provider's privacy policy before using the feature.

## Diagnostics and data removal

Debug logs and exported diagnostics can include device, network and radio metadata. Inspect files before sharing them. Deleting app data or uninstalling the app removes data stored solely within its private app storage; separately exported files, backups, remote services and data already transmitted over the mesh are not removed by uninstalling.

## Children and policy updates

NOTORYX Core Ham is not designed to collect information from children. This policy will be updated if data handling or integrations change.

## Contact

For questions, bug reports or privacy concerns, open an issue in this app's GitHub repository. Confirm a permanent support address and public policy URL before publishing a store listing.
