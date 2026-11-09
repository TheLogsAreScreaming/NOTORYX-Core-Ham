import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/app_lock_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Auth implements DeviceAuthenticator {
  bool available = true;
  bool answer = true;
  int prompts = 0;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<bool> authenticate(String reason) async {
    prompts++;
    return answer;
  }
}

void main() {
  late _Auth auth;
  late DateTime now;

  Future<AppLockService> make([Map<String, Object> prefs = const {}]) async {
    SharedPreferences.setMockInitialValues(prefs);
    return AppLockService(
      await SharedPreferences.getInstance(),
      authenticator: auth,
      now: () => now,
    );
  }

  setUp(() {
    auth = _Auth();
    now = DateTime(2026);
  });

  test('off by default and never locked', () async {
    final lock = await make();
    expect(lock.enabled, isFalse);
    expect(lock.locked, isFalse);
  });

  test('can only be turned on after the owner is confirmed', () async {
    final lock = await make();
    auth.answer = false;
    expect(await lock.setEnabled(true, 'r'), isFalse);
    expect(lock.enabled, isFalse);
    auth.answer = true;
    expect(await lock.setEnabled(true, 'r'), isTrue);
    expect(lock.enabled, isTrue);
    expect(lock.locked, isFalse);
  });

  test('a cold start with the lock on begins locked', () async {
    final lock = await make({'app_lock_enabled': true});
    expect(lock.locked, isTrue);
    auth.answer = false;
    await lock.unlock('r');
    expect(lock.locked, isTrue);
    auth.answer = true;
    await lock.unlock('r');
    expect(lock.locked, isFalse);
  });

  test('locks again only after the grace period', () async {
    final lock = await make({'app_lock_enabled': true});
    await lock.unlock('r');
    lock.onBackground();
    now = now.add(const Duration(seconds: 59));
    lock.onForeground();
    expect(lock.locked, isFalse);
    lock.onBackground();
    now = now.add(AppLockService.grace);
    lock.onForeground();
    expect(lock.locked, isTrue);
  });

  test('a phone with no screen lock left is not trapped', () async {
    final lock = await make({'app_lock_enabled': true});
    auth.available = false;
    await lock.unlock('r');
    expect(lock.locked, isFalse);
    expect(auth.prompts, 0);
  });
}
