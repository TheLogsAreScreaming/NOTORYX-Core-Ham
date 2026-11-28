import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/channel.dart';
import '../models/team_config.dart';

const _repeatFreqsKhz = {433000, 869000, 918000};

/// Writes [config] to the connected radio and joins any of its channels the
/// radio doesn't have. Returns the channels that didn't fit.
Future<List<String>> applyTeamConfig(
  MeshCoreConnector radio,
  TeamConfig config,
) async {
  final current = radio.currentCr;
  final repeat = radio.clientRepeat;
  await radio.sendFrame(
    buildSetRadioParamsFrame(
      config.freqKhz,
      config.bandwidthHz,
      config.spreadingFactor,
      current != null && current <= 4
          ? config.codingRate - 4
          : config.codingRate,
      // Client repeat only works on certain frequencies, so a move off them
      // turns it off rather than leaving it set where it can't work.
      clientRepeat: repeat == null
          ? null
          : repeat && _repeatFreqsKhz.contains(config.freqKhz),
    ),
  );
  await radio.refreshDeviceInfo();

  final skipped = <String>[];
  for (final name in config.channels) {
    if (radio.channels.any((c) => c.name == name)) continue;
    final used = radio.channels.map((c) => c.index).toSet();
    final slot = [
      for (var i = 0; i < radio.maxChannels; i++)
        if (!used.contains(i)) i,
    ].firstOrNull;
    if (slot == null) {
      skipped.add(name);
      continue;
    }
    await radio.setChannel(slot, name, Channel.derivePskFromHashtag(name));
  }
  return skipped;
}
