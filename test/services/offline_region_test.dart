import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/map_tile_cache_service.dart';

class _LocalCache implements BaseCacheManager {
  final Map<String, File> files = {};
  final List<String> requested = [];
  @override
  Future<FileInfo?> getFileFromCache(
    String key, {
    bool ignoreMemCache = false,
  }) async {
    requested.add(key);
    final file = files[key];
    return file == null
        ? null
        : FileInfo(
            file,
            FileSource.Cache,
            DateTime.now().add(const Duration(days: 1)),
            key,
          );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Unexpected cache operation: ${invocation.memberName}');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory temp;
  late _LocalCache local;
  late AppSettingsService settings;
  late MapTileCacheService cache;
  final bounds = LatLngBounds(const LatLng(0.1, 0.1), const LatLng(0.2, 0.2));
  const tile = 'https://tile.openstreetmap.org/3/4/3.png';
  setUp(() async {
    temp = await Directory.systemTemp.createTemp('bastion-map-test-');
    local = _LocalCache();
    settings = AppSettingsService();
    cache = MapTileCacheService(
      appSettingsService: settings,
      cacheManager: local,
    );
  });
  tearDown(() async {
    cache.dispose();
    settings.dispose();
    await temp.delete(recursive: true);
  });
  test('checks exact selected tiles locally without download calls', () async {
    final file = await File('${temp.path}/tile.png').writeAsBytes([1, 2, 3]);
    local.files[tile] = file;
    final result = await cache.verifyOfflineRegion(
      bounds: bounds,
      minZoom: 3,
      maxZoom: 3,
    );
    expect(result, (expected: 1, available: 1));
    expect(local.requested, [tile]);
  });
  test(
    'unrelated cached tile and deleted file cannot count as ready',
    () async {
      local.files['https://tile.openstreetmap.org/3/5/3.png'] = await File(
        '${temp.path}/other.png',
      ).writeAsBytes([1]);
      local.files[tile] = File('${temp.path}/deleted.png');
      expect(
        await cache.verifyOfflineRegion(bounds: bounds, minZoom: 3, maxZoom: 3),
        (expected: 1, available: 0),
      );
    },
  );
  test('zero-byte cached files remain missing', () async {
    local.files[tile] = await File('${temp.path}/empty.png').writeAsBytes([]);
    expect(
      await cache.verifyOfflineRegion(bounds: bounds, minZoom: 3, maxZoom: 3),
      (expected: 1, available: 0),
    );
  });
  test('huge selections stop before reading cache files', () async {
    final world = LatLngBounds(const LatLng(-80, -170), const LatLng(80, 170));
    await expectLater(
      cache.verifyOfflineRegion(bounds: world, minZoom: 18, maxZoom: 18),
      throwsStateError,
    );
    expect(local.requested, isEmpty);
  });
}
