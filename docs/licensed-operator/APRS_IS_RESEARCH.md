# APRS-IS gateway and third-party traffic: research

**NOTORYX Core Ham is for licensed amateur radio operators, and should only be used after a great deal of coordination with the people and services around you.** See [COORDINATION.md](COORDINATION.md).

Researched 2026-11-08 from the current rule text and the APRS-IS documentation. This is not legal advice, and no code has been written from it.

## Recommendation

| Option | Verdict | Why |
|---|---|---|
| Send **your own station's position** to APRS-IS, internet only, opt-in | **Go, if wanted** | Nothing is transmitted on RF, so §97.115 isn't engaged |
| Gate **other stations'** mesh positions to APRS-IS | **No-go for now** | Their call sign comes from a self-set name, and they haven't agreed to it |
| Internet or MQTT **to RF**, any traffic | **No-go** | Third-party, automatic control and accountability all land on the gateway operator; needs coordinator and legal input |

## What the rules say

- **§97.115(a):** third-party messages may go to stations in US jurisdiction. Foreign stations only where an arrangement exists, or for emergencies.
- **§97.115(b):** a third party may take part in stating a message only with the control operator at the control point, continuously monitoring and supervising. Some former licensees and people under cease-and-desist orders are barred.
- **§97.115(c):** no third-party traffic under automatic control, *except* RTTY or data emissions. LoRa text is plausibly a data emission, but nothing found says so directly.
- **§97.219:** in message forwarding, the originating control operator is primarily accountable. The **first forwarding station must authenticate** the station it accepts traffic from, or accept accountability for it. An internet-to-RF gateway would be that first station.
- **§97.109(d) and §97.221(b):** automatic control is only for stations designated in Part 97. RTTY or data on 6 m and shorter wavelengths is designated.
- **§97.113(c):** no retransmitting signals from non-amateur stations. This rules out relaying Part 15 mesh traffic onto ham frequencies.

## Open question that affects repeaters today

**§97.113(d)** says only auxiliary, repeater or space stations may automatically retransmit the radio signals of other amateur stations. A NOTORYX repeater relays automatically. Whether it counts as a repeater station, a message forwarding system, or an automatically controlled digital station decides which limits apply, including the band segments for repeater stations. This research found no FCC or ARRL statement on LoRa mesh relays. Ask your coordinator, and get a qualified opinion before running unattended relays.

## What APRS-IS requires

- Login: `user CALL[-SSID] pass PASSCODE vers SOFTWARE VERSION`. Software name and version are one word each. `pass -1` is receive-only.
- Only clients with a valid passcode can send. The documentation makes **software authors responsible** for giving passcodes to their users, and keeps APRS-IS for amateur use. The app should ask the operator to enter their own, and never generate one.
- Packets a client originates carry `TCPIP*` as the path.
- Lines are limited to 512 bytes. Port 14580 is the filtered port. Port 10152 is the full feed and shouldn't be used here.
- Servers check duplicates over a 30-second window.
- IGates mark RF-heard packets `qAR`, or `qAO` when receive-only. These rules assume APRS packets heard on RF. Mesh frames aren't APRS, so converting them is outside what the specification covers.
- Internet-to-RF gating has its own checks: the recipient heard locally, the sender not heard on RF, and third-party format.
- No numeric rate limit was found.

## If the "go" option is built

1. Off by default, in Licensed operator settings.
2. Your call sign from the operator profile, and a passcode you type in, stored in secure storage.
3. Your own position only, in a documented APRS format with `TCPIP*`.
4. Send on manual request or at a slow interval. Thirty minutes is our suggestion, not a published limit.
5. Sends only over the internet, and never passes anything to the radio.
6. Check the software identification with the APRS-IS maintainers before release.

## Sources

- [47 CFR 97.113](https://www.law.cornell.edu/cfr/text/47/97.113), [97.109](https://www.law.cornell.edu/cfr/text/47/97.109), [97.115](https://www.law.cornell.edu/cfr/text/47/97.115), [97.219](https://www.law.cornell.edu/cfr/text/47/97.219), [97.221](https://www.law.cornell.edu/cfr/text/47/97.221)
- [APRS-IS: Connecting](https://aprs-is.net/Connecting.aspx), [IGate details](https://aprs-is.net/IGateDetails.aspx), [q construct](https://aprs-is.net/q.aspx)
