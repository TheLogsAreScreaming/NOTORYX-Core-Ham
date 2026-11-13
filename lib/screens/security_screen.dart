import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/l10n.dart';
import '../services/app_lock_service.dart';
import '../storage/db/message_db.dart';

/// The app lock and encrypted message history switches.
class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool? _wantEncrypted;
  bool _lockAvailable = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final lock = context.read<AppLockService>();
    final prefs = await SharedPreferences.getInstance();
    final available = await lock.isAvailable();
    await MessageDb.ready;
    if (!mounted) return;
    setState(() {
      _wantEncrypted = prefs.getBool(MessageDb.encryptPrefKey) ?? false;
      _lockAvailable = available;
    });
  }

  Future<void> _setEncrypted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(MessageDb.encryptPrefKey, value);
    if (mounted) setState(() => _wantEncrypted = value);
  }

  Future<void> _setLock(bool value) async {
    final lock = context.read<AppLockService>();
    final reason = context.l10n.appLock_reason;
    final messenger = ScaffoldMessenger.of(context);
    final failed = context.l10n.appLock_unavailable;
    if (!await lock.setEnabled(value, reason)) {
      messenger.showSnackBar(SnackBar(content: Text(failed)));
    }
  }

  String _encryptStatus(BuildContext context, bool want) {
    final l10n = context.l10n;
    final state = MessageDb.encryptionState;
    final on = state == MessageDbEncryption.on;
    if (state == MessageDbEncryption.failed) return l10n.dbEncrypt_failed;
    if (want != on) return l10n.dbEncrypt_restart;
    return on ? l10n.dbEncrypt_on : l10n.dbEncrypt_off;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final lock = context.watch<AppLockService>();
    final want = _wantEncrypted;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.security_title)),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.lock_outline),
            title: Text(l10n.appLock_title),
            subtitle: Text(
              _lockAvailable || want == null
                  ? l10n.appLock_subtitle
                  : l10n.appLock_unavailable,
            ),
            value: lock.enabled,
            onChanged: _lockAvailable ? _setLock : null,
          ),
          const Divider(),
          SwitchListTile(
            secondary: const Icon(Icons.enhanced_encryption_outlined),
            title: Text(l10n.dbEncrypt_title),
            subtitle: Text(
              [
                l10n.dbEncrypt_subtitle,
                l10n.dbEncrypt_covers,
                if (want != null) _encryptStatus(context, want),
              ].join('\n'),
            ),
            value: want ?? false,
            onChanged: want == null ? null : _setEncrypted,
          ),
        ],
      ),
    );
  }
}
