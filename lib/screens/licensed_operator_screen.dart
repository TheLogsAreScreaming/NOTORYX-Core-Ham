import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/snack_bar_builder.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/operator_profile.dart';
import '../services/operator_profile_service.dart';
import '../theme/mesh_theme.dart';
import '../utils/amateur_location.dart';
import '../utils/amateur_power.dart';
import '../utils/amateur_radio.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/ui/mesh_states.dart';

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
    showDismissibleSnackBar(
      context,
      content: Text(context.l10n.ham_operatorSaved),
    );
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
    final l10n = context.l10n;
    final callError = _call.isEmpty || isUsCallsign(_call)
        ? null
        : l10n.ham_notUsCallsign;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.ham_licensedOperator)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(l10n.ham_operatorIntro, style: textTheme.bodyMedium),
            ),
            SectionHeader(l10n.ham_yourStation),
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
                      labelText: l10n.ham_callSign,
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
                    decoration: InputDecoration(
                      labelText: l10n.ham_licenceClass,
                      helperText: l10n.ham_licenceClassHelper,
                      border: const OutlineInputBorder(),
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
            SectionHeader(l10n.ham_antennaSystem),
            MeshCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.ham_antennaSystemHint, style: textTheme.bodySmall),
                  const SizedBox(height: 12),
                  _dbField(_externalAmp, l10n.ham_externalAmpGain, 'dB'),
                  const SizedBox(height: 12),
                  _dbField(_feedlineLoss, l10n.ham_feedlineLoss, 'dB'),
                  const SizedBox(height: 12),
                  _dbField(_antennaGain, l10n.ham_antennaGain, 'dBi'),
                ],
              ),
            ),
            SectionHeader(l10n.ham_coordination),
            MeshCard(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.ham_coordinationNotice,
                    style: textTheme.bodyMedium,
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: Text(l10n.ham_readCoordinationGuide),
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
                    title: Text(l10n.ham_acknowledgment),
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
                child: Text(l10n.common_save),
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
    final l10n = context.l10n;

    final rows = <_StatusRow>[
      _StatusRow(
        ok: nameOk,
        title: l10n.ham_nodeName,
        value: name.isEmpty ? '—' : name,
        note: nameOk ? l10n.ham_nodeNameOk : l10n.ham_nodeNameBad,
        action: !nameOk && profile.hasValidCallsign
            ? TextButton(
                onPressed: () => _setName(context, profile.callsign),
                child: Text(l10n.ham_setNameTo(profile.callsign)),
              )
            : null,
      ),
      _StatusRow(
        ok: mhz != null && isAmateurFrequencyMHz(mhz),
        title: l10n.ham_frequency,
        value: mhz == null ? '—' : '${mhz.toStringAsFixed(3)} MHz',
        note: mhz != null && isAmateurFrequencyMHz(mhz)
            ? l10n.ham_inHamBand
            : l10n.ham_outsideHamBands,
      ),
      _StatusRow(
        ok: true,
        title: l10n.ham_txPowerSetting,
        value: tx == null
            ? '—'
            : '$tx dBm${maxTx == null ? '' : ' (max $maxTx)'}',
        note: l10n.ham_chipSetting,
      ),
      ..._powerRows(l10n, connector.manufacturerName, tx, profile),
      if (mhz != null)
        ..._locationRows(
          l10n,
          mhz,
          connector.selfLatitude,
          connector.selfLongitude,
        ),
    ];
    // The pre-transmit checklist: setup finished and every check above passes.
    final ready = profile.isComplete && rows.every((r) => r.ok);
    final heard = connector.lastHeardStation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(l10n.ham_connectedRadio),
        MeshStatusBanner(
          status: ready ? MeshStatus.success : MeshStatus.warning,
          title: ready ? l10n.ham_readyToTransmit : l10n.ham_notReadyToTransmit,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        ),
        MeshCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              ...rows,
              _StatusRow(
                ok: true,
                title: l10n.ham_lastHeard,
                value: heard ?? l10n.ham_nothingHeardYet,
              ),
              _StatusRow(
                ok: true,
                title: l10n.ham_firmware,
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
  List<_StatusRow> _powerRows(
    AppLocalizations l10n,
    String? board,
    int? chipDbm,
    OperatorProfile p,
  ) {
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
    final gain = amp?.gainDb;
    final boardNote = amp == null
        ? l10n.ham_unknownBoard
        : l10n.ham_boardNote(
            amp.board,
            gain == null
                ? l10n.ham_ampVariable
                : gain == 0
                ? l10n.ham_ampNone
                : l10n.ham_ampGain(gain.toStringAsFixed(0)),
          );
    if (est == null) {
      return [
        _StatusRow(
          ok: false,
          title: l10n.ham_estimatedOutput,
          value: l10n.ham_unknown,
          note: l10n.ham_measureFirst(boardNote),
        ),
      ];
    }
    return [
      _StatusRow(
        ok: !est.overSpreadSpectrumLimit,
        title: l10n.ham_estimatedOutput,
        value: formatPower(est.outputDbm),
        note: est.overSpreadSpectrumLimit
            ? l10n.ham_overSpreadSpectrum
            : l10n.ham_outputNote(boardNote),
      ),
      _StatusRow(
        ok: true,
        title: l10n.ham_estimatedErp,
        value: formatPower(est.erpDbm),
        note: l10n.ham_erpNote,
      ),
    ];
  }

  List<_StatusRow> _locationRows(
    AppLocalizations l10n,
    double mhz,
    double? lat,
    double? lon,
  ) {
    final cautions = locationCautions(mhz, lat, lon);
    if (cautions.isEmpty) {
      return [
        _StatusRow(
          ok: true,
          title: l10n.ham_location,
          value: l10n.ham_noLocationLimits,
          note: l10n.ham_locationOkNote,
        ),
      ];
    }
    return [
      for (final c in cautions)
        _StatusRow(
          ok: false,
          title: l10n.ham_location,
          value: l10n.ham_check,
          note: switch (c) {
            LocationCaution.positionUnknown => l10n.ham_positionUnknown,
            LocationCaution.exclusion33cm => l10n.ham_exclusion33cm,
            LocationCaution.lineA => l10n.ham_lineA,
          },
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
        semanticLabel: ok
            ? context.l10n.ham_statusOk
            : context.l10n.ham_needsAttention,
      ),
      title: Text('$title: $value'),
      subtitle: note == null ? null : Text(note!),
      trailing: action,
    );
  }
}
