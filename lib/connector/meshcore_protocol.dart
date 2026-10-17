import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/widgets.dart';

import '../models/access_control.dart';
import '../models/flood_corridor.dart';

// Buffer Reader - sequential binary data reader with pointer tracking
class BufferReader {
  int _pointer = 0;
  int _lastPointer = 0;
  final Uint8List _buffer;

  BufferReader(Uint8List data) : _buffer = Uint8List.fromList(data);

  int get remaining => _buffer.length - _pointer;

  int readByte() => readBytes(1)[0];

  Uint8List readBytes(int count) {
    _lastPointer = _pointer;
    if (_pointer + count > _buffer.length) {
      throw RangeError(
        'Attempted to read $count bytes at offset $_pointer, but only $remaining bytes remaining in buffer of length ${_buffer.length}',
      );
    }
    final data = _buffer.sublist(_pointer, _pointer + count);
    _pointer += count;
    return data;
  }

  void skipBytes(int count) {
    _lastPointer = _pointer;
    if (_pointer + count > _buffer.length) {
      throw RangeError(
        'Attempted to skip $count bytes at offset $_pointer, but only $remaining bytes remaining in buffer of length ${_buffer.length}',
      );
    }
    _pointer += count;
  }

  Uint8List readRemainingBytes() => readBytes(remaining);

  String readCStringGreedy(int maxLength) {
    _lastPointer = _pointer;
    final value = <int>[];
    final bytes = readBytes(maxLength);
    for (final byte in bytes) {
      if (byte == 0) break;
      value.add(byte);
    }
    try {
      return utf8.decode(Uint8List.fromList(value), allowMalformed: true);
    } catch (e) {
      return String.fromCharCodes(value); // Latin-1 fallback
    }
  }

  String readCString({int maxLength = -1}) {
    final backupPointer = _pointer;
    final value = <int>[];
    int counter = 0;
    final maxLen = maxLength >= 0 ? maxLength : remaining;
    while (counter < maxLen) {
      final byte = readByte();
      if (byte == 0) break;
      value.add(byte);
      counter++;
    }
    _lastPointer = backupPointer;
    try {
      return utf8.decode(Uint8List.fromList(value), allowMalformed: true);
    } catch (e) {
      return String.fromCharCodes(value); // Latin-1 fallback
    }
  }

  int readUInt8() => readBytes(1).buffer.asByteData().getUint8(0);
  int readInt8() => readBytes(1).buffer.asByteData().getInt8(0);
  int readUInt16LE() =>
      readBytes(2).buffer.asByteData().getUint16(0, Endian.little);
  int readUInt16BE() =>
      readBytes(2).buffer.asByteData().getUint16(0, Endian.big);
  int readUInt32LE() =>
      readBytes(4).buffer.asByteData().getUint32(0, Endian.little);
  int readUInt32BE() =>
      readBytes(4).buffer.asByteData().getUint32(0, Endian.big);
  int readInt16LE() =>
      readBytes(2).buffer.asByteData().getInt16(0, Endian.little);
  int readInt16BE() => readBytes(2).buffer.asByteData().getInt16(0, Endian.big);
  int readInt32LE() =>
      readBytes(4).buffer.asByteData().getInt32(0, Endian.little);

  int readInt24BE() {
    var value = (readByte() << 16) | (readByte() << 8) | readByte();
    if ((value & 0x800000) != 0) value -= 0x1000000;
    return value;
  }

  void resetPointer() => _pointer = 0;
  void rewind() => _pointer = _lastPointer;
}

// Buffer Writer - accumulating binary data builder
class BufferWriter {
  final BytesBuilder _builder = BytesBuilder();

  Uint8List toBytes() => _builder.toBytes();

  void writeByte(int byte) => _builder.addByte(byte);
  void writeBytes(Uint8List bytes) => _builder.add(bytes);

  void writeUInt16LE(int num) {
    final bytes = Uint8List(2)
      ..buffer.asByteData().setUint16(0, num, Endian.little);
    writeBytes(bytes);
  }

  void writeUInt32LE(int num) {
    final bytes = Uint8List(4)
      ..buffer.asByteData().setUint32(0, num, Endian.little);
    writeBytes(bytes);
  }

  void writeInt32LE(int num) {
    final bytes = Uint8List(4)
      ..buffer.asByteData().setInt32(0, num, Endian.little);
    writeBytes(bytes);
  }

  void writeString(String string) =>
      writeBytes(Uint8List.fromList(utf8.encode(string)));

  void writeCString(String string, int maxLength) {
    final bytes = Uint8List(maxLength);
    final encoded = utf8.encode(string);
    for (var i = 0; i < maxLength - 1 && i < encoded.length; i++) {
      bytes[i] = encoded[i];
    }
    writeBytes(bytes);
  }

  void writeHex(String hex) {
    writeBytes(hex2Uint8List(hex));
  }

  void writeBytesPadded(Uint8List bytes, int totalLength) {
    // Path data (64 bytes, zero-padded)
    final bytesPadded = Uint8List(totalLength);
    final len = bytes.length < totalLength ? bytes.length : totalLength;
    if (bytes.isNotEmpty && len > 0) {
      final copyLen = bytes.length < totalLength ? bytes.length : totalLength;
      for (int i = 0; i < copyLen; i++) {
        bytesPadded[i] = bytes[i];
      }
    }
    writeBytes(bytesPadded);
  }
}

Uint8List hex2Uint8List(String hex) {
  // Validate hex string length is even and not empty
  if (hex.isEmpty || hex.length % 2 != 0) {
    throw FormatException('Invalid hex string length: ${hex.length}');
  }
  List<int> result = [];
  for (int i = 0; i < hex.length ~/ 2; i++) {
    final hexByte = hex.substring(i * 2, i * 2 + 2);
    final byte = int.tryParse(hexByte, radix: 16);
    if (byte == null) {
      throw FormatException('Invalid hex characters at position $i: $hexByte');
    }
    result.add(byte);
  }
  return Uint8List.fromList(result);
}

