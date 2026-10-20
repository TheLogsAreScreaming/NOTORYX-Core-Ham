# Repeater Admin: plain-language statistics and diagnostics

## Goal
Make existing repeater statistics understandable to new MeshCore users without suggesting that cumulative packet errors alone prove a repeater is unhealthy.

## User-facing first release
- Place a compact **What does this mean?** control beside each existing Repeater Admin statistic, using accessible descriptions and examples.
- Explain uptime, TX/RX airtime, RSSI, SNR, noise floor, sent/received flood/direct packets, duplicates, and received packet errors.
- Specifically explain that a LoRa signal can be detected but fail MeshCore decoding, so received packet errors can exceed successful packets received.
- Add **Copy diagnostics** to produce timestamped, sanitized, human-readable text containing only visible stats, firmware metadata where available, and counter caveats. Do not export passwords, keys, or precise coordinates without explicit opt-in.
- Use neutral labels such as *Needs more data* rather than health scores based on lifetime counters.

## Follow-on tools
- Capture timestamped snapshots locally, detect resets/wraparound, and calculate interval rates (5/15/60 minutes) only when sufficient samples exist.
- Show changes over time and suggest non-destructive troubleshooting (antenna, placement, RF interference, mismatched radio settings).
- Distinguish raw RF receive/decoder errors from valid MeshCore packet counts; avoid claiming a true packet-error percentage without a compatible denominator.

## Implementation and verification
1. Locate the existing Repeater Admin status view and its data model; reuse existing polling, no duplicate radio requests.
2. Add small help text/info icons and a testable formatter for the diagnostics summary.
3. Add widget/unit tests for descriptions, unknown/missing values, large counters, copy redaction, and accessibility.
4. Only then add persistent time-series sampling and rate calculations with reset detection.
5. Verify Flutter analyze/test and hardware display against an actual repeater.

**Status:** design/implementation checklist only; not yet wired into the app UI.
