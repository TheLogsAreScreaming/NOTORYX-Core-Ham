import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/l10n.dart';
import '../models/field_report.dart';
import '../services/field_ops_service.dart';
import '../services/operator_profile_service.dart';
import '../helpers/snack_bar_builder.dart';

/// Fills in a SALUTE or 9-Line report and sends it, as plain text under the
/// operator's call sign, when the operator presses Send.
class FieldReportScreen extends StatefulWidget {
  const FieldReportScreen({super.key});

  @override
  State<FieldReportScreen> createState() => _FieldReportScreenState();
}

class _FieldReportScreenState extends State<FieldReportScreen> {
  var _kind = FieldReportKind.salute;
  var _sending = false;
  late final _fields = {
    for (final kind in FieldReportKind.values)
      kind: [
        for (final line in kind.lines)
          TextEditingController(text: line.isTime ? _utcNow() : ''),
      ],
  };

  static String _utcNow() {
    final s = DateTime.now().toUtc().toIso8601String();
    return '${s.substring(0, 10)} ${s.substring(11, 16)}Z';
  }

  @override
  void dispose() {
    for (final list in _fields.values) {
      for (final c in list) {
        c.dispose();
      }
    }
    super.dispose();
  }

  Future<void> _send(FieldOpsService ops, List<String> parts) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final l10n = context.l10n;
    setState(() => _sending = true);
    try {
      await ops.sendFieldReport(_kind.wireName, parts);
      messenger.showSnackBar(SnackBar(content: Text(l10n.fieldReport_sent)));
      navigator.pop();
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.sos_notSent(friendlyError(e)))),
      );
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final radio = context.watch<MeshCoreConnector>();
    final ops = context.watch<FieldOpsService>();
    final profile = context.watch<OperatorProfileService>().profile;
    final controllers = _fields[_kind]!;
    final lat = radio.selfLatitude;
    final lon = radio.selfLongitude;

    final report = profile.hasValidCallsign
        ? buildFieldReport(
            _kind,
            [for (final c in controllers) c.text],
            callsign: profile.callsign,
            maxBytes: [
              maxContactMessageBytes(),
              maxChannelMessageBytes(radio.selfName),
            ].reduce((a, b) => a < b ? a : b),
          )
        : null;
    final parts = report is FieldReportParts ? report.parts : null;
    final blocked = !profile.hasValidCallsign
        ? l10n.fieldReport_needCallsign
        : report is FieldReportTooLong
        ? l10n.fieldReport_tooLong
        : ops.sosUnavailable;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.fieldReport_title), centerTitle: true),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l10n.fieldReport_hint),
            const SizedBox(height: 12),
            SegmentedButton<FieldReportKind>(
              segments: const [
                ButtonSegment(
                  value: FieldReportKind.salute,
                  label: Text('SALUTE'),
                ),
                ButtonSegment(
                  value: FieldReportKind.nineLine,
                  label: Text('9-Line'),
                ),
              ],
              selected: {_kind},
              onSelectionChanged: (s) => setState(() => _kind = s.single),
            ),
            const SizedBox(height: 12),
            for (final (i, line) in _kind.lines.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  key: ValueKey('report-${_kind.name}-${line.tag}'),
                  controller: controllers[i],
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: '${line.tag}: ${line.label}',
                    suffixIcon: line.isLocation && lat != null && lon != null
                        ? IconButton(
                            tooltip: l10n.fieldReport_usePosition,
                            icon: const Icon(Icons.my_location),
                            onPressed: () => setState(
                              () => controllers[i].text =
                                  '${lat.toStringAsFixed(4)},${lon.toStringAsFixed(4)}',
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            if (parts != null) ...[
              Text(
                l10n.fieldReport_preview(parts.length),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              for (final part in parts)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: SelectableText(part),
                ),
            ],
            if (blocked != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(blocked),
              ),
            FilledButton.icon(
              key: const ValueKey('report-send'),
              onPressed: parts == null || blocked != null || _sending
                  ? null
                  : () => _send(ops, parts),
              icon: const Icon(Icons.send),
              label: Text(l10n.fieldOps_send),
            ),
          ],
        ),
      ),
    );
  }
}