// Command codes (to device)
const int cmdAppStart = 1;
const int cmdSendTxtMsg = 2;
const int cmdSendChannelTxtMsg = 3;
const int cmdGetContacts = 4;
const int cmdGetDeviceTime = 5;
const int cmdSetDeviceTime = 6;
const int cmdSendSelfAdvert = 7;
const int cmdSetAdvertName = 8;
const int cmdAddUpdateContact = 9;
const int cmdSyncNextMessage = 10;
const int cmdSetRadioParams = 11;
const int cmdSetRadioTxPower = 12;
const int cmdResetPath = 13;
const int cmdSetAdvertLatLon = 14;
const int cmdRemoveContact = 15;
const int cmdShareContact = 16;
const int cmdExportContact = 17;
const int cmdImportContact = 18;
const int cmdReboot = 19;
const int cmdGetBattAndStorage = 20;
const int cmdDeviceQuery = 22;
const int cmdSendLogin = 26;
const int cmdSendStatusReq = 27;
const int cmdGetContactByKey = 30;
const int cmdGetChannel = 31;
const int cmdSetChannel = 32;
const int cmdSendTracePath = 36;
const int cmdSetOtherParams = 38;
const int cmdSendTelemetryReq = 39;
const int cmdGetCustomVar = 40;
const int cmdSetCustomVar = 41;
const int cmdSendBinaryReq = 50;
const int cmdSetFloodScope = 54;
const int cmdSendControlData = 55;
const int cmdGetStats = 56;
const int cmdSendAnonReq = 57;
const int cmdSetAutoAddConfig = 58;
const int cmdGetAutoAddConfig = 59;
const int cmdSetPathHashMode = 61;
const int cmdRunCliCommand = 66; // v14+: run a CLI command on the companion

// Flood Corridor commands (usrflo/MeshCore feature/flood-corridor only;
// stock firmware replies RESP_CODE_ERR / ERR_CODE_UNSUPPORTED_CMD).
const int cmdSendChannelTxtMsgCorridor = 53;
const int cmdProposeCorridor = 67;
const int cmdSetCorridorRegion = 68;
const int cmdGetCorridorRegion = 69;

// Text message types
const int txtTypePlain = 0;
const int txtTypeCliData = 1;
const int txtTypeSigned = 2;

/// A command for another companion radio's CLI. It runs only if that radio
/// gave us [contactFlagRemoteCli]; the reply comes back as [txtTypeCliData].
const int txtTypeCliCommand = 3;

// Repeater request types (for server requests)
const int reqTypeGetStatus = 0x01;
const int reqTypeKeepAlive = 0x02;
const int reqTypeGetTelemetry = 0x03;
const int reqTypeGetAccessList = 0x05;
const int reqTypeGetNeighbors = 0x06;

Uint8List buildTelemetryBinaryPayload() {
  // Room servers/repeaters read byte 1 as an inverse telemetry permission mask.
  // Zero means "request every telemetry field allowed for this contact".
  return Uint8List.fromList([reqTypeGetTelemetry, 0x00, 0x00, 0x00, 0x00]);
}

const int anonReqTypeRegions = 0x01;

// Control data sub-types used by MeshCore discovery packets.
const int controlSubtypeDiscoverReq = 0x08;
const int controlSubtypeDiscoverResp = 0x09;

// Repeater response codes
const int respServerLoginOk = 0;

// Response codes (from device)
const int respCodeOk = 0;
const int respCodeErr = 1;
const int respCodeContactsStart = 2;
const int respCodeContact = 3;
const int respCodeEndOfContacts = 4;
const int respCodeSelfInfo = 5;
const int respCodeSent = 6;
const int respCodeContactMsgRecv = 7;
const int respCodeChannelMsgRecv = 8;
const int respCodeCurrTime = 9;
const int respCodeNoMoreMessages = 10;
const int respCodeExportContact = 11;
const int respCodeBattAndStorage = 12;
const int respCodeDeviceInfo = 13;
const int respCodeContactMsgRecvV3 = 16;
const int respCodeChannelMsgRecvV3 = 17;
const int respCodeChannelInfo = 18;
const int respCodeCustomVars = 21;
const int respCodeAutoAddConfig = 25;
const int respCodeStats = 24;
const int respCodeCliReply = 29; // v14+: reply to cmdRunCliCommand
const int respCodeProposeCorridor = 30;
const int respCodeCorridorRegion = 31;

const int errCodeUnsupportedCmd = 1;

const int statsTypeCore = 0;
const int statsTypeRadio = 1;
const int statsTypePackets = 2;

// Push codes (async from device)
const int pushCodeAdvert = 0x80;
const int pushCodePathUpdated = 0x81;
const int pushCodeSendConfirmed = 0x82;
const int pushCodeMsgWaiting = 0x83;
const int pushCodeLoginSuccess = 0x85;
const int pushCodeLoginFail = 0x86;
const int pushCodeStatusResponse = 0x87;
const int pushCodeLogRxData = 0x88;
const int pushCodeTraceData = 0x89;
const int pushCodeNewAdvert = 0x8A;
const int pushCodeTelemetryResponse = 0x8B;
const int pushCodeBinaryResponse = 0x8C;
const int pushCodeControlData = 0x8E;

// Contact/advertisement types
const int advTypeChat = 1;
const int advTypeRepeater = 2;
const int advTypeRoom = 3;
const int advTypeSensor = 4;

const int teleModeDeny = 0;
const int teleModeAllowFlags = 1; // use contact.flags
const int teleModeAllowAll = 2;

// Payload Types
const int payloadTypeREQ =
    0x00; // request (prefixed with dest/src hashes, MAC) (enc data: timestamp, blob)
const int payloadTypeRESPONSE =
    0x01; // response to REQ or ANON_REQ (prefixed with dest/src hashes, MAC) (enc data: timestamp, blob)
const int payloadTypeTXTMSG =
    0x02; // a plain text message (prefixed with dest/src hashes, MAC) (enc data: timestamp, text)
const int payloadTypeACK = 0x03; // a simple ack
const int payloadTypeADVERT = 0x04; // a node advertising its Identity
const int payloadTypeGRPTXT =
    0x05; // an (unverified) group text message (prefixed with channel hash, MAC) (enc data: timestamp, "name: msg")
const int payloadTypeGRPDATA =
    0x06; // an (unverified) group datagram (prefixed with channel hash, MAC) (enc data: timestamp, blob)
