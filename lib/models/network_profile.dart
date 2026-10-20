/// A saved, user-defined radio configuration. Secrets and private keys are
/// deliberately excluded; applying a profile must never replace identity keys.
class NetworkProfile {
  final String id;
  final String name;
  final Map<String, String> settings;

  NetworkProfile({
    required this.id,
    required this.name,
    required Map<String, String> settings,
  }) : settings = Map.unmodifiable(settings);

  /// Produces a read-only preview. Does not write to a connected radio.
  List<NetworkSettingChange> previewAgainst(Map<String, String> current) {
    final changes = <NetworkSettingChange>[];
    for (final entry in settings.entries) {
      if (!_allowedSettings.contains(entry.key)) continue;
      final previous = current[entry.key];
      if (previous != entry.value) {
        changes.add(NetworkSettingChange(
          setting: entry.key,
          previous: previous,
          proposed: entry.value,
        ));
      }
    }
    return List.unmodifiable(changes);
  }

  /// Deliberate allowlist: no credentials, identity keys, or channel secrets.
  static const Set<String> _allowedSettings = {
    'frequency',
    'bandwidth',
    'spreading_factor',
    'coding_rate',
    'tx_power',
  };
}

class NetworkSettingChange {
  final String setting;
  final String? previous;
  final String proposed;

  const NetworkSettingChange({
    required this.setting,
    required this.previous,
    required this.proposed,
  });
}
