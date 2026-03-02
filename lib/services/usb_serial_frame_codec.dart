import 'dart:typed_data';

const int usbSerialTxFrameStart = 0x3c;
const int usbSerialRxFrameStart = 0x3e;
const int usbSerialHeaderLength = 3;

Uint8List wrapUsbSerialTxFrame(Uint8List payload) {
  final packet = Uint8List(usbSerialHeaderLength + payload.length);
  packet[0] = usbSerialTxFrameStart;
  packet[1] = payload.length & 0xff;
  packet[2] = (payload.length >> 8) & 0xff;
  packet.setRange(usbSerialHeaderLength, packet.length, payload);
  return packet;
}

class UsbSerialDecodedPacket {
  const UsbSerialDecodedPacket({
    required this.frameStart,
    required this.payload,
  });

  final int frameStart;
  final Uint8List payload;

  bool get isRxFrame => frameStart == usbSerialRxFrameStart;
}

class UsbSerialFrameDecoder {
  final List<int> _rxBuffer = <int>[];

  List<UsbSerialDecodedPacket> ingest(Uint8List bytes) {
    if (bytes.isEmpty) {
      return const <UsbSerialDecodedPacket>[];
    }

    _rxBuffer.addAll(bytes);
    final packets = <UsbSerialDecodedPacket>[];

    while (true) {
      if (_rxBuffer.isEmpty) {
        return packets;
      }

      if (_rxBuffer.first != usbSerialRxFrameStart &&
          _rxBuffer.first != usbSerialTxFrameStart) {
        _rxBuffer.removeAt(0);
        continue;
      }

      if (_rxBuffer.length < usbSerialHeaderLength) {
        return packets;
      }

      final payloadLength = _rxBuffer[1] | (_rxBuffer[2] << 8);
      final packetLength = usbSerialHeaderLength + payloadLength;
      if (_rxBuffer.length < packetLength) {
        return packets;
      }

      final frameStart = _rxBuffer.first;
      final payload = Uint8List.fromList(
        _rxBuffer.sublist(usbSerialHeaderLength, packetLength),
      );
      _rxBuffer.removeRange(0, packetLength);
      packets.add(
        UsbSerialDecodedPacket(frameStart: frameStart, payload: payload),
      );
    }
  }
}
