// Shared helpers for the MeshCore simulator (mcsim) integration tests.
// See flood_corridor_sim_test.dart for simulator setup.

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/services/usb_serial_frame_codec.dart';

final bool mcsimEnabled = Platform.environment['MCSIM'] == '1';

const alicePort = 9300;
const bobPort = 9301;
const aliceAt = (lat: 47.6100, lon: -122.4000);
const bobAt = (lat: 47.7400, lon: -122.2500);
const publicChannel = 0;

class SimRadio {
  SimRadio._(this._socket) {
    _socket.listen((bytes) {
      for (final packet in _decoder.ingest(Uint8List.fromList(bytes))) {
        if (!packet.isRxFrame) continue;
        final code = packet.payload.isEmpty ? -1 : packet.payload[0];
        if (code == respCodeChannelMsgRecv ||
            code == respCodeChannelMsgRecvV3) {
          channelTexts.add(String.fromCharCodes(packet.payload));
        }
        _frames.add(packet.payload);
      }
    });
  }

  final Socket _socket;
  final _decoder = UsbSerialFrameDecoder();
  final _frames = StreamController<Uint8List>.broadcast();

  /// Every channel message seen on this connection. The simulator's own agent
  /// shares the UART and may fetch messages before we ask, so record them all.
  final List<String> channelTexts = [];

  static Future<SimRadio> connect(int port) async =>
      SimRadio._(await Socket.connect(InternetAddress.loopbackIPv4, port));

  Future<Uint8List> request(
    Uint8List frame,
    Set<int> replyCodes, {
    Duration timeout = const Duration(seconds: 5),
  }) {
    final reply = _frames.stream.firstWhere(
      (f) => f.isNotEmpty && replyCodes.contains(f[0]),
    );
    _socket.add(wrapUsbSerialTxFrame(frame));
    return reply.timeout(timeout);
  }

  Future<void> close() async {
    await _socket.close();
    await _frames.close();
  }
}

/// Polls [radio]'s message queue for up to [within] and returns every channel
/// text seen on the connection; stops early once one contains [until].
Future<List<String>> receivedChannelTexts(
  SimRadio radio,
  Duration within, {
  String? until,
}) async {
  final deadline = DateTime.now().add(within);
  while (DateTime.now().isBefore(deadline)) {
    if (until != null && radio.channelTexts.any((t) => t.contains(until))) {
      break;
    }
    await radio.request(buildSyncNextMessageFrame(), {
      respCodeChannelMsgRecv,
      respCodeChannelMsgRecvV3,
      respCodeContactMsgRecv,
      respCodeContactMsgRecvV3,
      respCodeNoMoreMessages,
    });
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
  return radio.channelTexts;
}
