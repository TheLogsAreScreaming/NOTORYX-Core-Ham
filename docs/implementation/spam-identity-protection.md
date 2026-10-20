# Spam protection and identity verification

## Scope
Provide local, user-controlled safety protections without inventing MeshCore protocol authentication or treating a display name as proof of identity.

## Implementation sequence
1. Inspect inbound direct/channel message pipelines, sender public-key representations, contact persistence, notifications, and bot auto-replies; identify the earliest safe local filter point.
2. Add a deterministic inbound policy model: per-sender mute/block, unknown-sender requests, bounded per-sender rate limiting, duplicate suppression, and optional quieting of channel floods. Apply consistently to notification and bot triggers without dropping protocol acknowledgements or breaking message history unintentionally.
3. Add visible identity states: unknown, locally recognized, and cryptographically verified (only when actual key possession has been proven). Show stable public-key fingerprints where protocol data permits.
4. Support out-of-band fingerprint comparison / QR verification, pin verified keys, and prominently warn on key changes. Never automatically equate a nickname, BLE address, or repeater route with a verified person.
5. Persist user rules locally, support undo and an audit/review queue, and avoid revealing a user's blocklist to the mesh.
6. Add tests for spoofed names, changed keys, duplicate floods, false positives, notification bypass, and benign high-volume channel traffic. Verify filtering never suppresses emergency alerts without an explicit user choice.

## Safety and acceptance
- Local block/mute is not network-level spam prevention; do not claim messages are prevented from being transmitted.
- Cryptographic verification must be based on a real protocol-supported key binding or out-of-band key comparison; no fabricated verification badges.
- Protect SOS, user-designated emergency contacts, and system control traffic with separately reviewed policies.
- Existing contacts and messages must remain accessible after upgrading.
