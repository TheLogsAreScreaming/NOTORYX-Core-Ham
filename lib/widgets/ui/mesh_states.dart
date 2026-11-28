import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../../theme/mesh_theme.dart';
import '../empty_state.dart';

export '../empty_state.dart';

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
    return EmptyState(
      icon: Icons.error_outline,
      title: title,
      subtitle: message,
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

/// Asks before something that can't be undone (delete, clear, remove).
/// The confirm button is filled in the error color. Returns true only when
/// the user confirms. [confirmLabel] defaults to Delete.
Future<bool> confirmDestructive(
  BuildContext context, {
  String? title,
  String? message,
  String? confirmLabel,
  Key? confirmKey,
}) => _confirm(
  context,
  title: title,
  message: message,
  confirmLabel: confirmLabel ?? context.l10n.common_delete,
  confirmKey: confirmKey,
  destructive: true,
);

/// Asks before a consequential but safe action (join, share, download,
/// disconnect). Same layout as [confirmDestructive] with a primary button.
Future<bool> confirmAction(
  BuildContext context, {
  String? title,
  String? message,
  required String confirmLabel,
  Key? confirmKey,
}) => _confirm(
  context,
  title: title,
  message: message,
  confirmLabel: confirmLabel,
  confirmKey: confirmKey,
  destructive: false,
);

Future<bool> _confirm(
  BuildContext context, {
  required String? title,
  required String? message,
  required String confirmLabel,
  required bool destructive,
  Key? confirmKey,
}) async {
  final l10n = context.l10n;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      final scheme = Theme.of(context).colorScheme;
      return AlertDialog(
        title: title == null ? null : Text(title),
        content: message == null ? null : Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.common_cancel),
          ),
          FilledButton(
            key: confirmKey,
            style: destructive
                ? FilledButton.styleFrom(
                    backgroundColor: scheme.error,
                    foregroundColor: scheme.onError,
                  )
                : null,
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmLabel),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
