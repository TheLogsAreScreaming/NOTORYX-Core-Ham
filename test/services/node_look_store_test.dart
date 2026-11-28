import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/node_look_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  test('colour and photo are kept separately and survive a reload', () async {
    final store = NodeLookStore(prefs: prefs);
    await store.setColor('ABCDEF', 0xFF1E88E5);
    await store.setPhoto('abcdef', Uint8List.fromList([1, 2, 3]));

    final again = NodeLookStore(prefs: prefs);
    final look = again.lookFor('AbCdEf');
    expect(look, isNotNull);
    expect(look!.colorValue, 0xFF1E88E5);
    expect(look.photo, [1, 2, 3]);
  });

  test('removing the photo keeps the colour', () async {
    final store = NodeLookStore(prefs: prefs);
    await store.setColor('aa', 0xFFE53935);
    await store.setPhoto('aa', Uint8List.fromList([9]));
    await store.setPhoto('aa', null);
    expect(store.lookFor('aa')!.photo, isNull);
    expect(store.lookFor('aa')!.colorValue, 0xFFE53935);
  });

  test('clear removes the node entirely', () async {
    final store = NodeLookStore(prefs: prefs);
    await store.setColor('aa', 0xFFE53935);
    await store.clear('aa');
    expect(store.lookFor('aa'), isNull);
    expect(prefs.getString(NodeLookStore.prefsKey), '{}');
  });

  test('photos over the size limit are refused', () async {
    final store = NodeLookStore(prefs: prefs);
    expect(
      () => store.setPhoto('aa', Uint8List(NodeLookStore.maxPhotoBytes + 1)),
      throwsArgumentError,
    );
    expect(store.lookFor('aa'), isNull);
  });

  test('a damaged preference starts fresh instead of crashing', () async {
    await prefs.setString(NodeLookStore.prefsKey, 'not json');
    final store = NodeLookStore(prefs: prefs);
    expect(store.lookFor('aa'), isNull);
    await store.setColor('aa', 0xFF7CB342);
    expect(store.lookFor('aa')!.colorValue, 0xFF7CB342);
  });

  test('listeners hear changes and reload', () async {
    final store = NodeLookStore(prefs: prefs);
    var calls = 0;
    store.addListener(() => calls++);
    await store.setColor('aa', 0xFF7CB342);
    store.reload();
    expect(calls, 2);
  });
}