const int payloadTypeANONREQ =
    0x07; // generic request (prefixed with dest_hash, ephemeral pub_key, MAC) (enc data: ...)
const int payloadTypePATH =
    0x08; // returned path (prefixed with dest/src hashes, MAC) (enc data: path, extra)
const int payloadTypeTRACE = 0x09; // trace a path, collecting SNI for each hop
const int payloadTypeMULTIPART = 0x0A; // packet is one of a set of packets
const int payloadTypeCONTROL = 0x0B; // a control/discovery packet
//...
const int payloadTypeRawCustom =
    0x0F; // custom packet as raw bytes, for applications with custom encryption, payloads, etc

//auto-add flags
const int autoAddOverwriteOldestFlag =
    1 << 0; // 0x01 - overwrite oldest non-favourite when full
const int autoAddChatFlag =
    1 << 1; // 0x02 - auto-add Chat (Companion) (ADV_TYPE_CHAT)
const int autoAddRepeaterFlag =
    1 << 2; // 0x04 - auto-add Repeater (ADV_TYPE_REPEATER)
const int autoAddRoomServerFlag =
    1 << 3; // 0x08 - auto-add Room Server (ADV_TYPE_ROOM)
const int autoAddSensorFlag =
    1 << 4; // 0x10 - auto-add Sensor (ADV_TYPE_SENSOR)

// Sizes
const int pubKeySize = 32;
const int signatureSize = 64;
const int maxPathSize = 64;
const int pathHashSize = 1;
const int maxNameSize = 32;
const int maxFrameSize = 172;
const int appProtocolVersion = 4;
// Matches firmware MAX_TEXT_LEN (10 * CIPHER_BLOCK_SIZE).
const int maxTextPayloadBytes = 160;
const int _sendTextMsgOverheadBytes =
    1 + 1 + 1 + 4 + 6 + 1 + 2; // +2 safety margin
const int _sendChannelTextMsgOverheadBytes =
    1 + 1 + 1 + 4 + 1 + 2; // +2 safety margin

int maxContactMessageBytes() {
  final byFrame = maxFrameSize - _sendTextMsgOverheadBytes;
  return _minPositive(byFrame, maxTextPayloadBytes);
}

int maxChannelMessageBytes(String? senderName) {
  final nameLength = _senderNameBytes(senderName);
  final prefixBytes = nameLength + 2; // "<name>: "
  final byPayload = maxTextPayloadBytes - prefixBytes;
  final byFrame = maxFrameSize - _sendChannelTextMsgOverheadBytes;
  return _minPositive(byPayload, byFrame);
}

// Corridor channel sends carry 4 bytes per circle. The firmware truncates text
// that would push corridor + payload past MAX_PACKET_PAYLOAD (the budget
// corridor-unaware repeaters enforce), which costs the same 4 bytes per circle.
const int _sendChannelTextMsgCorridorOverheadBytes =
    1 + 1 + 1 + 4 + 1 + 1 + 2; // count + flags, +2 safety margin

int maxCorridorChannelMessageBytes(String? senderName, int circleCount) {
  final prefixBytes = _senderNameBytes(senderName) + 2; // "<name>: "
  final corridorBytes = circleCount * corridorTripleBytes;
  final byPayload = maxTextPayloadBytes - prefixBytes - corridorBytes;
  final byFrame =
      maxFrameSize - _sendChannelTextMsgCorridorOverheadBytes - corridorBytes;
  return _minPositive(byPayload, byFrame);
}

int _senderNameBytes(String? senderName) {
  if (senderName == null || senderName.isEmpty) return maxNameSize - 1;
  final bytes = utf8.encode(senderName);
  final maxBytes = maxNameSize - 1;
  return bytes.length > maxBytes ? maxBytes : bytes.length;
}

int _minPositive(int a, int b) {
  final minValue = a < b ? a : b;
  return minValue < 0 ? 0 : minValue;
}

// Contact frame offsets
const int contactPubKeyOffset = 1;
const int contactTypeOffset = 33;
const int contactFlagsOffset = 34;
const int contactFlagFavorite = 0x01;
const int contactFlagTeleBase = 0x02; // 'base' permission includes battery
const int contactFlagTeleLoc = 0x04;
const int contactFlagTeleEnv = 0x08; //access environment sensors

/// Lets this contact run commands on our radio (MeshCore v1.18+ companion).
const int contactFlagRemoteCli = 0x10;
const int contactPathLenOffset = 35;
const int contactPathOffset = 36;
const int contactNameOffset = 100;
const int contactTimestampOffset = 132;
const int contactLatOffset = 136;
const int contactLonOffset = 140;
const int contactLastModOffset = 144;
const int contactFrameSize = 148;

// Message frame offsets
const int msgPubKeyOffset = 1;
const int msgTimestampOffset = 33;
const int msgFlagsOffset = 37;
const int msgTextOffset = 38;

class ParsedContactText {
  final Uint8List senderPrefix;
  final String text;
  const ParsedContactText({required this.senderPrefix, required this.text});
}

ParsedContactText? parseContactMessageText(Uint8List frame) {
  if (frame.isEmpty) return null;

  final message = BufferReader(frame);
  try {
    final code = message.readByte();
    if (code != respCodeContactMsgRecv && code != respCodeContactMsgRecvV3) {
      return null;
    }

    // Companion radio layout:
    // [code][snr?][res?][res?][prefix x6][path_len][txt_type][timestamp x4][extra?][text...]
    if (code == respCodeContactMsgRecvV3) {
      // Skip SNR and reserved bytes in v3 layout
      message.skipBytes(3);
    }
    final senderPrefix = message.readBytes(6); // public key
    message.skipBytes(1); // path length
    final textType = message.readByte();
    message.skipBytes(4); // timestamp (4 bytes)

    final shiftedType = textType >> 2;
    final isSigned = shiftedType == txtTypeSigned || textType == txtTypeSigned;
    if (isSigned) {
      // Signed messages have a 4-byte signature after the timestamp, before the text
      message.skipBytes(4);
    }
    final text = message.readCString();
    if (text.isEmpty) return null;

    return ParsedContactText(senderPrefix: senderPrefix, text: text);
  } catch (e) {
    debugPrint('Error parsing contact message text: $e');
    return null;
  }
}

