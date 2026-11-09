import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/snack_bar_builder.dart';
import '../l10n/l10n.dart';
import '../models/team_config.dart';
import '../services/operator_profile_service.dart';
import '../services/team_config_apply.dart';
import '../widgets/qr_code_display.dart';
import '../widgets/qr_scanner_widget.dart';

/// Shares this radio's settings and hashtag channels with a team by QR code
/// or file, and applies ones received, after the operator reviews them.
class TeamConfigScreen extends StatelessWidget {
  const TeamConfigScreen({super.key});

  TeamConfig? _current(MeshCoreConnector radio) {
    final (f, b, s, c) = (
      radio.currentFreqHz,
      radio.currentBwHz,
      radio.currentSf,
      radio.currentCr,
    );
    if (!radio.isConnected ||
        f == null ||
        b == null ||
        s == null ||
        c == null) {
      return null;
    }
    return TeamConfig.fromRadio(
      freqKhz: f,
      bandwidthHz: b,
      spreadingFactor: s,
      deviceCodingRate: c,
      channelNames: radio.channels.map((c) => c.name),
    );
  }

  Future<void> _shareFile(TeamConfig config) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/notoryx-ham-team.json');
    await file.writeAsString(config.encode());
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }

  Future<void> _scan(BuildContext context) async {
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    final text = await navigator.push<String>(
      MaterialPageRoute(
        builder: (route) => Scaffold(
          appBar: AppBar(title: Text(l10n.team_scan), centerTitle: true),
          body: QrScannerWidget(
            onScanned: (data) => Navigator.pop(route, data),
            validator: (data) => TeamConfig.tryParse(data) != null,
            onValidationFailed: (_) => showDismissibleSnackBar(
              route,
              content: Text(l10n.team_invalid),
            ),
          ),
        ),
      ),
    );
    if (text != null && context.mounted) await _review(context, text);
  }

  Future<void> _openFile(BuildContext context) async {
    final l10n = context.l10n;
    final file = await openFile(
      acceptedTypeGroups: const [
        XTypeGroup(label: 'JSON', extensions: ['json']),
      ],
    );
    if (file == null || !context.mounted) return;
    try {
      final text = utf8.decode(await file.readAsBytes());
      if (context.mounted) await _review(context, text);
    } on FormatException {
      if (context.mounted) {
        showDismissibleSnackBar(context, content: Text(l10n.team_invalid));
      }
    }
  }

  Future<void> _review(BuildContext context, String text) async {
    final l10n = context.l10n;
    final config = TeamConfig.tryParse(text);
    if (config == null) {
      showDismissibleSnackBar(context, content: Text(l10n.team_invalid));
      return;
    }
    final radio = context.read<MeshCoreConnector>();
    final complete = context.read<OperatorProfileService>().profile.isComplete;
    final blocked = !complete
        ? l10n.ham_operatorCardIncomplete
        : !radio.isConnected
        ? l10n.channelDirectory_connectFirst
        : null;
    final apply = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.team_importTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_summary(context, config)),
              if (config.channels.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(l10n.team_channels(config.channels.join(', '))),
              ],
              const SizedBox(height: 12),
              Text(l10n.ham_coordinationNotice),
              if (blocked != null) ...[
                const SizedBox(height: 12),
                Text(blocked),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.common_cancel),
          ),
          FilledButton(
            key: const ValueKey('team-apply'),
            onPressed: blocked == null ? () => Navigator.pop(ctx, true) : null,
            child: Text(l10n.team_apply),
          ),
        ],
      ),
    );
    if (apply != true || !context.mounted) return;
    try {
      final skipped = await applyTeamConfig(radio, config);
      if (context.mounted) {
        showDismissibleSnackBar(
          context,
          content: Text(
            skipped.isEmpty
                ? l10n.team_applied
                : l10n.channelDirectory_slotsFull,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        showDismissibleSnackBar(context, content: Text(friendlyError(e)));
      }
    }
  }

  String _summary(BuildContext context, TeamConfig c) =>
      context.l10n.team_summary(
        (c.freqKhz / 1000).toStringAsFixed(3),
        (c.bandwidthHz / 1000).toStringAsFixed(1),
        c.spreadingFactor,
        c.codingRate,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final config = _current(context.watch<MeshCoreConnector>());
    return Scaffold(
      appBar: AppBar(title: Text(l10n.team_title), centerTitle: true),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l10n.team_shareHint),
            const SizedBox(height: 12),
            if (config == null)
              Text(l10n.channelDirectory_connectFirst)
            else ...[
              Text(_summary(context, config)),
              if (config.channels.isNotEmpty)
                Text(l10n.team_channels(config.channels.join(', '))),
              Center(child: QrCodeDisplay(data: config.encode(), size: 240)),
              OutlinedButton.icon(
                key: const ValueKey('team-share-file'),
                onPressed: () => _shareFile(config),
                icon: const Icon(Icons.ios_share),
                label: Text(l10n.team_shareFile),
              ),
            ],
            const Divider(height: 32),
            FilledButton.tonalIcon(
              key: const ValueKey('team-scan'),
              onPressed: () => _scan(context),
              icon: const Icon(Icons.qr_code_scanner),
              label: Text(l10n.team_scan),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              key: const ValueKey('team-open-file'),
              onPressed: () => _openFile(context),
              icon: const Icon(Icons.file_open_outlined),
              label: Text(l10n.team_openFile),
            ),
          ],
        ),
      ),
    );
  }
}
