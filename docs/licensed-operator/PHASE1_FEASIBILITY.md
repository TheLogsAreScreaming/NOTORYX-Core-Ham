# Licensed Operator Mode — Phase 1 feasibility

Status: research only. Nothing here transmits, and no app or firmware code has
changed. Checked against NOTORYX Core `dev` @ 6fd72697 (10.0.0-rc.24) and
MeshCore `main` @ 81dbae59 (v1.18.0, companion `FIRMWARE_VER_CODE` 14).

Regulatory notes are an engineering reading of 47 CFR Part 97, not legal
advice. Items marked **verify** must be checked against the current eCFR text
before any feature that relies on them ships.

## Short answers to the three gating questions

| Question | Answer |
|---|---|
| Can MeshCore carry an amateur-compatible cleartext mesh? | **Not on stock firmware.** It needs a separate firmware build for companions *and* repeaters. The building blocks exist (see below), so the build is practical. |
| Can every transmitting station, including relays, be identified? | **Only with firmware-side ID.** Repeaters forward packets with no app attached, so the app can't ID for them. |
| Can hardware and firmware safely run above 1 W? | **Partly.** Firmware sets and reports the *chip* power (dBm into the PA), not the antenna output. Above-1 W boards exist, but the app has to supply per-board PA gain and treat ERP as an estimate. |

**Consequence:** the app-side PRs (settings, call sign, capability detection)
can go ahead now with transmissions disabled. Nothing amateur-specific should
transmit until a NOTORYX amateur firmware build exists and passes the tests.

## 1. How NOTORYX Core talks to the radio

* Transport: the MeshCore companion protocol over BLE, USB serial or TCP
  (`lib/connector/meshcore_connector*.dart`). Frames and command codes are in
  `lib/connector/meshcore_protocol.dart`.
* Radio settings:
  * `CMD_SET_RADIO_PARAMS` (11): `[freq Hz u32][bw Hz u32][sf][cr][repeat?]`.
    Firmware accepts 150–2500 MHz (limited further by the chip), BW
    7–500 kHz, SF 5–12, CR 5–8. Values persist in the radio's prefs.
  * `CMD_SET_RADIO_TX_POWER` (12): `[int8 dBm]`. Firmware rejects values
    below −9 dBm or above `MAX_LORA_TX_POWER`.
  * `SELF_INFO` (reply to `CMD_APP_START`) returns the current TX power and
    `MAX_LORA_TX_POWER`, plus freq/bw/sf/cr. The connector stores these as
    `_currentTxPower`, `_maxTxPower`, `_currentFreqHz` and so on
    (`meshcore_connector.dart` around line 5600). This is how we read the
    settings back to confirm they were applied (Phase 5).
