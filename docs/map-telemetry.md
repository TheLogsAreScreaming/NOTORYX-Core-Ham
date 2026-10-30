# Cached map telemetry

The map's Telemetry chip is off by default. Turning it on displays cached readings for visible nodes and the local radio; it does not request packets. Select Battery (reported voltage), Temperature, Humidity, or Pressure. Readings dim after one hour and disappear after 24 hours. A local minute timer updates their age even when no packets arrive.

Select a node to inspect all supported cached measurements, their channels, age, and source. Refresh opens the existing telemetry screen and sends its usual request. Firmware access rules and sensor login still apply. No background polling, subscription creation, new on-air protocol, or third-party upload is added.

The app keeps at most 256 nodes and 32 measurements per node, separately for each connected radio identity, in local preferences. It stores the latest supported reading per channel/type. A battery-only update does not renew older temperature or GPS timestamps. The cache is not encrypted and may include coordinates already received from consenting nodes. Expired readings are omitted on load and removed on subsequent saves. Unit formatting follows Settings → Units.

A generic LPP percentage is displayed as a percentage, not assumed to mean battery charge. Voltage remains neutral because chemistry and cell counts vary; temperature uses cold-to-hot colours. This avoids presenting invented battery percentages or charge warnings.

## Validation before release

Automated coverage includes partial updates, stale/expired readings, persistence, corrupt data, radio identity isolation, capacity limits, local sensor/status/subscription feeds, and viewport/layer filtering. Existing sensor tests cover Imperial units. All UI labels reuse the translated app strings; the new policy explanation is translated into all 18 supported languages.

Physical-device checks remain required:

1. Finish rc.20 validation: confirm region tags against a known scoped mesh, and wardrive GPS fixes, discover replies, and saved sessions on a real radio.
2. With telemetry disabled, verify that map navigation sends no new telemetry requests. Enable it and pan/zoom; only cached visible nodes should get badges.
3. Read local Sensors, a remote telemetry screen, repeater Status, and a logged-in sensor subscription. Confirm source, channel, and values in the map card.
4. Test a node that denies telemetry or requires login. Confirm cached values remain honest and the existing request screen reports failure/timeout.
5. Switch radio identities and restart. Verify cache isolation and persistence, including no stale data relabeled as fresh.
6. Check Metric/Imperial units, narrow and landscape layouts, large text, and light/dark map styles.
7. Compare the radio packet log before/after enabling the overlay. Assess airtime before proposing any automatic refresh feature.

Automatic per-favourite refresh is deliberately deferred pending the real-radio airtime check. This change does not bump a release version or publish/install a build.
