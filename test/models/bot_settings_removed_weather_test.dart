import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/bot_settings.dart';

void main() {
  test('saved settings drop the removed !weather command', () {
    final s = BotSettings.fromJson({
      'commands': ['!ping', '!weather'],
    });
    expect(s.commands, {'!ping'});
    expect(botCommands, isNot(contains('!weather')));
  });
}
