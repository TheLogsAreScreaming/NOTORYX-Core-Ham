import 'message_db.dart';

/// SQLite isn't available on web; the stores keep using SharedPreferences.
Future<MessageDb?> openMessageDb() async => null;

MessageDb? openInMemoryMessageDb() => null;
