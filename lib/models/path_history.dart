class PathRecord {
  final int hopCount;
  final int tripTimeMs;
  final DateTime? timestamp;
  final bool wasFloodDiscovery;
  final List<int> pathBytes;
  final int successCount;
  final int failureCount;
  final double routeWeight;

  PathRecord({
    required this.hopCount,
    required this.tripTimeMs,
    required this.timestamp,
    required this.wasFloodDiscovery,
    required this.pathBytes,
    required this.successCount,
    required this.failureCount,
    this.routeWeight = 1.0,
  });

  /// Bytes per hop in [pathBytes]: each hop is a 1-, 2- or 3-byte prefix
  /// of the repeater's key, depending on the path hash mode it was heard
  /// with. Worked out from the stored bytes and hop count; 1 when they
  /// don't divide evenly.
  int get hashByteWidth {
    if (hopCount <= 0 || pathBytes.isEmpty) return 1;
    if (pathBytes.length % hopCount != 0) return 1;
    final width = pathBytes.length ~/ hopCount;
    return width >= 1 && width <= 3 ? width : 1;
  }

  String get displayText =>
      '$hopCount ${hopCount == 1 ? 'hop' : 'hops'} - ${(tripTimeMs / 1000).toStringAsFixed(2)}s';

  Map<String, dynamic> toJson() {
    return {
      'hop_count': hopCount,
      'trip_time_ms': tripTimeMs,
      'timestamp': timestamp?.toIso8601String(),
      'was_flood': wasFloodDiscovery,
      'path_bytes': pathBytes,
      'success_count': successCount,
      'failure_count': failureCount,
      'route_weight': routeWeight,
    };
  }

  factory PathRecord.fromJson(Map<String, dynamic> json) {
    return PathRecord(
      hopCount: json['hop_count'] as int,
      tripTimeMs: json['trip_time_ms'] as int,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
      wasFloodDiscovery: json['was_flood'] as bool,
      pathBytes:
          (json['path_bytes'] as List?)?.map((b) => b as int).toList() ?? [],
      successCount: json['success_count'] as int? ?? 0,
      failureCount: json['failure_count'] as int? ?? 0,
      routeWeight: (json['route_weight'] as num?)?.toDouble() ?? 1.0,
    );
  }
}

class ContactPathHistory {
  final String contactPubKeyHex;
  final List<PathRecord> recentPaths;

  ContactPathHistory({
    required this.contactPubKeyHex,
    required this.recentPaths,
  });

  PathRecord? get fastest {
    if (recentPaths.isEmpty) return null;
    return recentPaths.reduce((a, b) => a.tripTimeMs < b.tripTimeMs ? a : b);
  }

  PathRecord? get mostRecent {
    if (recentPaths.isEmpty) return null;
    return recentPaths.first;
  }

  Map<String, dynamic> toJson() {
    return {'recent_paths': recentPaths.map((p) => p.toJson()).toList()};
  }

  factory ContactPathHistory.fromJson(
    String contactPubKeyHex,
    Map<String, dynamic> json,
  ) {
    final pathsList =
        (json['recent_paths'] as List?)
            ?.map((p) => PathRecord.fromJson(p as Map<String, dynamic>))
            .toList() ??
        [];

    return ContactPathHistory(
      contactPubKeyHex: contactPubKeyHex,
      recentPaths: pathsList,
    );
  }
}
