import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/field_ops.dart';
import 'bastion_diagnostics_screen.dart';
import 'bastion_field_ops_screen.dart';
import 'chat_screen.dart';
import 'discovery_screen.dart';
import 'connection_setup_screen.dart';

class BastionSetupScreen extends StatefulWidget {
  const BastionSetupScreen({super.key});

  @override
  State<BastionSetupScreen> createState() => _BastionSetupScreenState();
}

class _BastionSetupScreenState extends State<BastionSetupScreen> {
  final _openedAt = DateTime.now();
  String? _contactKey;

  Future<void> _open(Widget screen) =>
      Navigator.of(context)
          .push<void>(MaterialPageRoute(builder: (_) => screen));

  Widget _step(String title, IconData icon, List<Widget> children) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(icon),
            title: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          ...children,
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final radio = context.watch<MeshCoreConnector>();
    final contacts =
        radio.contacts
            .where(
              (c) =>
                  c.type == advTypeChat &&
                  c.publicKeyHex != radio.selfPublicKeyHex,
            )
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
    Contact? selected;
    for (final contact in contacts) {
      if (contact.publicKeyHex == _contactKey) selected = contact;
    }
    final target = selected;
    final messages = selected == null
        ? null
        : radio
              .getMessages(selected)
              .where(
                (m) =>
                    m.isOutgoing &&
                    !m.isCli &&
                    !m.timestamp.isBefore(_openedAt),
              )
              .toList();
    messages?.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    final latest = messages == null || messages.isEmpty ? null : messages.first;
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.bastionSetup_title)),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(l10n.bastionSetup_intro),
          ),
          _step(l10n.bastionSetup_step1, Icons.radio_outlined, [
            Text(
              radio.isConnected
                  ? l10n.bastionSetup_connectedTo(
                      radio.deviceDisplayName,
                      radio.activeTransport.name.toUpperCase(),
                    )
                  : l10n.bastionSetup_noRadio,
            ),
            const SizedBox(height: 8),
            Text(l10n.bastionSetup_step1Power),
            Text(l10n.bastionSetup_step1Bluetooth),
            Wrap(
              spacing: 8,
              children: [
                if (radio.isConnected)
                  FilledButton.icon(
                    onPressed: () => _open(const BastionDiagnosticsScreen()),
                    icon: const Icon(Icons.check_circle_outline),
                    label: Text(l10n.bastionSetup_connectionDiagnostics),
                  )
                else ...[
                  FilledButton.icon(
                    onPressed: () => openConnectionSetup(context),
                    icon: const Icon(Icons.bluetooth_searching),
                    label: Text(l10n.fieldOps_connectRadio),
                  ),
                  TextButton(
                    onPressed: () => _open(const BastionDiagnosticsScreen()),
                    child: Text(l10n.bastionSetup_connectionDiagnostics),
                  ),
                ],
              ],
            ),
          ]),
          _step(l10n.bastionSetup_step2, Icons.person_outline, [
            Text(l10n.bastionSetup_step2Body),
            if (radio.isLoadingContacts) const LinearProgressIndicator(),
            if (contacts.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(l10n.bastionSetup_noContacts),
              )
            else
              DropdownButtonFormField<String>(
                key: ValueKey(selected?.publicKeyHex),
                initialValue: selected?.publicKeyHex,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: l10n.bastionSetup_testRecipient,
                ),
                items: contacts
                    .map(
                      (c) => DropdownMenuItem(
                        value: c.publicKeyHex,
                        child: Text(c.name, overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
                onChanged: (key) => setState(() => _contactKey = key),
              ),
            TextButton.icon(
              onPressed: radio.isConnected
                  ? () => _open(const DiscoveryScreen())
                  : null,
              icon: const Icon(Icons.radar),
              label: Text(l10n.bastionSetup_meshDiscovery),
            ),
          ]),
          _step(l10n.bastionSetup_step3, Icons.mark_chat_read_outlined, [
            Text(l10n.bastionSetup_step3Body),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: radio.isConnected && target != null
                  ? () => _open(ChatScreen(contact: target))
                  : null,
              icon: const Icon(Icons.chat_bubble_outline),
              label: Text(l10n.bastionSetup_openTestChat),
            ),
            if (!radio.isConnected)
              Text(l10n.bastionSetup_connectFirst)
            else if (selected == null)
              Text(l10n.bastionSetup_chooseRecipient),
            const SizedBox(height: 12),
            if (latest == null)
              Text(l10n.bastionSetup_noTestMessage)
            else ...[
              Text(
                l10n.bastionSetup_latestMessage(
                  messageStatusLabel(
                    latest.status.name,
                    l10n: l10n,
                  ).toUpperCase(),
                  '${latest.timestamp.toLocal()}',
                ),
              ),
              Text(explainMessageStatus(latest.status.name, l10n: l10n)),
            ],
            const SizedBox(height: 8),
            Text(l10n.bastionSetup_confirmReceipt),
          ]),
          _step(l10n.bastionSetup_step4, Icons.backpack_outlined, [
            Text(l10n.bastionSetup_step4Body),
            TextButton.icon(
              onPressed: () => _open(const BastionFieldOpsScreen()),
              icon: const Icon(Icons.checklist),
              label: Text(l10n.bastionSetup_tripTools),
            ),
          ]),
        ],
      ),
    );
  }
}
