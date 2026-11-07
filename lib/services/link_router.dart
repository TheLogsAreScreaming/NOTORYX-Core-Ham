import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/share_links.dart';
import '../l10n/l10n.dart';
import '../widgets/share_in_chat.dart';
import '../helpers/snack_bar_builder.dart';

/// Opens `meshcore://` links tapped in other apps: a contact link shows the
/// same preview card as pasting one, with its Add button, and a full advert
/// asks before it's added to the radio. Nothing is added without a tap.
class LinkRouter {
  LinkRouter(this.navigator, this.connector, {Stream<Uri> Function()? links})
    : _links = links ?? (() => AppLinks().uriLinkStream);

  final GlobalKey<NavigatorState> navigator;
  final MeshCoreConnector connector;
  final Stream<Uri> Function() _links;
  StreamSubscription<Uri>? _sub;

  /// Listens for links, including the one that opened the app.
  void start() {
    try {
      _sub = _links().listen(handle, onError: (Object _) {});
    } catch (_) {
      // Links aren't available here (for example in tests).
    }
  }

  void dispose() => _sub?.cancel();

  void handle(Uri uri) {
    if (uri.scheme.toLowerCase() != 'meshcore') return;
    final context = navigator.currentContext;
    if (context == null) {
      // Before the first frame; try again once the app is up.
      WidgetsBinding.instance.addPostFrameCallback((_) => handle(uri));
      return;
    }
    final pasted = parsePastedContact(uri.toString());
    final l10n = context.l10n;
    switch (pasted) {
      case PastedLink(:final link):
        showDialog<void>(
          context: context,
          builder: (dialog) => ChangeNotifierProvider<MeshCoreConnector>.value(
            value: connector,
            child: AlertDialog(
              key: const ValueKey('link-contact'),
              title: Text(l10n.links_contactTitle),
              content: ContactLinkCard(
                link: link,
                textColor: Theme.of(dialog).colorScheme.onSurface,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialog),
                  child: Text(l10n.common_close),
                ),
              ],
            ),
          ),
        );
      case PastedAdvert(:final advert):
        showDialog<void>(
          context: context,
          builder: (dialog) => AlertDialog(
            key: const ValueKey('link-advert'),
            title: Text(l10n.links_contactTitle),
            content: Text(
              connector.isConnected
                  ? l10n.links_importAdvert
                  : l10n.links_connectFirst,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialog),
                child: Text(l10n.common_cancel),
              ),
              FilledButton(
                key: const ValueKey('link-advert-add'),
                onPressed: !connector.isConnected
                    ? null
                    : () async {
                        final messenger = ScaffoldMessenger.maybeOf(dialog);
                        Navigator.pop(dialog);
                        try {
                          await connector.sendFrame(
                            buildImportContactFrame(advert),
                            expectsGenericAck: true,
                          );
                          await connector.refreshContacts();
                          messenger?.showSnackBar(
                            meshSnackBar(content: Text(l10n.links_added)),
                          );
                        } catch (_) {
                          messenger?.showSnackBar(
                            meshSnackBar(
                              content: Text(l10n.contacts_contactImportFailed),
                            ),
                          );
                        }
                      },
                child: Text(l10n.common_add),
              ),
            ],
          ),
        );
      case null:
        ScaffoldMessenger.maybeOf(context)
            ?.showSnackBar(meshSnackBar(content: Text(l10n.links_notContact)));
    }
  }
}
