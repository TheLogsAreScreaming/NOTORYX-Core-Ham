import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/snack_bar_builder.dart';
import '../models/operator_profile.dart';
import '../services/operator_profile_service.dart';
import '../utils/amateur_radio.dart';
import '../widgets/mesh_ui.dart';

/// Where operators read what to coordinate before going on the air.
final Uri coordinationGuideUrl = Uri.parse(
  'https://github.com/TheLogsAreScreaming/NOTORYX-Core-Ham-Releases/blob/main/COORDINATION.md',
);

/// The operator's call sign, licence class and coordination acknowledgment,
/// plus how the connected radio lines up with them.
class LicensedOperatorScreen extends StatefulWidget {
  const LicensedOperatorScreen({super.key});

  @override
  State<LicensedOperatorScreen> createState() => _LicensedOperatorScreenState();
}

class _LicensedOperatorScreenState extends State<LicensedOperatorScreen> {
  late final TextEditingController _callsign;
  LicenseClass? _licenseClass;
  bool _acknowledged = false;

  @override
  void initState() {
    super.initState();
    final profile = context.read<OperatorProfileService>().profile;
    _callsign = TextEditingController(text: profile.callsign);
    _licenseClass = profile.licenseClass;
    _acknowledged = profile.acknowledgedAt != null;
  }

  @override
  void dispose() {
    _callsign.dispose();
    super.dispose();
  }

  String get _call => _callsign.text.trim().toUpperCase();

  bool get _canSave =>
      isUsCallsign(_call) && _licenseClass != null && _acknowledged;

  Future<void> _save() async {
    final service = context.read<OperatorProfileService>();
    final old = service.profile;
    await service.save(
      OperatorProfile(
        callsign: _call,
        licenseClass: _licenseClass,
        // Keep the first acknowledgment time unless the call sign changed.
        acknowledgedAt: old.callsign == _call && old.acknowledgedAt != null
            ? old.acknowledgedAt
            : DateTime.now(),
      ),
    );
    if (!mounted) return;
    showDismissibleSnackBar(context, content: const Text('Operator saved'));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final callError = _call.isEmpty || isUsCallsign(_call)
        ? null
        : 'Not a US call sign';
    return Scaffold(
      appBar: AppBar(title: const Text('Licensed operator')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'NOTORYX Core Ham radios transmit under an amateur licence '
                '(FCC Part 97). Everything sent is readable by anyone, and '
                'every frame carries the call sign at the start of the '
                "radio's name.",
                style: textTheme.bodyMedium,
              ),
            ),
            const SectionHeader('Your station'),
            MeshCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    key: const ValueKey('operator-callsign'),
                    controller: _callsign,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
                      LengthLimitingTextInputFormatter(6),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Call sign',
                      hintText: 'W1AW',
                      errorText: callError,
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<LicenseClass>(
                    key: const ValueKey('operator-class'),
                    initialValue: _licenseClass,
                    decoration: const InputDecoration(
                      labelText: 'Licence class',
                      helperText:
                          'Every class has full 33 cm and 70 cm privileges',
                      helperMaxLines: 2,
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      for (final c in LicenseClass.values)
                        DropdownMenuItem(value: c, child: Text(c.label)),
                    ],
                    onChanged: (c) => setState(() => _licenseClass = c),
                  ),
                ],
              ),
            ),
            const SectionHeader('Coordination'),
            MeshCard(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Use NOTORYX Core Ham only after a great deal of '
                    'coordination. Radios and repeaters transmit '
                    'automatically on shared bands, so before any radio goes '
                    'on the air, talk to your frequency coordinator, follow '
                    'the local band plan and agree one channel with every '
                    'operator in your area.',
                    style: textTheme.bodyMedium,
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('Read the coordination guide'),
                    onPressed: () => launchUrl(
                      coordinationGuideUrl,
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                  CheckboxListTile(
                    key: const ValueKey('operator-acknowledge'),
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _acknowledged,
                    title: const Text(
                      'I hold this licence, I have read the coordination '
                      'guide, and I will coordinate before transmitting.',
                    ),
                    onChanged: (v) =>
                        setState(() => _acknowledged = v ?? false),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: FilledButton(
                key: const ValueKey('operator-save'),
                onPressed: _canSave ? _save : null,
                child: const Text('Save'),
              ),
            ),
            const _ConnectedRadioSection(),
          ],
        ),
      ),
    );
  }
}

/// How the connected radio matches the saved operator, with a fix for the
/// one thing the app can set: the node name.
class _ConnectedRadioSection extends StatelessWidget {
  const _ConnectedRadioSection();

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final profile = context.watch<OperatorProfileService>().profile;
    if (!connector.isConnected) return const SizedBox.shrink();

    final name = connector.selfName ?? '';
    final nameOk = profile.hasValidCallsign && profile.matchesNodeName(name);
    final freqHz = connector.currentFreqHz;
    final mhz = freqHz == null ? null : freqHz / 1000.0;
    final tx = connector.currentTxPower;
    final maxTx = connector.maxTxPower;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeader('Connected radio'),
        MeshCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _StatusRow(
                ok: nameOk,
                title: 'Node name',
                value: name.isEmpty ? '—' : name,
                note: nameOk
                    ? 'Starts with your call sign'
                    : 'Must start with your call sign, or the radio stays silent',
                action: !nameOk && profile.hasValidCallsign
                    ? TextButton(
                        onPressed: () => _setName(context, profile.callsign),
                        child: Text('Set to ${profile.callsign}'),
                      )
                    : null,
              ),
              _StatusRow(
                ok: mhz != null && isAmateurFrequencyMHz(mhz),
                title: 'Frequency',
                value: mhz == null ? '—' : '${mhz.toStringAsFixed(3)} MHz',
                note: mhz != null && isAmateurFrequencyMHz(mhz)
                    ? 'In a ham band'
                    : 'Outside 420–450 / 902–928 MHz',
              ),
              _StatusRow(
                ok: true,
                title: 'TX power setting',
                value: tx == null
                    ? '—'
                    : '$tx dBm${maxTx == null ? '' : ' (max $maxTx)'}',
                note:
                    "The radio chip's setting. Boards with an amplifier "
                    'transmit more; use the least power that works.',
              ),
              _StatusRow(
                ok: true,
                title: 'Firmware',
                value: connector.firmwareVersionString ?? '—',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _setName(BuildContext context, String callsign) async {
    final connector = context.read<MeshCoreConnector>();
    await connector.setNodeName(callsign);
    await connector.refreshDeviceInfo();
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.ok,
    required this.title,
    required this.value,
    this.note,
    this.action,
  });

  final bool ok;
  final String title;
  final String value;
  final String? note;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(
        ok ? Icons.check_circle_outline : Icons.error_outline,
        color: ok ? scheme.primary : scheme.error,
        semanticLabel: ok ? 'OK' : 'Needs attention',
      ),
      title: Text('$title: $value'),
      subtitle: note == null ? null : Text(note!),
      trailing: action,
    );
  }
}