// Helper to read uint32 little-endian
int readUint32LE(Uint8List data, int offset) {
  return data[offset] |
      (data[offset + 1] << 8) |
      (data[offset + 2] << 16) |
      (data[offset + 3] << 24);
}

// Helper to read uint16 little-endian
int readUint16LE(Uint8List data, int offset) {
  return data[offset] | (data[offset + 1] << 8);
}

// Helper to read int32 little-endian
int readInt32LE(Uint8List data, int offset) {
  int val = readUint32LE(data, offset);
  if (val >= 0x80000000) val -= 0x100000000;
  return val;
}

// Helper to convert uint32 to hex string
String ackHashToHex(int ackHash) {
  return ackHash.toRadixString(16).padLeft(8, '0');
}

// Helper to convert public key to hex string
String pubKeyToHex(Uint8List pubKey) {
  return pubKey.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}

// Helper to convert hex string to public key
Uint8List hexToPubKey(String hex) {
  if (hex.length != pubKeySize * 2) {
    throw FormatException(
      'Public key hex must be ${pubKeySize * 2} chars, got ${hex.length}',
    );
  }
  final result = Uint8List(pubKeySize);
  for (int i = 0; i < pubKeySize; i++) {
    result[i] = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
  }
  return result;
}

// Build CMD_GET_CONTACTS frame
Uint8List buildGetContactsFrame({int? since}) {
  final writer = BufferWriter();
  writer.writeByte(cmdGetContacts);
  if (since != null) {
    writer.writeUInt32LE(since);
  }
  return writer.toBytes();
}

// Build CMD_SEND_LOGIN frame
// Format: [cmd][pub_key x32][password...]\0
Uint8List buildSendLoginFrame(Uint8List recipientPubKey, String password) {
  final writer = BufferWriter();
  writer.writeByte(cmdSendLogin);
  writer.writeBytes(recipientPubKey);
  writer.writeString(password);
  writer.writeByte(0);
  return writer.toBytes();
}

// Build CMD_SEND_STATUS_REQ frame
// Format: [cmd][pub_key x32]
Uint8List buildSendStatusRequestFrame(Uint8List recipientPubKey) {
  final writer = BufferWriter();
  writer.writeByte(cmdSendStatusReq);
  writer.writeBytes(recipientPubKey);
  return writer.toBytes();
}

// Build CMD_SEND_TXT_MSG frame (companion_radio format)
// Format: [cmd][txt_type][attempt][timestamp x4][pub_key_prefix x6][text...]\0
Uint8List buildSendTextMsgFrame(
  Uint8List recipientPubKey,
  String text, {
  int attempt = 0,
  int? timestampSeconds,
}) {
  final timestamp =
      timestampSeconds ?? (DateTime.now().millisecondsSinceEpoch ~/ 1000);
  final writer = BufferWriter();
  writer.writeByte(cmdSendTxtMsg);
  writer.writeByte(txtTypePlain);
  writer.writeByte(attempt.clamp(0, 255));
  writer.writeUInt32LE(timestamp);
  writer.writeBytes(recipientPubKey.sublist(0, 6));
  writer.writeString(text);
  writer.writeByte(0);
  return writer.toBytes();
}

// Build CMD_SEND_CHANNEL_TXT_MSG frame
// Format: [cmd][txt_type][channel_idx][timestamp x4][text...]
Uint8List buildSendChannelTextMsgFrame(int channelIndex, String text) {
  final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final writer = BufferWriter();
  writer.writeByte(cmdSendChannelTxtMsg);
  writer.writeByte(txtTypePlain);
  writer.writeByte(channelIndex);
  writer.writeUInt32LE(timestamp);
  writer.writeString(text);
  writer.writeByte(0);
  return writer.toBytes();
}

// Build CMD_REMOVE_CONTACT frame
Uint8List buildRemoveContactFrame(Uint8List pubKey) {
  final writer = BufferWriter();
  writer.writeByte(cmdRemoveContact);
  writer.writeBytes(pubKey);
  return writer.toBytes();
}

// Build CMD_APP_START frame
// Format: [cmd][app_ver][reserved x6][app_name...]
Uint8List buildAppStartFrame({
  String appName = 'MeshCoreOpen',
  int appVersion = 1,
}) {
  final writer = BufferWriter();
  writer.writeByte(cmdAppStart);
  writer.writeByte(appVersion);
  writer.writeBytes(Uint8List(6)); // reserved bytes
  writer.writeString(appName);
  writer.writeByte(0);
  return writer.toBytes();
}

// Build CMD_DEVICE_QUERY frame
Uint8List buildDeviceQueryFrame({int appVersion = appProtocolVersion}) {
  return Uint8List.fromList([cmdDeviceQuery, appVersion]);
}

// Build CMD_GET_DEVICE_TIME frame
Uint8List buildGetDeviceTimeFrame() {
  return Uint8List.fromList([cmdGetDeviceTime]);
}

// Build CMD_GET_BATT_AND_STORAGE frame
Uint8List buildGetBattAndStorageFrame() {
  return Uint8List.fromList([cmdGetBattAndStorage]);
}

/// Companion radio stats: [56][statsType] where statsType is statsTypeCore/Radio/Packets.
Uint8List buildGetStatsFrame(int statsType) {
  return Uint8List.fromList([cmdGetStats, statsType & 0xFF]);
}

/// Path hash width on air: [61][0][mode], mode 0..3 → (mode+1) bytes per hop hash.
Uint8List buildSetPathHashModeFrame(int mode) {
  final m = mode.clamp(0, 3).toInt();
  return Uint8List.fromList([cmdSetPathHashMode, 0, m]);
}

// Build CMD_SET_DEVICE_TIME frame
Uint8List buildSetDeviceTimeFrame(int timestamp) {
  final writer = BufferWriter();
  writer.writeByte(cmdSetDeviceTime);
  writer.writeUInt32LE(timestamp);
  return writer.toBytes();
}

// Build CMD_SEND_SELF_ADVERT frame
// Format: [cmd][flood_flag]
Uint8List buildSendSelfAdvertFrame({bool flood = false}) {
  return Uint8List.fromList([cmdSendSelfAdvert, flood ? 1 : 0]);
}

