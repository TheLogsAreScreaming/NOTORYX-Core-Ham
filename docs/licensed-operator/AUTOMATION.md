# Automation rules and Part 97

Tools → Automation lets the operator build rules: **when** some conditions are
true (combined with AND or OR), **then** run some actions.

| Conditions | Actions |
|---|---|
| Radio battery below a level | Send a message (contact, channel, or the working channel) |
| Time of day | Alert me (notification on this device) |
| Enter / leave an area (radio's position) | Change the working channel |
| Message received (direct/channel, sender, text) | Play a sound |
| Node online / offline (last heard) | Call a webhook (https, needs internet) |

Rules run only while the app is open. Every rule is off when created.

## Safeguards for automated transmissions

Only **Send a message** puts anything on air. For that action the app:

- **Holds the send unless the station is ready to transmit.** Same check as
  the Home station row (`stationReadiness`), but stricter: the radio must have
  reported ham firmware (`-ham` in its version) and a node name starting with
  the operator's call sign. The ham firmware sends plain text and adds the
  call sign to every frame, so automated traffic carries station ID and no
  encryption exactly like typed traffic. Stock MeshCore firmware is never used.
- **Marks the message.** Every automated message starts with `[auto] ` so
  listeners can tell it apart from operator traffic.
- **Limits the rate.** At most 3 automated messages in any 10 minutes across
  all rules, and a rule that transmits waits 15 minutes before it may fire
  again.
- **Breaks loops.** Message-received conditions ignore messages that start
  with `[auto]` or the bot prefix, so two stations' rules can't answer each
  other forever.
- **Logs every transmission.** Each automated send is written to the station
  log under *Automated transmissions* (time, rule, destination, band,
  frequency, text, station call sign) and can be exported as CSV. Held sends
  appear in the Automation page's activity list with the reason.
- **Never relays received traffic.** Message and alert texts can use
  placeholders. Alerts on this device may use `{rule} {time} {battery} {node}
  {text}`, but a message sent on air only fills `{rule} {time} {battery}`:
  `{node}` and `{text}` come out empty there, so a rule can't retransmit what
  another station sent.

## Webhooks

Webhook actions are off by default and labelled as needing internet. They only
run after the operator turns on *Allow webhooks*, only call `https://`
addresses, and only send the rule's name and the time. Nothing from the
internet is ever transmitted on air by a rule.

## Open question

§97.109(d) and §97.113(d) govern automatic control and automatic relays. A
rule that answers a received message is closest to that. The operator remains
the control operator for every automated transmission; check with the local
coordinator before leaving reply rules running unattended.
