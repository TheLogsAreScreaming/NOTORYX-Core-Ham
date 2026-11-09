/// The text of a forwarded message: the forwarding operator's call sign, who
/// wrote it, then what they wrote, so the forwarded copy identifies the
/// station sending it and is not mistaken for that station's own words.
String forwardedText({
  required String callsign,
  required String from,
  required String body,
}) => 'FWD de ${callsign.toUpperCase()} from ${from.trim()}: ${body.trim()}';
