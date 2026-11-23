import 'dart:io';

import 'package:path_provider/path_provider.dart';

const _fileName = 'discovered_contacts.json';

/// Where the heard-node list is kept, or null when there is no app support
/// folder (tests without the path_provider plugin), so callers fall back to
/// preferences.
Future<String?> discoveryDirectory() async {
  try {
    return (await getApplicationSupportDirectory()).path;
  } on Object {
    return null;
  }
}

/// The saved list, or null when it has never been written.
Future<String?> readDiscoveryFile(String directory) async {
  final file = File('$directory/$_fileName');
  if (!await file.exists()) return null;
  return file.readAsString();
}

/// Writes to a temporary file and renames it, so a crash mid-write never
/// leaves a half-written list.
Future<void> writeDiscoveryFile(String directory, String json) async {
  await Directory(directory).create(recursive: true);
  final tmp = File('$directory/$_fileName.tmp');
  await tmp.writeAsString(json, flush: true);
  await tmp.rename('$directory/$_fileName');
}
