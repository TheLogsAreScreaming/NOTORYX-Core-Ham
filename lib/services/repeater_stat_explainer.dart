/// Plain-language descriptions for repeater statistics.
///
/// Values are not converted into a health score: cumulative counters alone
/// cannot establish whether a repeater is currently operating well.
class RepeaterStatExplainer {
  static const Map<String, String> descriptions = <String, String>{
    'uptime': 'How long the repeater has been running since its last restart.',
    'tx_airtime': 'Total time the radio spent transmitting. This is a cumulative counter.',
    'rx_airtime': 'Total time the radio spent receiving. This is a cumulative counter.',
    'rssi': 'Signal strength of the last received packet. Less-negative dBm generally means stronger reception.',
    'snr': 'Signal compared with noise for the last packet. Higher values generally mean a clearer signal.',
    'noise_floor': 'Estimated background radio noise. Compare measurements over time rather than judging a single reading.',
    'packets_sent': 'Packets transmitted since the counter was last reset, including direct and flood traffic.',
    'packets_received': 'Packets successfully decoded by the repeater.',
    'duplicate_packets': 'Packets already seen. Multiple mesh paths can naturally produce duplicates.',
    'packet_errors': 'Radio activity that could not be decoded as valid MeshCore packets. Interference, overlapping transmissions, or incompatible traffic may contribute. This count can exceed successfully received packets.',
  };

  static String explain(String key) =>
      descriptions[key] ?? 'No explanation is available for this statistic.';

  static String diagnostics({
    required DateTime capturedAt,
    required Map<String, Object?> stats,
  }) {
    final buffer = StringBuffer('Repeater diagnostics\\n');
    buffer.writeln('Captured: ${capturedAt.toUtc().toIso8601String()} UTC');
    for (final entry in stats.entries) {
      if (!descriptions.containsKey(entry.key)) continue;
      final value = entry.value;
      if (value is! num && value is! String) continue;
      buffer.writeln('${entry.key}: $value');
    }
    buffer.writeln('Counters may be cumulative; no packet error rate is inferred.');
    return buffer.toString();
  }
}