// Build CMD_SET_ADVERT_NAME frame
// Format: [cmd][name...]
Uint8List buildSetAdvertNameFrame(String name) {
  final nameBytes = utf8.encode(name);
  final nameLen = nameBytes.length < maxNameSize
      ? nameBytes.length
      : maxNameSize - 1;
  final writer = BufferWriter();
  writer.writeByte(cmdSetAdvertName);
  writer.writeBytes(Uint8List.fromList(nameBytes.sublist(0, nameLen)));
  return writer.toBytes();
}

// Build CMD_SET_ADVERT_LATLON frame
// Format: [cmd][lat x4][lon x4]
Uint8List buildSetAdvertLatLonFrame(double lat, double lon) {
  final writer = BufferWriter();
  writer.writeByte(cmdSetAdvertLatLon);
  writer.writeInt32LE((lat * 1000000).round());
  writer.writeInt32LE((lon * 1000000).round());
  return writer.toBytes();
}

Uint8List buildSetCustomVarFrame(String value) {
  final writer = BufferWriter();
  writer.writeByte(cmdSetCustomVar);
  writer.writeString(value);
  writer.writeByte(0);
  return writer.toBytes();
}

// Build CMD_REBOOT frame
// Format: [cmd]["reboot"]
Uint8List buildRebootFrame() {
  return Uint8List.fromList([cmdReboot, ...utf8.encode('reboot')]);
}

// Build CMD_SYNC_NEXT_MESSAGE frame
Uint8List buildSyncNextMessageFrame() {
  return Uint8List.fromList([cmdSyncNextMessage]);
}

// Build CMD_GET_CHANNEL frame
Uint8List buildGetChannelFrame(int channelIndex) {
  return Uint8List.fromList([cmdGetChannel, channelIndex]);
}

// Build CMD_SET_CHANNEL frame
// Format: [cmd][idx][name x32][psk x16]
Uint8List buildSetChannelFrame(int channelIndex, String name, Uint8List psk) {
  final writer = BufferWriter();
  writer.writeByte(cmdSetChannel);
  writer.writeByte(channelIndex);
  writer.writeCString(name, 32);
  // Write PSK (16 bytes, zero-padded)
  final pskPadded = Uint8List(16);
  for (int i = 0; i < 16 && i < psk.length; i++) {
    pskPadded[i] = psk[i];
  }
  writer.writeBytes(pskPadded);
  return writer.toBytes();
}

// Build CMD_SET_RADIO_PARAMS frame
// Format: [cmd][freq x4][bw x4][sf][cr] (pre-v9)
//         [cmd][freq x4][bw x4][sf][cr][repeat] (firmware v9+)
// freq: frequency in Hz (300000-2500000)
// bw: bandwidth in Hz (7000-500000)
// sf: spreading factor (5-12)
// cr: coding rate (5-8)
// clientRepeat: enable off-grid packet repeat (firmware v9+, omit for older)
Uint8List buildSetRadioParamsFrame(
  int freqHz,
  int bwHz,
  int sf,
  int cr, {
  bool? clientRepeat,
}) {
  final writer = BufferWriter();
  writer.writeByte(cmdSetRadioParams);
  writer.writeUInt32LE(freqHz);
  writer.writeUInt32LE(bwHz);
  writer.writeByte(sf);
  writer.writeByte(cr);
  if (clientRepeat != null) {
    writer.writeByte(clientRepeat ? 1 : 0);
  }
  return writer.toBytes();
}

// Build CMD_SET_RADIO_TX_POWER frame
// Format: [cmd][power_dbm]
Uint8List buildSetRadioTxPowerFrame(int powerDbm) {
  return Uint8List.fromList([cmdSetRadioTxPower, powerDbm]);
}

// Build CMD_RESET_PATH frame
// Format: [cmd][pub_key x32]
Uint8List buildResetPathFrame(Uint8List pubKey) {
  final writer = BufferWriter();
  writer.writeByte(cmdResetPath);
  writer.writeBytes(pubKey);
  return writer.toBytes();
}

// Build CMD_ADD_UPDATE_CONTACT frame to set custom path
// Format: [cmd][pub_key x32][type][flags][path_len][path x64][name x32][Lat? x4, Lon? x4][timestamp? x4]
Uint8List buildUpdateContactPathFrame(
  Uint8List pubKey,
  Uint8List path,
  int pathLen, {
  int type = 1, // ADV_TYPE_CHAT
  int flags = 0,
  String name = '',
  double? lat,
  double? lon,
  DateTime? lastModified,
}) {
  final writer = BufferWriter();
  writer.writeByte(cmdAddUpdateContact);
  writer.writeBytes(pubKey);
  writer.writeByte(type);
  writer.writeByte(flags);
  writer.writeByte(pathLen);

  writer.writeBytesPadded(path, maxPathSize);

  // Name (32 bytes, null-padded)
  writer.writeCString(name, maxNameSize);

  // Timestamp
  final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  writer.writeUInt32LE(timestamp);

  // Optional [Lat x4, Lon x4][timestamp x4] tail per the doc comment above.
  // Emit 8 bytes of position (zero-filled when only lastModified is provided)
  // followed by an optional 4-byte timestamp. Earlier code emitted the
  // position block twice, which corrupted the tail and caused the firmware
  // to parse the second lat as the timestamp. See #427.
  final hasLocation = lat != null && lon != null;
  if (hasLocation || lastModified != null) {
    writer.writeInt32LE(hasLocation ? (lat * 1e6).round() : 0);
    writer.writeInt32LE(hasLocation ? (lon * 1e6).round() : 0);
    if (lastModified != null) {
      final lastModifiedTimestamp = lastModified.millisecondsSinceEpoch ~/ 1000;
      writer.writeUInt32LE(lastModifiedTimestamp);
    }
  }

  return writer.toBytes();
}

// Build CMD_GET_CONTACT_BY_KEY frame
// Format: [cmd][pub_key x32]
Uint8List buildGetContactByKeyFrame(Uint8List pubKey) {
  final writer = BufferWriter();
  writer.writeByte(cmdGetContactByKey);
  writer.writeBytes(pubKey);
  return writer.toBytes();
}

