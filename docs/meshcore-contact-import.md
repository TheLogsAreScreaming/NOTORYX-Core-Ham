# MeshCore compatibility: first increment

Compared against [Mike Carper's MeshCore documentation](https://mikecarper.github.io/MeshCore/) on 2026-10-27.

## Why contact links first

Notoryx already generates and reads the documented `meshcore://contact/add` links in chat. However, Nodes → More options → Add Contact from Clipboard only accepted the older `meshcore://<advertisement hex>` form. A contact URL shared by another compatible app could therefore be read in chat but not pasted into the contact list.

The clipboard action now previews a standard contact URL using the same contact card as chat. The user explicitly selects **Add contact**; closing the preview sends nothing. Existing contacts and the local identity cannot be added through the card. After the radio acknowledges a new contact, the card prevents repeat additions while the contact list refreshes. A rejected operation remains retryable.

The shared URL parser supports the four [documented contact types](https://mikecarper.github.io/MeshCore/qr_codes/), URL-encoded names and a 32-byte hexadecimal public key. It rejects duplicate identity parameters, malformed encoding and invalid explicit types. The pre-existing defaults for an absent type/name remain compatible. Legacy advertisement imports remain supported, with hex and frame-size validation before sending.

## Comparison and deferred work

| Area | Existing Notoryx implementation | Decision |
| --- | --- | --- |
| Standard contact links | Chat sharing, parser, contact preview and acknowledged add operation | Reuse these in clipboard import; harden validation and repeated-add behavior. |
| Offline messaging | Connector queue synchronization and message retry service | The documented [offline queue](https://mikecarper.github.io/MeshCore/companion_offline_queue/) is firmware-owned and volatile; changing its capacity is not an app enhancement. |
| Telemetry | Cayenne LPP decoding, telemetry screen and sensor subscriptions | The site's [history decoder](https://mikecarper.github.io/MeshCore/telemetry_decoder/) handles additional firmware-specific formats. Add only with format fixtures and capability checks in a later increment. |
| Channel QR links | Community QR sharing uses Notoryx's own community model | Standard channel links and optional region scope need an explicit mapping to channel/community behavior before importing secrets. |
| Firmware updates and fleet controls | Existing CLI and repeater management flows | Defer commands that change firmware or network policy until compatibility and hardware behavior can be validated. |

## Protocol and validation

No command IDs, transport behavior, firmware settings or radio parameters change. Standard contact imports reuse `addContactFromLink`: `CMD_ADD_UPDATE_CONTACT`, unknown route (`0xFF`), acknowledged completion, then contact refresh. Legacy advertisements continue using `CMD_IMPORT_CONTACT`.

Regression coverage includes the documentation example, all four types, encoded names, malformed and ambiguous input, explicit user confirmation, cancellation, duplicate preservation, acknowledgement timing, rejection, and legacy advertisement compatibility. Real-radio/camera testing is outside these automated tests; this increment adds no camera scanner or OS deep-link handler.
