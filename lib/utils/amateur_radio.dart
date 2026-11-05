/// FCC Part 97 rules that NOTORYX Core Ham shares with the NOTORYX Ham
/// firmware (`AMATEUR_RADIO` builds).
///
/// On air, every frame is marked payload version 2 and ends with the
/// transmitting station's call sign, zero padded to [stationIdBytes]. Content
/// is plain text: the firmware still pads it to 16-byte blocks and keeps the
/// 2-byte MAC, so the rest of the frame has the stock V1 layout.
library;

import 'dart:convert';
import 'dart:typed_data';

/// Bytes of station ID at the end of every amateur frame.
const int stationIdBytes = 8;

/// The ham firmware's MAX_GROUP_DATA_LENGTH: a 176-byte payload (184 less the
/// station ID) minus one cipher block and 3 header bytes.
const int amateurMaxGroupDataBytes = 184 - stationIdBytes - 16 - 3;

const int _verShift = 6;
const int _verMask = 0x03;
const int _payloadVer1 = 0x00;
const int _payloadVer2 = 0x01;

/// A frame the radio heard, split into the V1 packet the rest of the app
/// parses and the call sign of the station that transmitted it.
class AmateurFrame {
  const AmateurFrame(this.packet, this.station);

  /// The frame without its station ID, header marked V1 again.
  final Uint8List packet;

  /// Call sign of the transmitting station: the sender, or the repeater
  /// that relayed it.
  final String station;

  /// Splits [onAir] (LOG_RX_DATA bytes), or returns null for anything that
  /// isn't an amateur frame, such as Part 15 MeshCore traffic.
  static AmateurFrame? unwrap(Uint8List onAir) {
    if (onAir.length < 2 + stationIdBytes) return null;
    if ((onAir[0] >> _verShift) & _verMask != _payloadVer2) return null;

    final split = onAir.length - stationIdBytes;
    final packet = Uint8List.fromList(onAir.sublist(0, split));
    packet[0] =
        (packet[0] & ~(_verMask << _verShift)) | (_payloadVer1 << _verShift);

    final id = onAir.sublist(split);
    final end = id.indexOf(0);
    final station = ascii.decode(
      end < 0 ? id : id.sublist(0, end),
      allowInvalid: true,
    );
    return AmateurFrame(packet, station);
  }
}

final RegExp _usCallsign = RegExp(r'^(?:[KNW][A-Z]?|A[A-L])[0-9][A-Z]{1,3}$');

/// Whether [call] is a US amateur call sign: a K, N or W prefix (optionally
/// with a second letter) or AA-AL, one district digit, then one to three
/// letters. Case doesn't matter.
bool isUsCallsign(String call) => _usCallsign.hasMatch(call.toUpperCase());

/// The call sign that leads [nodeName] ("W1AW", "W1AW-7", "KD2ABC Hilltop"),
/// upper-cased, or null when the name doesn't start with one. The firmware
/// sends this as the station ID and won't transmit without it.
String? callsignOf(String nodeName) {
  final end = nodeName.indexOf(RegExp(r'[- ]'));
  final call = (end < 0 ? nodeName : nodeName.substring(0, end)).toUpperCase();
  return isUsCallsign(call) ? call : null;
}

/// Whether [mhz] is in a band the ham firmware allows: 70 cm (420-450 MHz)
/// or 33 cm (902-928 MHz).
bool isAmateurFrequencyMHz(double mhz) =>
    (mhz >= 420.0 && mhz <= 450.0) || (mhz >= 902.0 && mhz <= 928.0);