//Build CMD_GET_CUSTOM_VARS frame
Uint8List buildGetCustomVarsFrame() {
  return Uint8List.fromList([cmdGetCustomVar]);
}

Uint8List buildGetAutoAddFlagsFrame() {
  return Uint8List.fromList([cmdGetAutoAddConfig]);
}

// Calculate LoRa airtime for a packet
// Based on Semtech SX127x datasheet formula
// Returns airtime in milliseconds
int calculateLoRaAirtime({
  required int payloadBytes,
  required int spreadingFactor,
  required int bandwidthHz,
  required int codingRate,
  int preambleSymbols = 8,
  bool lowDataRateOptimize = false,
  bool explicitHeader = true,
}) {
  // Symbol duration (Ts) in milliseconds
  final symbolDuration = (1 << spreadingFactor) / (bandwidthHz / 1000.0);

  // Preamble time
  final preambleTime = (preambleSymbols + 4.25) * symbolDuration;

  // Payload symbol count
  final headerBytes = explicitHeader ? 0 : 20;
  final crc = 1; // CRC enabled
  final de = lowDataRateOptimize ? 1 : 0;

  final numerator =
      8 * payloadBytes - 4 * spreadingFactor + 28 + 16 * crc - headerBytes;
  final denominator = 4 * (spreadingFactor - 2 * de);
  var payloadSymbols =
      8 + ((numerator / denominator).ceil()) * (codingRate + 4);

  if (payloadSymbols < 0) {
    payloadSymbols = 8;
  }

  final payloadTime = payloadSymbols * symbolDuration;

  return (preambleTime + payloadTime).ceil();
}

// Calculate timeout for a message based on radio settings
// Returns timeout in milliseconds
int calculateMessageTimeout({
  required int freqHz,
  required int bwHz,
  required int sf,
  required int cr,
  required int pathLength,
  int messageBytes = 100, // Average message size
}) {
  // Calculate airtime for one packet
  final airtime = calculateLoRaAirtime(
    payloadBytes: messageBytes,
    spreadingFactor: sf,
    bandwidthHz: bwHz,
    codingRate: cr,
    lowDataRateOptimize: sf >= 11,
  );

  if (pathLength < 0) {
    // Flood mode: Base delay + 16× airtime
    return 500 + (16 * airtime);
  } else {
    // Direct path: Base delay + ((airtime×6 + 250ms)×(hops+1))
    return 500 + ((airtime * 6 + 250) * (pathLength + 1));
  }
}

// Build CLI command text message frame (companion_radio format)
// Format: [cmd][txt_type][attempt][timestamp x4][pub_key_prefix x6][text...]\0
Uint8List buildSendCliCommandFrame(
  Uint8List repeaterPubKey,
  String command, {
  int attempt = 0,
  int? timestampSeconds,
  int txtType = txtTypeCliData,
}) {
  final timestamp =
      timestampSeconds ?? (DateTime.now().millisecondsSinceEpoch ~/ 1000);
  final writer = BufferWriter();
  writer.writeByte(cmdSendTxtMsg);
  writer.writeByte(txtType);
  writer.writeByte(attempt.clamp(0, 255));
  writer.writeUInt32LE(timestamp);
  writer.writeBytes(repeaterPubKey.sublist(0, 6));
  writer.writeString(command);
  writer.writeByte(0);
  return writer.toBytes();
}

// Build a telemetry request frame
// Format: [cmd][pub_key x32][payload]
Uint8List buildSendBinaryReq(Uint8List repeaterPubKey, {Uint8List? payload}) {
  final writer = BufferWriter();
  writer.writeByte(cmdSendBinaryReq);
  writer.writeBytes(repeaterPubKey);
  if (payload != null && payload.isNotEmpty) {
    writer.writeBytes(payload);
  }
  return writer.toBytes();
}

/// Most access-list entries that reach the app in one reply. The companion
/// forwards the reply padded to the 16-byte cipher block in a frame of at
/// most 176 bytes, so tag plus data must fit 160 bytes: 22 entries of 7.
/// v1.18 repeaters send up to 25, so a list of 23 or more never arrives on
/// stock firmware. A reply with 22 entries may mean the list continues.
const int maxAccessListEntriesPerReply = 22;

/// GET_ACCESS_LIST query flag for a paged reply (newer firmware only).
const int accessListPaged = 0x01;

/// Payload for REQ_TYPE_GET_ACCESS_LIST (admin only); [nonce] keeps repeated
/// requests from being deduplicated. Without [start] this is the plain v1.18
/// request (bytes 1-2 zero). With [start] it asks for a paged reply from that
/// entry, which firmware without paging ignores (no reply).
Uint8List buildGetAccessListPayload(Uint8List nonce, {int? start}) {
  return Uint8List.fromList([
    reqTypeGetAccessList,
    start == null ? 0x00 : accessListPaged,
    start ?? 0x00,
    0x00,
    ...nonce,
  ]);
}

/// One page of a paged access-list reply.
class AccessListPage {
  /// Index of the first entry in this page.
  final int start;

  /// Number of entries the node lists in total.
  final int total;
  final List<AclEntry> entries;

  const AccessListPage({
    required this.start,
    required this.total,
    required this.entries,
  });
}

/// Parses a paged access-list reply: start index, total count, then entries.
AccessListPage parsePagedAccessListResponse(Uint8List data) {
  if (data.length < 2) {
    return const AccessListPage(start: 0, total: 0, entries: []);
  }
  return AccessListPage(
    start: data[0],
    total: data[1],
    entries: parseAccessListResponse(Uint8List.sublistView(data, 2)),
  );
}

/// Parses an access-list reply (the data after the response tag): 6-byte
/// key prefix plus one permission byte per entry. Trailing padding and a
/// partial entry are ignored.
List<AclEntry> parseAccessListResponse(Uint8List data) {
  const entrySize = AclEntry.keyPrefixLength + 1;
  final entries = <AclEntry>[];
  for (var ofs = 0; ofs + entrySize <= data.length; ofs += entrySize) {
    // Nodes never list an entry without permissions, so a zero permission
    // byte is the cipher padding the companion forwards after the entries.
    if (data[ofs + AclEntry.keyPrefixLength] == 0) continue;
    entries.add(
      AclEntry(
        keyPrefix: Uint8List.fromList(
          data.sublist(ofs, ofs + AclEntry.keyPrefixLength),
        ),
        permissions: data[ofs + AclEntry.keyPrefixLength],
      ),
    );
  }
  return entries;
}

