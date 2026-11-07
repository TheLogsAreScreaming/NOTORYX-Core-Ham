import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../../theme/mesh_theme.dart';

/// A centred, quiet message for a list or screen with nothing in it yet:
/// what's missing, why, and (optionally) the one thing to do about it.
class MeshEmptyState extends StatelessWidget {
  const MeshEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? message;

  /// Usually a FilledButton or OutlinedButton.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: MeshSpace.xxl,
          vertical: MeshSpace.xl,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 30, color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: MeshSpace.lg),
              Text(title, style: text.titleMedium, textAlign: TextAlign.center),
              if (message != null) ...[
                const SizedBox(height: MeshSpace.sm),
                Text(
                  message!,
                  style: text.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: MeshSpace.xl),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// A spinner with an optional line saying what is being loaded.
class MeshLoadingState extends StatelessWidget {
  const MeshLoadingState({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Center(
      child: Semantics(
        liveRegion: true,
        label: message ?? context.l10n.common_loading,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox.square(
              dimension: 28,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            ),
            if (message != null) ...[
              const SizedBox(height: MeshSpace.md),
              Text(
                message!,
                style: text.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Something failed: what happened, in plain words, and a retry if there is
/// one.
class MeshErrorState extends StatelessWidget {
  const MeshErrorState({
    super.key,
    required this.title,
    this.message,
    this.onRetry,
  });

  final String title;
  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final status = MeshStatusColors.of(context);
    return MeshEmptyState(
      icon: Icons.error_outline,
      title: title,
      message: message,
      action: onRetry == null
          ? null
          : OutlinedButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh, color: status.error),
              label: Text(context.l10n.common_retry),
            ),
    );
  }
}

/// An inline message in a tinted box: info, success, warning or error, with
/// an optional action. For things the user should notice without a dialog.
class MeshStatusBanner extends StatelessWidget {
  const MeshStatusBanner({
    super.key,
    required this.status,
    required this.title,
    this.message,
    this.action,
    this.margin = const EdgeInsets.symmetric(
      horizontal: MeshSpace.lg,
      vertical: MeshSpace.sm,
    ),
  });

  final MeshStatus status;
  final String title;
  final String? message;
  final Widget? action;
  final EdgeInsetsGeometry margin;

  static IconData iconFor(MeshStatus s) => switch (s) {
    MeshStatus.info => Icons.info_outline,
    MeshStatus.success => Icons.check_circle_outline,
    MeshStatus.warning => Icons.warning_amber_rounded,
    MeshStatus.error => Icons.error_outline,
  };

  @override
  Widget build(BuildContext context) {
    final colors = MeshStatusColors.of(context);
    final text = Theme.of(context).textTheme;
    final accent = colors.color(status);
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(MeshSpace.md),
      decoration: BoxDecoration(
        color: colors.container(status),
        borderRadius: BorderRadius.circular(MeshShape.control),
        border: Border.all(color: accent.withValues(alpha: 0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconFor(status), color: accent, size: 22),
          const SizedBox(width: MeshSpace.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: text.titleSmall?.copyWith(color: colors.onContainer),
                ),
                if (message != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    message!,
                    style: text.bodySmall?.copyWith(color: colors.onContainer),
                  ),
                ],
                if (action != null) ...[
                  const SizedBox(height: MeshSpace.sm),
                  action!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Asks before something that can't be undone. Returns true only when the
/// user confirms. [confirmLabel] defaults to Delete.
Future<bool> confirmDestructive(
  BuildContext context, {
  required String title,
  String? message,
  String? confirmLabel,
}) async {
  final l10n = context.l10n;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      final scheme = Theme.of(context).colorScheme;
      return AlertDialog(
        title: Text(title),
        content: message == null ? null : Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.common_cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: scheme.error,
              foregroundColor: scheme.onError,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmLabel ?? l10n.common_delete),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
