import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/snack_bar_builder.dart';
import '../models/operator_profile.dart';
import '../services/operator_profile_service.dart';
import '../utils/amateur_power.dart';
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
  late final TextEditingController _externalAmp;
  late final TextEditingController _feedlineLoss;
  late final TextEditingController _antennaGain;
  LicenseClass? _licenseClass;
  bool _acknowledged = false;

  @override
  void initState() {
    super.initState();
    final profile = context.read<OperatorProfileService>().profile;
    _callsign = TextEditingController(text: profile.callsign);
    _externalAmp = TextEditingController(text: _num(profile.externalAmpDb));
    _feedlineLoss = TextEditingController(text: _num(profile.feedlineLossDb));
    _antennaGain = TextEditingController(text: _num(profile.antennaGainDbi));
    _licenseClass = profile.licenseClass;
    _acknowledged = profile.acknowledgedAt != null;
  }

  @override
  void dispose() {
    _callsign.dispose();
    _externalAmp.dispose();
    _feedlineLoss.dispose();
    _antennaGain.dispose();
    super.dispose();
  }

  static String _num(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();

  static double _db(TextEditingController c) =>
      double.tryParse(c.text.trim()) ?? 0;

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
        externalAmpDb: _db(_externalAmp),
        feedlineLossDb: _db(_feedlineLoss),
        antennaGainDbi: _db(_antennaGain),
      ),
    );
    if (!mounted) return;
    showDismissibleSnackBar(context, content: const Text('Operator saved'));
  }

  Widget _dbField(TextEditingController c, String label, String unit) =>
      TextField(
        controller: c,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}(\.\d?)?')),
        ],
        decoration: InputDecoration(
          labelText: label,
          suffixText: unit,
          border: const OutlineInputBorder(),
        ),
      );

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
            const SectionHeader('Antenna system'),
            MeshCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'For the power estimate below. Leave 0 for anything you '
                    "don't have.",
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  _dbField(_externalAmp, 'External amplifier gain', 'dB'),
                  const SizedBox(height: 12),
                  _dbField(_feedlineLoss, 'Feedline loss', 'dB'),
                  const SizedBox(height: 12),
                  _dbField(_antennaGain, 'Antenna gain', 'dBi'),
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
                note: "The radio chip's setting",
              ),
              ..._powerRows(connector.manufacturerName, tx, profile),
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

  /// Estimated output and ERP from the board's amplifier and the operator's
  /// antenna system, flagged above the 10 W spread-spectrum limit.
  List<Widget> _powerRows(String? board, int? chipDbm, OperatorProfile p) {
    final amp = boardAmplifierFor(board);
    final est = chipDbm == null
        ? null
        : PowerEstimate.of(
            chipDbm: chipDbm,
            board: amp,
            externalAmpDb: p.externalAmpDb,
            feedlineLossDb: p.feedlineLossDb,
            antennaGainDbi: p.antennaGainDbi,
          );
    final boardNote = amp == null
        ? 'Unknown board: counted as no amplifier'
        : '${amp.board}: ${amp.note}';
    if (est == null) {
      return [
        _StatusRow(
          ok: false,
          title: 'Estimated output',
          value: 'unknown',
          note: '$boardNote. Measure it before relying on any estimate.',
        ),
      ];
    }
    return [
      _StatusRow(
        ok: !est.overSpreadSpectrumLimit,
        title: 'Estimated output',
        value: formatPower(est.outputDbm),
        note: est.overSpreadSpectrumLimit
            ? 'Above 10 W PEP, the limit for spread spectrum such as LoRa '
                  '(§97.311). Turn it down.'
            : '$boardNote. An estimate: measure to be sure, and use the '
                  'least power that works.',
      ),
      _StatusRow(
        ok: true,
        title: 'Estimated ERP',
        value: formatPower(est.erpDbm),
        note:
            'After feedline loss and antenna gain, relative to a dipole. '
            'Check RF exposure (§97.13) at higher power.',
      ),
    ];
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