/// CLI command that gives [publicKey] the [role] on a repeater or room
/// server. [AclRole.guest] removes the entry, which also works with a key
/// prefix. Any other role needs the full 32-byte key on v1.18 firmware;
/// newer firmware also accepts a prefix of at least 6 bytes for an existing
/// entry.
String buildSetPermCommand(Uint8List publicKey, AclRole role) =>
    'setperm ${pubKeyToHex(publicKey)} ${role.value}';

/// Firmware version code from which the companion has a text CLI
/// ([cmdRunCliCommand]).
const int minFirmwareVerCodeForCompanionCli = 14;

/// Runs [command] on the connected companion's CLI; it answers with
/// [respCodeCliReply] followed by the reply text.
Uint8List buildRunCliCommandFrame(String command) {
  return Uint8List.fromList([cmdRunCliCommand, ...utf8.encode(command)]);
}

/// The value part of a CLI "get" reply ("> value" -> "value").
String cliReplyValue(String reply) {
  final text = reply.trim();
  return text.startsWith('>') ? text.substring(1).trim() : text;
}

/// Whether a CLI reply says the command doesn't exist on this firmware or
/// board (for example the wifi.* commands on boards without WiFi).
bool isUnknownCliCommandReply(String reply) =>
    reply.trim().toLowerCase().endsWith('unknown command');

Uint8List buildSendControlDataFrame(Uint8List payload) {
  final writer = BufferWriter();
  writer.writeByte(cmdSendControlData);
  writer.writeBytes(payload);
  return writer.toBytes();
}

Uint8List buildDiscoveryRequestPayload(
  int tag, {
  bool prefixOnly = false,
  int typeMask = 1 << advTypeRepeater,
}) {
  final writer = BufferWriter();
  // The high bit must be set for CMD_SEND_CONTROL_DATA; DISCOVER_REQ uses
  // subtype 0x8, with the low bit selecting short/full public keys in replies.
  writer.writeByte(
    (controlSubtypeDiscoverReq << 4) | (prefixOnly ? 0x01 : 0x00),
  );
  writer.writeByte(typeMask);
  writer.writeUInt32LE(tag);
  writer.writeUInt32LE(0); // since=0 asks nearby nodes for any recent advert.
  return writer.toBytes();
}

Uint8List _reversePathByHop(Uint8List path, int pathHashWidth) {
  if (path.isEmpty) return Uint8List(0);
  final width = pathHashWidth.clamp(1, 4).toInt();
  if (path.length % width != 0) {
    return Uint8List.fromList(path.reversed.toList());
  }

  final reversed = Uint8List(path.length);
  final hops = path.length ~/ width;
  for (var i = 0; i < hops; i++) {
    final from = (hops - 1 - i) * width;
    reversed.setRange(i * width, (i + 1) * width, path, from);
  }
  return reversed;
}

// Build CMD_SEND_ANON_REQ frame.
// Payload format for regions: [anon_req_type][reply_path_len][reply_path...].
Uint8List buildSendAnonReqFrame(
  Uint8List repeaterPubKey, {
  required int requestType,
  Uint8List? replyPath,
  int replyHopCount = 0,
  int pathHashWidth = pathHashSize,
}) {
  final width = pathHashWidth.clamp(1, 4).toInt();
  final path = replyPath ?? Uint8List(0);
  final encodedPathLen = ((width - 1) << 6) | (replyHopCount & 0x3F);
  final writer = BufferWriter();
  writer.writeByte(cmdSendAnonReq);
  writer.writeBytes(repeaterPubKey);
  writer.writeByte(requestType);
  writer.writeByte(encodedPathLen);
  writer.writeBytes(_reversePathByHop(path, width));
  return writer.toBytes();
}

//Build a trace request frame
//[cmd][tag x4][auth x4][flag][payload]
Uint8List buildTraceReq(int tag, int auth, int flag, {Uint8List? payload}) {
  final writer = BufferWriter();
  writer.writeByte(cmdSendTracePath);
  writer.writeUInt32LE(tag);
  writer.writeUInt32LE(auth);
  writer.writeByte(flag);
  if (payload != null && payload.isNotEmpty) {
    writer.writeBytes(payload);
  }
  return writer.toBytes();
}

// Build a export contact frame
// [cmd][pub_key x32 / if empty exports your contact info]
Uint8List buildExportContactFrame(Uint8List pubKey) {
  final writer = BufferWriter();
  writer.writeByte(cmdExportContact);
  writer.writeBytes(pubKey);
  return writer.toBytes();
}

// Build a import contact frame
// [cmd][contact_frame x98+]
Uint8List buildImportContactFrame(Uint8List contactFrame) {
  final writer = BufferWriter();
  writer.writeByte(cmdImportContact);
  writer.writeBytes(contactFrame);
  return writer.toBytes();
}

// Build a export contact frame
// [cmd][pub_key x32]
Uint8List buildZeroHopContact(Uint8List pubKey) {
  final writer = BufferWriter();
  writer.writeByte(cmdShareContact);
  writer.writeBytes(pubKey);
  return writer.toBytes();
}

// Build CMD_SET_OTHER_PARAMS frame
// Format: [cmd][allowTelemetryFlags][advertLocationPolicy][multiAcks]
Uint8List buildSetOtherParamsFrame(
  int allowTelemetryFlags,
  int advertLocationPolicy,
  int multiAcks,
) {
  final writer = BufferWriter();
  writer.writeByte(cmdSetOtherParams);
  //Going forward the app will just set Auto Add Contacts to disabled, and use the filter flags
  //Allow Auto Add Contacts use inverted logic (0x01 = disabled, 0x00 = enabled).
  writer.writeByte(0x01);
  writer.writeByte(allowTelemetryFlags); // Allow Telemetry Flags
  writer.writeByte(advertLocationPolicy); // Advertisement Location Policy
  writer.writeByte(multiAcks); // Multi Acknowledgements
  return writer.toBytes();
}

