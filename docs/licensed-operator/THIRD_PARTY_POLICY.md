# Third-party and automatic traffic policy

**NOTORYX Core Ham is for licensed amateur radio operators, and should only be used after a great deal of coordination with the people and services around you.** See [COORDINATION.md](COORDINATION.md).

This is the project's working policy, based on the [APRS-IS research](APRS_IS_RESEARCH.md). It is not legal advice. The control operator of each station is responsible for what it transmits.

## Policy

1. Only licensed operators originate traffic on the amateur mesh.
2. Traffic heard only over MQTT or the internet is shown in the app and never relayed to RF.
3. Part 15 mesh traffic is never relayed onto amateur frequencies (§97.113(c)).
4. Features that transmit automatically are off by default and need a deliberate opt-in.
5. Nothing on the air is encrypted, and each frame carries a station ID.
6. If you turn on an automatic feature, you remain the control operator of everything it sends.

## What the app does today

| Path | Default | Status against this policy |
|---|---|---|
| MQTT to the radio | None exists | Meets it: MQTT messages are marked **via MQTT**, and the bot doesn't answer them |
| Observer sharing, RF to MQTT | Off | Receive side only, nothing transmitted |
| SOS and trip check-ins | Off until set up | Operator-initiated or scheduled; your own traffic |
| Bot Mode replies | Off | Automatic transmissions triggered by another station. Under review |
| Internet weather on RF | Removed | `!weather` and weather alert posts were removed from this app |

## Under review

Bot Mode replies are the only path where text is sent on RF without an operator pressing Send, apart from check-ins you schedule yourself. §97.115(c) permits third-party traffic under automatic control for data emissions, and §97.221(b) allows automatic data on these bands. Nothing found settles this for LoRa mesh text.

Until it's settled, don't enable Bot Mode on the air without your coordinator's agreement.

The two internet weather features were removed rather than reviewed: §97.113(c) has an exception for some US Government weather information, but it speaks of radio stations, and it isn't clear that it reaches text fetched from a website.
