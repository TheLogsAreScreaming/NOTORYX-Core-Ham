# NOTORYX Core field validation

This test build preserves the original MeshCore feature suite and adds Trip Mode,
previewed check-ins, Field Log, local automations, coverage comparison and a calmer
palette. The dashboard displays NOTORYX, Communication without infrastructure.,
and MeshCore. It shows unread messages and trip state, and opens a check-in preview.

Offline readiness checks the selected map rectangle and zoom range against the
current tile URL source and actual nonempty local files. It reports available,
expected and missing tiles without making network download requests. Large areas
(over 50,000 tiles) require a smaller selection. It does not prove map image
integrity, permanent retention or radio coverage. Inspect the selected area without
internet before leaving. Map download restrictions remain those of the selected
provider; use the existing Offline maps screen to select/download allowed areas.

Field notes can optionally save the radio-advertised position (off by default,
possibly stale, not phone GPS). Coverage maps distinguish notes/dead-zone reports
from heard-node observations. Logs preserve trip names and can be searched by trip.
A heard node does not prove a successful bidirectional link. No interpolated
coverage heatmap or range guarantee is provided.

Bot Mode ignores `[Bastion Check-in]` messages, preventing automatic replies from
creating needless traffic. Trip activity and the automation master switch never
resume silently after restart. Automations run only while the app is active;
missed schedules never create catch-up transmission bursts.

## Automated validation

- Strict analyzer and formatting checks; complete Flutter test suite.
- Field policy: restart privacy, missed schedules, cooldowns, backward clock,
  bounded recipients, position disclosure and precise message-state descriptions.
- Service: persisted transmission budget, dry runs, corrupt-storage retention,
  disconnected/inactive send blocking, and actual queued/acknowledged status.
- Offline map checks: exact local URL, unrelated tile exclusion, missing/empty
  file exclusion, no network calls and bounded selections.
- Palette contrast: text/buttons in dark and light themes.
- Android workflow: approved icon checksum, package and launcher resources,
  release APK and private artifact upload.

## Physical tests still required

Record phone/Android version, radio model/firmware, transport, app build and time.
Do not mark these passed without real-device evidence.

| Scenario | Required observation |
| --- | --- |
| Upgrade existing Bastion install | Saved contacts/settings/history remain. If signing rejects the upgrade, retain installation/data and record the exact error. |
| BLE disconnect/reconnect | Accurate dashboard state; no send while disconnected; initial contact load does not trigger a new-node flood. |
| USB removal/reconnect | No crash; accurate connection state; stopped recipient batch is logged. |
| TCP outage/reconnect | Accurate state and message status, with no false acknowledgement. |
| Weak/no radio path | Queued/sent/acknowledged/failed remain distinct; acknowledgement never implies reading. |
| Lock phone/app background | Field automations stop; after returning, missed events are logged without catch-up sends. Bot/background radio behavior must be measured separately. |
| Restart app | Trip and automation master are off; notes/rules/log remain saved. |
| Check-in | Exact recipient roster and text shown before sending; location omitted unless opted in. |
| No internet maps | Selected region/zoom levels display from cache; missing tiles remain visibly missing. |
| Local observations | Trip/time/optional advertised position survive restart and export; no public upload. |
| Long session/low battery | Battery reporting is honest, automation cooldowns hold, and app remains responsive. |

No PR merge or public release is part of this validation work.
