/// Contract for secure MQTT credential persistence.
///
/// Implementations must use an OS-backed secure store, never preferences,
/// logs or a JSON configuration file.
abstract class MqttCredentialsStore {
  Future<void> save({required String username, required String password});

  Future<({String username, String password})?> read();

  Future<void> clear();
}
