# NOTORYX Core MeshCore Bot Mode

This test build adds a local auto responder to the complete Bastion app (now NOTORYX Core) from branch `bastion`. It preserves the approved Bastion launcher icon, Android package `com.bastionmesh.bastion`, home dashboard, field tools, coverage capture/history, field stats, diagnostics, map/path hubs, repeater tools, messaging, and BLE/USB/TCP connections.

App Settings → NOTORYX Bot Mode provides a master toggle (off by default), an away
auto-responder, individually enabled commands, exact/keyword reply rules,
per-contact rules and an optional contact allowlist. Built-ins include `!ping`,
`!status`, `!battery`, `!help`, `!info`, `!checkin` and `!repeater`.
`!where` requires explicit location sharing; it reports advertised radio
coordinates, labelled as potentially stale, rather than claiming current GPS.

The first release is direct-message-only and accepts known chat contacts.
It excludes rooms, channels, CLI/reactions, self messages, initial reconnect
backlog and messages older than two minutes. Replies are labelled `[Bastion Bot]`.
Per-contact cooldown defaults to five minutes and the global cap to three
replies per minute. Budgets persist across restart; replies use the existing
message queue and retries. A queued reply is not proof of radio delivery.
Turning Bot Mode off prevents new bot sends; already queued transmissions
retain the normal messaging lifecycle.

No subscription or cloud service is required. The app must remain running and
connected. Background execution is OS-dependent; this is not an unattended
firmware bot or a guaranteed always-on service. Native background scheduling
and hardware validation are separate release gates.

Physical-radio and phone sleep/background validation remain pending. The existing BASTION_ROADMAP.md remains the project roadmap.
