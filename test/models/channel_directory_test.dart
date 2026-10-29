import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/models/channel_directory.dart';

void main() {
  test('reads entries, keeps name case, skips bad and repeated ones', () {
    final list = parseChannelDirectory('''
{"channels": [
  {"name": "#F1", "category": "interest", "description": "Racing"},
  {"name": "#test", "category": "test"},
  {"name": "#test", "category": "general"},
  {"name": "no-hash", "category": "general"},
  {"name": "#ok", "category": "nope"},
  {"name": "#far", "category": "local",
   "area": {"name": "X", "center": [95, 0], "radiusKm": 5}}
]}''');
    expect(list.map((e) => e.name), ['#F1', '#test']);
    expect(list.first.category, ChannelCategory.interest);
    expect(list[1].description, '');
  });

  test('garbage yields an empty list', () {
    expect(parseChannelDirectory('not json'), isEmpty);
    expect(parseChannelDirectory('{"channels": 3}'), isEmpty);
  });

  test(
    'nearby channels are those whose area holds the point, most local first',
    () {
      final list = parseChannelDirectory('''
{"channels": [
  {"name": "#state", "category": "local",
   "area": {"name": "State", "center": [47.4, -120.5], "radiusKm": 330}},
  {"name": "#city", "category": "local",
   "area": {"name": "City", "center": [47.61, -122.33], "radiusKm": 50}},
  {"name": "#elsewhere", "category": "local",
   "area": {"name": "Far", "center": [40.0, -75.0], "radiusKm": 50}},
  {"name": "#test", "category": "test"}
]}''');
      final near = channelsNear(list, const LatLng(47.62, -122.35));
      expect(near.map((e) => e.name), ['#city', '#state']);
    },
  );

  test('search matches name, description and area, ignoring # and case', () {
    final e = parseChannelDirectory(
      '''
{"channels": [{"name": "#pdx", "category": "local", "description": "Chat",
  "area": {"name": "Portland", "center": [45.5, -122.6], "radiusKm": 50}}]}''',
    ).single;
    expect(e.matches('#PDX'), isTrue);
    expect(e.matches('portland'), isTrue);
    expect(e.matches('chat'), isTrue);
    expect(e.matches('seattle'), isFalse);
  });

  test('every entry in the bundled list is valid', () {
    final raw = File('assets/channel_directory.json').readAsStringSync();
    final listed = RegExp(r'"name": "#').allMatches(raw).length;
    expect(parseChannelDirectory(raw), hasLength(listed));
  });
}
