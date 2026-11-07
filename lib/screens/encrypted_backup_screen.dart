import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../services/encrypted_backup_service.dart';
import '../widgets/ember_backdrop.dart';

class EncryptedBackupScreen extends StatefulWidget {
  const EncryptedBackupScreen({super.key});
  @override
  State<EncryptedBackupScreen> createState() => _EncryptedBackupScreenState();
}

class _EncryptedBackupScreenState extends State<EncryptedBackupScreen> {
  final _passphrase = TextEditingController();
  final _confirmation = TextEditingController();
  bool _chats = false;
  bool _busy = false;
  String? _status;

  @override
  void dispose() {
    _passphrase.dispose();
    _confirmation.dispose();
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
      final encrypted = await service.seal(
        service.snapshot(includeChats: _chats),
        _passphrase.text,
      );
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
          () => _status = 'Backup prepared. Keep your saved file and passphrase somewhere safe.',
        );
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
            'Save an encrypted copy of app settings, contacts and channel keys. Chat history is optional. Offline maps, photos and radio firmware are not included.',
          ),
          const SizedBox(height: 16),
          const Text(
            'Keep the passphrase separately. A lost passphrase cannot be recovered. Restore is not available in this preview.',
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
            title: const Text('Include chat history'),
            value: _chats,
            onChanged: _busy ? null : (value) => setState(() => _chats = value),
          ),
          FilledButton(
            onPressed: _busy ? null : _export,
            child: Text(_busy ? 'Encrypting…' : 'Save encrypted backup'),
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