// Build CMD_SET_AUTO_ADD_CONFIG frame
// Format: [cmd][flags]
Uint8List buildSetAutoAddConfigFrame({
  required bool autoAddChat,
  required bool autoAddRepeater,
  required bool autoAddRoomServer,
  required bool autoAddSensor,
  required bool overwriteOldest,
}) {
  final writer = BufferWriter();
  writer.writeByte(cmdSetAutoAddConfig);
  int flags = 0;
  if (autoAddChat) flags |= autoAddChatFlag;
  if (autoAddRepeater) flags |= autoAddRepeaterFlag;
  if (autoAddRoomServer) flags |= autoAddRoomServerFlag;
  if (autoAddSensor) flags |= autoAddSensorFlag;
  if (overwriteOldest) flags |= autoAddOverwriteOldestFlag;
  writer.writeByte(flags);
  return writer.toBytes();
}

//Build CMD_SEND_TELEMETRY_REQ
// Format: [cmd][reserved x3][pub_key? x32]
Uint8List buildSendTelemetryReq(Uint8List? pubKey) {
  final writer = BufferWriter();
  writer.writeByte(cmdSendTelemetryReq);

  if (pubKey != null && pubKey.length == pubKeySize) {
    writer.writeBytes(Uint8List(3)); // reserved bytes
    writer.writeBytes(pubKey);
  } else {
    writer.writeBytes(Uint8List(3)); // reserved bytes
  }
  return writer.toBytes();
}

//Build CMD_SET_FLOOD_SCOPE
// Format: [cmd][scope]
Uint8List buildSetFloodScopeFrame(String region) {
  if (region == '') {
    // reset scope
    return Uint8List.fromList([cmdSetFloodScope, 0]);
  }

  final name = region.startsWith('#') ? region : '#$region';
  final hash = crypto.sha256.convert(utf8.encode(name)).bytes;
  final scope = Uint8List.fromList(hash.sublist(0, 16));

  return Uint8List.fromList([cmdSetFloodScope, 0, ...scope]);
}

// Build CMD_SEND_CHANNEL_TXT_MSG_CORRIDOR frame
// Format: [cmd][txt_type][channel_idx][timestamp x4][text...][triple x4]*N[N][flags]
// Unlike the plain channel send, the text is not NUL-terminated: the firmware
// derives its length from the trailer.
Uint8List buildSendChannelTextMsgCorridorFrame(
  int channelIndex,
  String text,
  List<CorridorTriple> corridor, {
  int flags = 0,
}) {
  if (corridor.isEmpty || corridor.length > maxCorridorTriples) {
    throw ArgumentError.value(corridor.length, 'corridor', 'must hold 1..8');
  }
  final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final writer = BufferWriter();
  writer.writeByte(cmdSendChannelTxtMsgCorridor);
  writer.writeByte(txtTypePlain);
  writer.writeByte(channelIndex);
  writer.writeUInt32LE(timestamp);
  writer.writeString(text);
  for (final triple in corridor) {
    writer.writeUInt32LE(triple.encode());
  }
  writer.writeByte(corridor.length);
  writer.writeByte(
    flags & (corridorFlagFailClosed | corridorFlagDestLastTriple),
  );
  final frame = writer.toBytes();
  if (frame.length > maxFrameSize) {
    throw ArgumentError.value(text, 'text', 'too long for corridor frame');
  }
  return frame;
}

// Build CMD_PROPOSE_CORRIDOR frame
// Format: [cmd][lat x4][lon x4][mode]  (mode bit 1 = denser width preset)
Uint8List buildProposeCorridorFrame(
  double lat,
  double lon, {
  bool dense = false,
}) {
  final writer = BufferWriter();
  writer.writeByte(cmdProposeCorridor);
  writer.writeInt32LE((lat * 1000000).round());
  writer.writeInt32LE((lon * 1000000).round());
  writer.writeByte(dense ? 0x02 : 0x00);
  return writer.toBytes();
}

// Build CMD_SET_CORRIDOR_REGION frame
// Format: [cmd][region name, no '#', max 31 bytes]; empty resets to "#corridor"
Uint8List buildSetCorridorRegionFrame(String region) {
  final name = region.startsWith('#') ? region.substring(1) : region;
  final encoded = utf8.encode(name);
  if (encoded.length > 31) {
    throw ArgumentError.value(region, 'region', 'longer than 31 bytes');
  }
  return Uint8List.fromList([cmdSetCorridorRegion, ...encoded]);
}

Uint8List buildGetCorridorRegionFrame() {
  return Uint8List.fromList([cmdGetCorridorRegion]);
}

// Parse RESP_CODE_PROPOSE_CORRIDOR
// Format: [resp][reason][count][triple x4]*count
CorridorProposal? parseCorridorProposalFrame(Uint8List frame) {
  if (frame.length < 3 || frame[0] != respCodeProposeCorridor) return null;
  final count = frame[2];
  if (count > maxCorridorTriples ||
      frame.length < 3 + count * corridorTripleBytes) {
    return null;
  }
  final data = ByteData.sublistView(frame);
  return CorridorProposal(
    reason: frame[1],
    triples: [
      for (var i = 0; i < count; i++)
        CorridorTriple.decode(
          data.getUint32(3 + i * corridorTripleBytes, Endian.little),
        ),
    ],
  );
}

// Parse RESP_CODE_CORRIDOR_REGION
// Format: [resp][region name x31, NUL-padded]; empty name means "#corridor"
String? parseCorridorRegionFrame(Uint8List frame) {
  if (frame.length < 32 || frame[0] != respCodeCorridorRegion) return null;
  final bytes = frame.sublist(1, 32);
  final end = bytes.indexOf(0);
  return utf8.decode(
    end == -1 ? bytes : bytes.sublist(0, end),
    allowMalformed: true,
  );
}

/// The radio's frequency in MHz from its reported value, or null when
/// unknown. MeshCore radios report kHz (911000 = 911 MHz); values that are
/// clearly Hz (10 MHz or more) are accepted too.
double? radioFrequencyMHz(int? reported) {
  if (reported == null || reported <= 0) return null;
  return reported >= 10000000 ? reported / 1e6 : reported / 1e3;
}
