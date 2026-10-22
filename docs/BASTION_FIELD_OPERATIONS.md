# Bastion Field Operations test build

Adds Trip Mode, previewed check-ins, local Field Log, trip readiness, observed coverage-session comparisons, connection explanations and opt-in local automations. Preserves the original Bastion (now NOTORYX Core) feature suite and Bot Mode. Changes the app and original castle icon to charcoal, muted teal and warm ivory.

Trip contacts are restricted to up to six known chat contacts. Position and battery sharing start off. Check-ins use existing message/retry handling; Field Log distinguishes pending, sent, delivered and failed. Acknowledgment does not prove a person read the message. Contact activity badges are not emergency conclusions. Positions are radio advertisements and may be stale; no phone GPS is invented.

Automations start off each restart. Individual rules default to dry-run and support reconnect, disconnect, low battery, new node/repeater and scheduled check-in events. Actions can log, post permission-gated local notifications or send a trip check-in. Rules have a ten-minute cooldown and automatic transmissions are limited to one recipient batch per ten minutes. Intervals range from fifteen minutes to a day. The app must be foregrounded and connected for sends; late timers log missed actions instead of replaying them. Trip state stops on restart.

Field Log stores up to 1,000 entries locally with search, JSON share and confirmed deletion. Exports can contain private messages and contact keys. Coverage comparison shows recorder-position dots and shared/new/missing node counts, with no interpolated coverage claims or per-node RSSI attribution. Readiness inspects actual map cache inventory but does not claim complete route coverage.

Requires Flutter analyzer/format/tests and Android packaged icon/package verification. Physical-radio, screen-reader, phone sleep and signing-upgrade validation remain pending before production. No public release or Play Store submission is performed by this PR.
