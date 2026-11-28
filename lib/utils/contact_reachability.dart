import '../connector/meshcore_connector.dart';
import '../models/contact.dart';
import '../models/message.dart';

enum ContactReachability {
  /// We sent a message that was ACKed and they sent us a message.
  twoWay,

  /// We sent a message that was ACKed but have not received anything from them.
  theyHeardUs,

  /// No delivered ACK from this contact yet.
  noAnswer,
}

/// Derives reachability from stored messages — no network activity.
ContactReachability contactReachability(
  MeshCoreConnector connector,
  Contact contact,
) {
  final messages = connector.getMessages(contact);
  var weGotAck = false;
  var theyMessagedUs = false;
  for (final m in messages) {
    if (m.isOutgoing && m.status == MessageStatus.delivered) weGotAck = true;
    if (!m.isOutgoing && !m.isCli) theyMessagedUs = true;
    if (weGotAck && theyMessagedUs) break;
  }
  if (weGotAck && theyMessagedUs) return ContactReachability.twoWay;
  if (weGotAck) return ContactReachability.theyHeardUs;
  return ContactReachability.noAnswer;
}
