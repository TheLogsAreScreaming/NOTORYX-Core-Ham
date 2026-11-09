# Automatic station ID audit

**Audited:** 2026-11-09, firmware `main` at `5e5bae7`, read from source. **Nothing here was tested on the air**, and this is not a legal opinion.

Use NOTORYX Core Ham only after a great deal of coordination with your frequency coordinator and the other stations on your net.

## What the firmware does

| Check | Result | Where |
|---|---|---|
| Every mesh transmission carries the call sign | **Yes.** The dispatcher adds it to the end of every frame, including relayed frames, which carry the relaying station's call | `src/Dispatcher.cpp`, `checkSend` |
| A station with no valid call sign can't transmit | **Yes.** The packet is dropped and counted in `n_tx_blocked` | `src/Dispatcher.cpp`, `checkSend` |
| All roles supply a name | **Yes:** companion, repeater, room server, sensor and secure chat. A role without one defaults to NULL and is blocked | `getNodeName()` |
| The call sign is readable | **Yes.** It is plain ASCII, zero padded to 8 bytes, and is not encrypted | `AmateurStation.h` |
| The name must start with a valid US call | **Yes** for settings, through `isNodeNameAllowed` | `AmateurStation.h` |
| Another direct path to the radio | **One: see the finding below** | `examples/kiss_modem` |

## Finding: KISS modem builds send no station ID

`examples/kiss_modem/KissModem.cpp` calls `startSendRaw` directly, with no call sign and no check for one. The `*_kiss_modem` build targets are still in the firmware tree.

These builds are not in the NOTORYX test firmware kit. Nothing should be flashed from those targets for amateur use until they are removed or made to refuse to transmit.

## What the app adds

- SALUTE, 9-Line and forwarded messages put the call sign in the text as well.
- The Licensed operator screen warns when a direct advert's station ID doesn't match its name, and when a radio runs stock firmware.
- The RX log shows the station ID on every packet.

## Questions for a coordinator or qualified adviser

1. **§97.119(a)** asks for ID at the end of a communication and at least every 10 minutes. Sending it in every frame should cover that timing, but a station that goes quiet sends nothing further, which seems consistent with the rule.
2. **§97.119(b)** sets out how ID may be sent. Whether an 8-byte ASCII trailer in a LoRa frame counts as an accepted digital ID method is **not settled** by anything found so far. A conventional CW or phone ID would remove the doubt.
3. Automatic relays remain subject to the open §97.113(d) question in [APRS_IS_RESEARCH.md](APRS_IS_RESEARCH.md).
