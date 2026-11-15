import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/backdrop_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences prefs;
  late Directory dir;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    dir = await Directory.systemTemp.createTemp('backdrop_test');
  });

  tearDown(() async {
    if (await dir.exists()) await dir.delete(recursive: true);
  });

  test('defaults to the theme', () {
    final store = BackdropStore(prefs: prefs, folder: dir);
    expect(store.style.kind, BackdropKind.theme);
    expect(store.style.isCustom, isFalse);
  });

  test('style survives a reload', () async {
    final store = BackdropStore(prefs: prefs, folder: dir);
    await store.setStyle(
      const BackdropStyle(
        kind: BackdropKind.mesh,
        color1: 0xFF0B1F3A,
        color2: 0xFFDB2777,
        dim: 0.6,
      ),
    );
    final again = BackdropStore(prefs: prefs, folder: dir);
    expect(again.style.kind, BackdropKind.mesh);
    expect(again.style.color2, 0xFFDB2777);
    expect(again.style.dim, 0.6);
  });

  test('dim and blur are kept in range', () {
    final s = const BackdropStyle().copyWith(dim: 0, blur: 999);
    expect(s.dim, BackdropStyle.minDim);
    expect(s.blur, BackdropStyle.maxBlur);
    final parsed = BackdropStyle.fromJson({'kind': 'solid', 'dim': 5});
    expect(parsed.dim, BackdropStyle.maxDim);
  });

  test('unknown or damaged values fall back to the theme', () async {
    expect(
      BackdropStyle.fromJson({'kind': 'hologram'}).kind,
      BackdropKind.theme,
    );
    await prefs.setString(BackdropStore.prefsKey, '{nope');
    expect(
      BackdropStore(prefs: prefs, folder: dir).style.kind,
      BackdropKind.theme,
    );
  });

  test('a photo is saved to a file and reset deletes it', () async {
    final store = BackdropStore(prefs: prefs, folder: dir);
    final ok = await store.setPhoto(Uint8List.fromList([1, 2, 3, 4]));
    expect(ok, isTrue);
    expect(store.style.kind, BackdropKind.photo);
    final file = File('${dir.path}/${BackdropStore.photoFileName}');
    expect(await file.readAsBytes(), [1, 2, 3, 4]);

    await store.reset();
    expect(await file.exists(), isFalse);
    expect(store.style.kind, BackdropKind.theme);
    expect(store.photo, isNull);
  });

  test('listeners hear every change', () async {
    final store = BackdropStore(prefs: prefs, folder: dir);
    var calls = 0;
    store.addListener(() => calls++);
    await store.setStyle(const BackdropStyle(kind: BackdropKind.solid));
    store.reload();
    expect(calls, 2);
  });
}
