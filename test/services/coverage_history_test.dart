import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/services/coverage_capture_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final session = CoverageCaptureSession(id: 'saved', startedAt: DateTime(2026), endedAt: DateTime(2026, 1, 1, 1), observations: []);
  test('loads saved and interrupted sessions and retains corrupt data', () async {
    final interrupted = CoverageCaptureSession(id: 'interrupted', startedAt: DateTime(2026), observations: []);
    SharedPreferences.setMockInitialValues({
      'bastion_coverage_sessions_v1': [jsonEncode(session.toJson()), 'damaged'],
      'bastion_coverage_active_v1': jsonEncode(interrupted.toJson()),
    });
    final service = CoverageCaptureService();
    await service.loadHistory();
    expect(service.history.map((s) => s.id), ['interrupted', 'saved']);
    expect(service.recording, false);
    expect(service.loadWarning, isNotNull);
    await service.deleteSession('saved');
    expect(service.history.single.id, 'interrupted');
    expect((await SharedPreferences.getInstance()).getStringList('bastion_coverage_sessions_v1'), ['damaged']);
    await service.deleteSession('interrupted');
    expect(service.history, isEmpty);
    service.dispose();
  });
  test('session round trip retains timestamps and signal caveat', () {
    final parsed = CoverageCaptureSession.fromJson(session.toJson());
    expect(parsed.id, session.id);
    expect(parsed.endedAt, session.endedAt);
    expect(session.toJson()['signal_note'], contains('not per-node'));
  });
}
