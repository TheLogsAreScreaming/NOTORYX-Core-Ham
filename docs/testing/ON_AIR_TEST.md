# Two-station on-air test record

Fill in one copy of this for each on-air test, and commit it as `docs/testing/on-air-YYYY-MM-DD.md`. Until a completed record exists here, NOTORYX Core Ham has **not** been validated on the air.

Run it only under your licence, after coordination ([COORDINATION.md](../licensed-operator/COORDINATION.md)), at the lowest power that works.

## Setup

| | Station A | Station B | Repeater (optional) |
|---|---|---|---|
| Operator call sign | | | |
| Radio (board) | | | |
| Firmware build | | | |
| App version | | | |
| Antenna / dummy load | | | |
| TX power setting (dBm) | | | |
| Estimated output (from the app) | | | |
| Location (rough) | | | |

- Date and time (UTC):
- Frequency / BW / SF / CR:
- Distance between stations:
- Coordinated with (coordinator, band plan, local operators):

## Checks

| # | Check | Expected | Result | Notes |
|---|---|---|---|---|
| 1 | Radio named without a call sign, try to send | Nothing transmitted (other station hears nothing) | | |
| 2 | Name both radios `CALL-x`, Licensed operator shows **Ready to transmit** | Green banner | | |
| 3 | Adverts both ways | Each station appears in Nodes | | |
| 4 | Channel message A → B and B → A | Readable text; message details show **Heard from: CALL** | | |
| 5 | Direct message A → B and B → A | Delivered tick | | |
| 6 | Debug log on B shows the frame's station ID | `ID=CALL` | | |
| 7 | Via repeater: A and B only hear the repeater | Delivered; details show the repeater's call sign too | | |
| 8 | Repeater login with the right and a wrong password | Right logs in, wrong refused; password not readable in a monitor | | |
| 9 | Ordinary MeshCore radio on the same channel | Ham radios ignore it; it can't read ham traffic | | |
| 10 | Received-frame check with an SDR or second receiver (optional) | Call sign visible at the end of each frame | | |

## Outcome

- Passed / failed:
- Problems found (link issues):
- Recorded by:
