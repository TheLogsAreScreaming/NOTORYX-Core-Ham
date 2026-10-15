// End-to-end check of the flood corridor protocol against usrflo's MeshCore
// simulator running the corridor firmware. Skipped unless MCSIM=1.
//
// Simulator setup (macOS/Linux, needs Rust and clang):
//   git clone https://github.com/usrflo/mcsim && cd mcsim && rmdir MeshCore
//   git clone -b feature/flood-corridor https://github.com/usrflo/MeshCore
//   cargo build --release
//   ./target/release/mcsim run examples/topologies/corridor_demo_app.yaml
// Avoid --trace: it logs every timer tick and grows by gigabytes per hour.
//
// Then: MCSIM=1 flutter test test/integration/flood_corridor_sim_test.dart
//
// Topology: Alice (tcp 9300) reaches Bob (tcp 9301) only through the
// repeaters R_in_H then R_in_V; R_out_SW and R_out_N hear Alice directly.
// Verified against usrflo/MeshCore ab947662.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/flood_corridor.dart';
import 'mcsim_radio.dart';

void main() {
  final enabled = mcsimEnabled;
  late SimRadio alice;
  late SimRadio bob;

  setUpAll(() async {
    if (!enabled) return;
    alice = await SimRadio.connect(alicePort);
    bob = await SimRadio.connect(bobPort);
    for (final radio in [alice, bob]) {
      await radio.request(buildAppStartFrame(), {respCodeSelfInfo});
    }
    await alice.request(buildSetAdvertLatLonFrame(aliceAt.lat, aliceAt.lon), {
      respCodeOk,
    });
    await receivedChannelTexts(bob, const Duration(seconds: 1));
  });

  tearDownAll(() async {
    if (!enabled) return;
    await alice.close();
    await bob.close();
  });

  test('detection probe gets a corridor region reply', () async {
    final reply = await alice.request(buildGetCorridorRegionFrame(), {
      respCodeCorridorRegion,
      respCodeErr,
    });
    expect(reply[0], respCodeCorridorRegion);
    expect(parseCorridorRegionFrame(reply), isNotNull);
  }, skip: !enabled);

  test('corridor region round-trips and resets', () async {
    await alice.request(buildSetCorridorRegionFrame('#sim-test'), {respCodeOk});
    var reply = await alice.request(buildGetCorridorRegionFrame(), {
      respCodeCorridorRegion,
    });
    expect(parseCorridorRegionFrame(reply), 'sim-test');

    await alice.request(buildSetCorridorRegionFrame(''), {respCodeOk});
    reply = await alice.request(buildGetCorridorRegionFrame(), {
      respCodeCorridorRegion,
    });
    expect(parseCorridorRegionFrame(reply), '');
  }, skip: !enabled);

  test('proposes a corridor from Alice to Bob', () async {
    final reply = await alice.request(
      buildProposeCorridorFrame(bobAt.lat, bobAt.lon),
      {respCodeProposeCorridor, respCodeErr},
    );
    expect(reply[0], respCodeProposeCorridor);
    final proposal = parseCorridorProposalFrame(reply)!;
    expect(proposal.triples.length, greaterThanOrEqualTo(2));
    expect(proposal.triples.first.lat, closeTo(aliceAt.lat, 0.02));
    expect(proposal.triples.last.lat, closeTo(bobAt.lat, 0.02));
    expect(proposal.triples.last.lon, closeTo(bobAt.lon, 0.02));
  }, skip: !enabled);

  test(
    'a corridor along the path delivers to Bob',
    () async {
      final reply = await alice.request(
        buildProposeCorridorFrame(bobAt.lat, bobAt.lon),
        {respCodeProposeCorridor},
      );
      final corridor = parseCorridorProposalFrame(reply)!.triples;
      await alice.request(
        buildSendChannelTextMsgCorridorFrame(
          publicChannel,
          'corridor-hit',
          corridor,
        ),
        {respCodeOk},
      );
      final texts = await receivedChannelTexts(
        bob,
        const Duration(seconds: 20),
        until: 'corridor-hit',
      );
      expect(texts.any((t) => t.contains('corridor-hit')), isTrue);
    },
    timeout: const Timeout(Duration(seconds: 60)),
    skip: !enabled,
  );

  test(
    'a corridor that excludes the repeaters does not reach Bob',
    () async {
      // 1 km around Alice: R_in_H (~7 km away) is outside and must not forward.
      final corridor = [
        CorridorTriple(lat: aliceAt.lat, lon: aliceAt.lon, radiusCode: 0),
      ];
      await alice.request(
        buildSendChannelTextMsgCorridorFrame(
          publicChannel,
          'corridor-miss',
          corridor,
          flags: corridorFlagFailClosed,
        ),
        {respCodeOk},
      );
      final texts = await receivedChannelTexts(
        bob,
        const Duration(seconds: 20),
        until: 'corridor-miss',
      );
      expect(texts.any((t) => t.contains('corridor-miss')), isFalse);
    },
    timeout: const Timeout(Duration(seconds: 60)),
    skip: !enabled,
  );
}
