import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/l10n.dart';
import '../services/encrypted_backup_service.dart';
import '../storage/db/history_backup.dart';
import '../storage/db/message_db.dart';
import '../widgets/ember_backdrop.dart';

class EncryptedBackupScreen extends StatefulWidget {
  const EncryptedBackupScreen({super.key});
  @override
  State<EncryptedBackupScreen> createState() => _EncryptedBackupScreenState();
}

class _EncryptedBackupScreenState extends State<EncryptedBackupScreen> {
  final _passphrase = TextEditingController();
  final _confirmation = TextEditingController();
  final _restorePassphrase = TextEditingController();
  bool _busy = false;
  bool _includeHistory = true;
  String? _status;

  @override
  void dispose() {
    _passphrase.dispose();
    _confirmation.dispose();
    _restorePassphrase.dispose();
    super.dispose();
  }

  Future<void> _export() async {
    if (_passphrase.text.length < 12 ||
        _passphrase.text != _confirmation.text) {
      setState(
        () => _status = 'Use at least 12 characters and matching passphrases.',
      );
      return;
    }
    setState(() {
      _busy = true;
      _status = null;
    });
    File? file;
    try {
      final service = EncryptedBackupService();
      var values = service.snapshot(includeChats: false);
      final db = _includeHistory ? await MessageDb.ready : null;
      if (db != null) values = EncryptedBackupService.withHistory(values, db);
      final encrypted = await service.seal(values, _passphrase.text);
      final directory = await getTemporaryDirectory();
      file = File(
        '${directory.path}/bastion-backup-${DateTime.now().millisecondsSinceEpoch}.json',
      );
      await file.writeAsString(encrypted, flush: true);
      if (!mounted) return;
      final box = context.findRenderObject() as RenderBox?;
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          sharePositionOrigin: box == null
              ? null
              : box.localToGlobal(Offset.zero) & box.size,
        ),
      );
      _passphrase.clear();
      _confirmation.clear();
      if (mounted) {
        setState(
          () => _status =
              'Backup prepared. Keep your saved file and passphrase somewhere safe.',
        );
      }
    } on BackupTooLargeException {
      if (mounted) {
        setState(() => _status = context.l10n.bk_tooLarge);
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => _status =
              'Could not export the backup. Your existing data was unchanged.',
        );
      }
    } finally {
      if (file != null && await file.exists()) await file.delete();
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _restore() async {
    final XFile? file;
    try {
      file = await openFile();
    } catch (_) {
      setState(() => _status = 'Could not open that file.');
      return;
    }
    if (file == null || !mounted) return;
    setState(() {
      _busy = true;
      _status = null;
    });
    try {
      final service = EncryptedBackupService();
      final Map<String, Object> values;
      try {
        values = await service.open(
          await file.readAsString(),
          _restorePassphrase.text,
        );
      } catch (_) {
        if (mounted) {
          setState(
            () => _status =
                'Wrong passphrase, or this isn\'t a valid backup. Nothing was changed.',
          );
        }
        return;
      }
      if (!mounted) return;
      final count = values.keys
          .where(EncryptedBackupService.isRestorable)
          .length;
      final messages = HistoryBackup.count(values[HistoryBackup.key]);
      final go = await showDialog<bool>(
        context: context,
        builder: (dialog) => AlertDialog(
          title: Text(context.l10n.bk_confirmTitle),
          content: Text(
            messages > 0
                ? '${context.l10n.bk_confirmBody(count)}\n\n'
                      '${context.l10n.bk_confirmHistory(messages)}'
                : context.l10n.bk_confirmBody(count),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialog, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialog, true),
              child: const Text('Restore'),
            ),
          ],
        ),
      );
      if (go != true) return;
      final restored = await service.restore(values);
      final db = messages > 0 ? await MessageDb.ready : null;
      final added = db == null
          ? 0
          : EncryptedBackupService.restoreHistory(values, db);
      _restorePassphrase.clear();
      if (mounted) {
        final l10n = context.l10n;
        setState(
          () => _status = added > 0
              ? '${l10n.bk_restoredHistory(added)} ${l10n.bk_restored(restored)}'
              : l10n.bk_restored(restored),
        );
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => _status =
              'Restore stopped part way, so some settings may have changed. Try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => EmberBackdrop(
    scene: EmberScene.more,
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text('Encrypted backup'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Save an encrypted copy of app settings, contacts, channel keys, waypoints and drafts. Message history, offline maps, photos and radio firmware are not included.',
          ),
          const SizedBox(height: 16),
          const Text(
            'Keep the passphrase separately. A lost passphrase cannot be recovered.',
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passphrase,
            obscureText: true,
            enabled: !_busy,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              labelText: 'Passphrase (12+ characters)',
            ),
          ),
          TextField(
            controller: _confirmation,
            obscureText: true,
            enabled: !_busy,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(labelText: 'Confirm passphrase'),
          ),
          SwitchListTile(
            key: const ValueKey('backup-history'),
            contentPadding: EdgeInsets.zero,
            value: _includeHistory,
            onChanged: _busy
                ? null
                : (value) => setState(() => _includeHistory = value),
            title: Text(context.l10n.bk_history),
            subtitle: Text(context.l10n.bk_historyHint),
          ),
          FilledButton(
            onPressed: _busy ? null : _export,
            child: Text(_busy ? 'Working…' : 'Save encrypted backup'),
          ),
          const Divider(height: 40),
          const Text(
            'Restore a backup',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          TextField(
            key: const ValueKey('restore-passphrase'),
            controller: _restorePassphrase,
            obscureText: true,
            enabled: !_busy,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(labelText: 'Backup passphrase'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            key: const ValueKey('restore-backup'),
            onPressed: _busy ? null : _restore,
            child: const Text('Choose backup file'),
          ),
          if (_status != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(_status!),
            ),
        ],
      ),
    ),
  );
}
