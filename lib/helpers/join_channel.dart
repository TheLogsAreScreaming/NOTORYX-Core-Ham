import 'package:flutter/material.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../models/channel.dart';
import 'snack_bar_builder.dart';

/// Joins the hashtag channel [name] in the radio's first free slot and says
/// how it went. True when it was added.
Future<bool> joinHashtagChannel(
  BuildContext context,
  MeshCoreConnector connector,
  String name,
) async {
  final l10n = context.l10n;
  if (!connector.isConnected) {
    showDismissibleSnackBar(
      context,
      content: Text(l10n.channelDirectory_connectFirst),
    );
    return false;
  }
  final used = connector.channels.map((c) => c.index).toSet();
  int? slot;
  for (var i = 0; i < connector.maxChannels; i++) {
    if (!used.contains(i)) {
      slot = i;
      break;
    }
  }
  if (slot == null) {
    showDismissibleSnackBar(
      context,
      content: Text(l10n.channelDirectory_slotsFull),
    );
    return false;
  }
  try {
    await connector.setChannel(slot, name, Channel.derivePskFromHashtag(name));
    if (context.mounted) {
      showDismissibleSnackBar(
        context,
        content: Text(l10n.channels_channelAdded(name)),
      );
    }
    return true;
  } catch (_) {
    if (context.mounted) {
      showDismissibleSnackBar(
        context,
        content: Text(l10n.channelDirectory_joinFailed),
      );
    }
    return false;
  }
}