* Sending arbitrary packets: `CMD_SEND_RAW_DATA` (25, direct route only) and
  `CMD_SEND_RAW_PACKET` (65, a whole pre-built packet, v1.16+). The SOS relay
  (#189) already uses 65.

## 2. What stock MeshCore puts on the air

Payload types (`src/Packet.h`) and whether their content is readable:

| Type | Content on air | OK under Part 97 §97.113(a)(4)? |
|---|---|---|
| `TXT_MSG` 0x02 (DM) | AES-128, ECDH key | No |
| `GRP_TXT` 0x05 / `GRP_DATA` 0x06 (channels) | AES-128, channel PSK | No (block it even on the public channel, whose key is published) |
| `REQ` / `RESPONSE` / `ANON_REQ` / `PATH` | AES-128 | No |
| `ADVERT` 0x04 | Cleartext name, location, Ed25519 signature | Yes. A signature authenticates; it does not hide meaning. **verify** (widely accepted, but no FCC ruling we know of) |
| `ACK` 0x03 | 4-byte hash of the acked message | Probably fine (a checksum, not a cipher). **verify** |
| `TRACE` 0x09 / `CONTROL` 0x0B | Cleartext hop hashes and SNR | Probably fine |
| `RAW_CUSTOM` 0x0F | Whatever the app puts in | Yes, if we put cleartext in |

Findings that decide the design:

1. **Turning off encryption is not a setting.** DMs, channels, logins,
   telemetry and path returns are all encrypted. There is no cleartext text
   message type.
2. **`RAW_CUSTOM` is cleartext but won't cross the mesh.** `Mesh.cpp`
   handles it only on direct routes and has the flood routing commented out
   ("don't flood route these (yet)").
3. **Stock repeaters forward everything.** `simple_repeater`'s
   `allowPacketForward` checks hop limits, region and loops, but never the
   payload type. A stock repeater on an amateur frequency would relay
   other people's encrypted DMs under its operator's licence.
4. **Companions send on their own.** Without being asked, a companion sends
   ACKs and PATH returns (encrypted) and, if client repeat is on, forwards
   any packet. In amateur mode the firmware must filter these, not the app.
5. **Frequency isolation is weak.** All MeshCore nodes use RadioLib's
   private sync word (`RADIOLIB_SX126X_SYNC_WORD_PRIVATE`). On the same
   freq/BW/SF, a Part 15 MeshCore node and an amateur node hear each other.

So the amateur network has to be a separate network: different
frequency/modem settings, and amateur firmware on every node, repeaters
included.

## 3. Proposed firmware shape (Phase 6 input)

One "NOTORYX amateur" build of companion and repeater, forked from MeshCore
(MIT). Every change sits behind an `ham_mode` pref so that with it off, the
build behaves like stock firmware.

* **Prefs:** `ham_mode` (bool), `callsign` (up to 10 chars), last ID time.
* **Send filter (Dispatcher level):** in ham mode only ADVERT, ACK, TRACE,
  CONTROL and the cleartext message type may be transmitted, whether
  originated or forwarded. Everything else is dropped and counted. This one
  check covers points 3 and 4.
* **Cleartext messages:** `RAW_CUSTOM` with flood routing enabled in the
  amateur build, and a small NOTORYX header:
  `[magic 'NX'][ver][flags][origin callsign\0][channel tag][text]`. The
  origin call goes in every message, so each originated packet identifies
  itself, and relays can see who sent it.
* **Station ID:** a firmware timer sends an ADVERT whose name begins with
  the call sign at least every 10 minutes while the station is transmitting,
  and once when it stops (an idle timeout). This runs on repeaters too, for
  the traffic they relay. With ham mode on and no valid call sign, the
  firmware refuses to transmit and returns an error to the app.
* **Capability flag:** a new `DEVICE_INFO` field (or a `CMD_GET_CUSTOM_VAR`
  key such as `ham.caps`) so the app can tell an amateur build from stock.
  Stock firmware answers "unsupported", and the app then stays in
  standard-only mode.
* **Enter/exit:** switching modes changes the frequency and reboots the
  radio, so encrypted contacts and channels never carry over into amateur
  mode.

Open firmware question: whether ACK/PATH need a cleartext variant so that
amateur DMs can be delivered reliably, or whether amateur mode is
broadcast-only at first. We recommend **broadcast-only for v1**.

## 4. Power and hardware

* The SX1262/SX1268 chip tops out around +22 dBm (~160 mW). Every MeshCore
  board above that uses an external PA. In firmware the "TX power" is the
  **drive into the PA**, and `MAX_LORA_TX_POWER` is a per-board ceiling on
  that drive. Examples from `variants/*/platformio.ini` (from the firmware
  comments; not measured by us):

  | Board | Default / max drive | Note in firmware |
  |---|---|---|
  | Heltec V4 | 10 / 22 dBm | 10 gives ~22 dBm out |
  | Heltec Tracker V2, T096 | 9 / 22 | ~+13 dB KCT8103L, up to ~28 dBm |
  | Heltec Tower V2 | 12 / 22 | up to ~29 dBm |
  | Station G2 | 7 / 19 | 7 gives ~27 dBm; 19 is "max without burning out the PA" |
  | Station G3 | 7 / — | depends on the PA level setting |
  | Meshnology W12 | 5 / 13 | 13 gives ~28 dBm (tinySA) |
  | Most others | 20–22 / 22 | no PA |

* **What follows for the app:**
  * The firmware can't report antenna output. The app needs a per-board
    PA-gain table, keyed by the model string from `DEVICE_INFO`, plus
    operator-entered external PA gain, feedline loss and antenna gain to
    estimate output and ERP. The UI must label these as estimates.
  * The app can't raise power above the board's `MAX_LORA_TX_POWER`, and
    shouldn't try. Above about 1 W in practice means a board like the Station
    G2 or an external amplifier, which the app can't detect.
  * Confirm a setting took by re-reading `SELF_INFO` after
    `CMD_SET_RADIO_TX_POWER`.
* **The 1 W figure comes from Part 15, not MeshCore.** §15.247 limits 902–928
  MHz devices to 1 W conducted. Under Part 97 the general limit is 1500 W PEP
  (§97.313), but see the spread-spectrum cap below.

## 5. Part 97 points that shape the design

| Rule | What it means here |
|---|---|
| §97.113(a)(4): no messages encoded to obscure their meaning | Drives the whole send-filter design (section 3). |
| §97.119: ID every 10 min and at the end of a communication; a digital ID is allowed when the communication uses that digital mode | ADVERT carrying the call sign, plus the call in every message header. **verify** that an ADVERT counts as a "specified digital code" ID. Optional CW ID is a fallback, but the SX126x can't easily send it. |
| §97.311 spread-spectrum emissions: allowed only on 222 MHz and up; **10 W PEP maximum** | LoRa is chirp spread spectrum. If the FCC treats it as SS, amateur LoRa is capped at **10 W PEP**. Until that is settled, the app should **hard-cap at 10 W estimated output**. **verify** |
| §97.303 band sharing | 33 cm (902–928 MHz) is secondary to government radiolocation and shared with ISM and location services. Parts of CO, WY, TX and NM are excluded. **verify** the exact areas. 70 cm (420–450) has its own exclusions near the borders. |
| §97.305 / §97.307(f) emission and bandwidth limits | 70 cm data may be bandwidth-limited (around 100 kHz?), which would rule out MeshCore's usual 125/250 kHz BW there. **verify**. 33 cm is the simpler first target. |
| §97.205 / §97.221: repeaters and automatic control | Automatically controlled data stations are allowed on 6 m and shorter, so unattended repeaters on 33 cm look OK. Each repeater needs a licensed control operator and its own call sign. |
| §97.115: third-party traffic | Only licensed stations should originate traffic. No bridging from the Part 15 mesh, MQTT or the internet into the amateur mesh in v1. |
| §97.313: use the minimum power necessary | The UI should default low and say so. |
| §97.13(c): RF exposure evaluation | Required at these power levels. Link to it in the user guide. |
| Licence class | Technician and above have full privileges on 33 cm and 70 cm, so class doesn't change what's allowed for UHF LoRa. Keep the field for the profile, but don't gate anything on it. |

## 6. Effect on the roadmap

* **Can start now (no transmissions):** PR 1 settings and toggle, PR 2 call
  sign validation and profile, PR 3 capability detection (it will always
  report "stock: unsupported" for now), and PR 9's simulated tests.
* **Firmware first:** PRs 4, 5, 7 and 8 depend on the amateur build. Most of
  the encryption, ID and forwarding safeguards belong *in firmware*, with the
  app adding a second check.
* **PR 6 (power):** the UI and ERP estimate can be built early. The 10 W cap
  and band rules wait on the **verify** items.
* **Suggested first firmware target:** 33 cm only, broadcast-only cleartext
  messages, companion + repeater, tested in mcsim before any radio
  transmits.

## Decisions needed

1. Where the amateur firmware fork lives (for example
   `TheLogsAreScreaming/notoryx-meshcore-ham`).
2. Whether v1 is broadcast-only (recommended) or also carries cleartext DMs.
3. Whether to accept the 10 W SS cap as the product limit until someone
   gets a ruling.
