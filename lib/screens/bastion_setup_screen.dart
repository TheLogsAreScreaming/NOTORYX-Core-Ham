import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/contact.dart';
import '../models/field_ops.dart';
import 'bastion_diagnostics_screen.dart';
import 'bastion_field_ops_screen.dart';
import 'chat_screen.dart';
import 'discovery_screen.dart';
import 'scanner_screen.dart';

class BastionSetupScreen extends StatefulWidget {
  const BastionSetupScreen({super.key});

  @override
  State<BastionSetupScreen> createState() => _BastionSetupScreenState();
}

class _BastionSetupScreenState extends State<BastionSetupScreen> {
  final _openedAt = DateTime.now();
  String? _contactKey;

  Future<void> _open(Widget screen) => Navigator.of(
    context,
  ).push<void>(MaterialPageRoute(builder: (_) => screen));

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
    return Scaffold(
      appBar: AppBar(title: const Text('Get started with Bastion')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Connect, choose a contact, then verify a message. You can return to this guide from the dashboard at any time.',
            ),
          ),
          _step('1. Connect your MeshCore radio', Icons.radio_outlined, [
            Text(
              radio.isConnected
                  ? 'Connected to ${radio.deviceDisplayName} using ${radio.activeTransport.name.toUpperCase()}.'
                  : 'No radio connected yet.',
            ),
            const SizedBox(height: 8),
            const Text(
              'Power on a MeshCore companion radio. Open Connect radio and choose Bluetooth, USB or TCP. Allow the permissions requested for your chosen connection.',
            ),
            const Text(
              'If Bluetooth discovery is empty, check Bluetooth is enabled and Bastion has Nearby devices permission in Android app settings. Follow any additional permission prompt shown by the scanner.',
            ),
            Wrap(
              spacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () => _open(const ScannerScreen()),
                  icon: const Icon(Icons.bluetooth_searching),
                  label: const Text('Connect radio'),
                ),
                TextButton(
                  onPressed: () => _open(const BastionDiagnosticsScreen()),
                  child: const Text('Connection diagnostics'),
                ),
              ],
            ),
          ]),
          _step('2. Choose a chat contact', Icons.person_outline, [
            const Text(
              'Ask a nearby partner with compatible MeshCore radio settings to advertise their node. Choose a known chat contact below; repeaters are managed separately.',
            ),
            if (radio.isLoadingContacts) const LinearProgressIndicator(),
            if (contacts.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'No chat contacts available. Connect your radio and open Mesh discovery.',
                ),
              )
            else
              DropdownButtonFormField<String>(
                key: ValueKey(selected?.publicKeyHex),
                initialValue: selected?.publicKeyHex,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Test recipient'),
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
              label: const Text('Mesh discovery'),
            ),
          ]),
          _step('3. Send and verify a message', Icons.mark_chat_read_outlined, [
            const Text(
              'Open chat, write a short test message, review the recipient and tap Send. Return here to see the latest outgoing message recorded since opening this guide.',
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: radio.isConnected && target != null
                  ? () => _open(ChatScreen(contact: target))
                  : null,
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('Open test chat'),
            ),
            if (!radio.isConnected)
              const Text('Connect your radio to open test chat.')
            else if (selected == null)
              const Text('Choose a recipient first.'),
            const SizedBox(height: 12),
            if (latest == null)
              const Text(
                'No outgoing test message recorded in this guide session.',
              )
            else ...[
              Text(
                'Latest message: ${latest.status.name.toUpperCase()} • ${latest.timestamp.toLocal()}',
              ),
              Text(explainMessageStatus(latest.status.name)),
            ],
            const SizedBox(height: 8),
            const Text(
              'Ask your partner to confirm receipt or reply. A recorded acknowledgment does not prove they read it. Recheck the connection and recipient if a message fails.',
            ),
          ]),
          _step('4. Prepare for the field', Icons.backpack_outlined, [
            const Text(
              'Plan your trip contacts and inspect downloaded map areas. Bot Mode and field automations start off; field automations run only while the app is active.',
            ),
            TextButton.icon(
              onPressed: () => _open(const BastionFieldOpsScreen()),
              icon: const Icon(Icons.checklist),
              label: const Text('Trip and readiness tools'),
            ),
          ]),
        ],
      ),
    );
  }
}
