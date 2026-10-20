# Bluetooth reliability and automatic reconnection

## Existing implementation
`lib/connector/meshcore_connector.dart` already tracks connection state, last Bluetooth device, manual disconnect, a reconnect timer, and retry attempts. `flutter_blue_plus` is already a dependency. Extend this existing state machine rather than adding a parallel connection manager.

## Implementation sequence
1. Inventory all reconnect scheduling, adapter-state subscriptions, device disconnect callbacks, background/foreground transitions, and disposal paths; record current invariants.
2. Introduce a single serialized connection attempt with cancellation tokens or generation checks; prevent overlapping scan/connect/disconnect and stale callback resurrection.
3. Use bounded exponential backoff with jitter, reset on stable connection, and pause when Bluetooth is off, permissions are denied, or the user explicitly disconnects. Resume only when permitted.
4. Reconnect to the previously selected device identity where supported; never silently switch to a different radio. Restore characteristic subscriptions once and resync safe state after reconnect.
5. Surface connection status, next retry, and a user-controlled retry/cancel action. Ensure no false connected indicator.
6. Test unexpected disconnect, adapter toggle, permissions, app lifecycle, rapid repeated events, manual disconnect, disposal, and recovery with a fake transport. Run Flutter analyze/test and device tests on Android and iOS.

## Safety and acceptance
- Do not promise perpetual background BLE on iOS; obey OS lifecycle restrictions.
- No automatic firmware/radio configuration changes or message resends without existing safeguards.
- No duplicate listeners, overlapping connections, infinite tight retries, or connection to an unknown radio.
- Hardware reconnection success requires real-device testing; CI alone is insufficient.
