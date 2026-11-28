import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../services/app_lock_service.dart';
import '../theme/mesh_theme.dart';
import 'sos_panel.dart';

/// Hides [child] behind an unlock screen while the app lock is closed.
class AppLockGate extends StatefulWidget {
  const AppLockGate({super.key, required this.child});

  final Widget child;

  @override
  State<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends State<AppLockGate> with WidgetsBindingObserver {
  late final AppLockService _lock = context.read<AppLockService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused || AppLifecycleState.hidden:
        _lock.onBackground();
      case AppLifecycleState.resumed:
        _lock.onForeground();
      case AppLifecycleState.inactive || AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final locked = context.watch<AppLockService>().locked;
    return Stack(
      fit: StackFit.expand,
      children: [
        ExcludeSemantics(
          excluding: locked,
          child: IgnorePointer(
            ignoring: locked,
            child: Visibility.maintain(visible: !locked, child: widget.child),
          ),
        ),
        if (locked) const _UnlockScreen(),
      ],
    );
  }
}

class _UnlockScreen extends StatefulWidget {
  const _UnlockScreen();

  @override
  State<_UnlockScreen> createState() => _UnlockScreenState();
}

class _UnlockScreenState extends State<_UnlockScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _unlock();
    });
  }

  void _unlock() =>
      context.read<AppLockService>().unlock(context.l10n.appLock_reason);

  @override
  Widget build(BuildContext context) => Material(
    color: Theme.of(context).colorScheme.surface,
    child: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(MeshSpace.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.lock_outline, size: 56),
              const SizedBox(height: MeshSpace.lg),
              Text(
                context.l10n.appLock_locked,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: MeshSpace.lg),
              FilledButton.icon(
                onPressed: _unlock,
                icon: const Icon(Icons.fingerprint),
                label: Text(context.l10n.appLock_unlock),
              ),
              const SizedBox(height: MeshSpace.lg * 2),
              const LockScreenSos(),
            ],
          ),
        ),
      ),
    ),
  );
}
