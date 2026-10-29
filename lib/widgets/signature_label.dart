import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../services/signed_posts.dart';

/// Quiet marker for a signed channel post: a check for a contact's key, a
/// key for someone you don't have as a contact, and a question mark when
/// the signature didn't match. Long-press or hover explains which.
///
/// [color] should be a muted text color already checked for contrast against
/// the bubble it sits on. The icon, not the color, carries the meaning.
class SignatureLabel extends StatelessWidget {
  final SignatureBadge badge;
  final String? signer;
  final Color color;
  final double textScale;

  const SignatureLabel({
    super.key,
    required this.badge,
    this.signer,
    required this.color,
    this.textScale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (icon, label, explain) = switch (badge) {
      SignatureBadge.known => (
        Icons.verified_outlined,
        l10n.post_signed,
        l10n.post_signedKnown(signer ?? '?'),
      ),
      SignatureBadge.unknownKey => (
        Icons.key_outlined,
        l10n.post_signed,
        l10n.post_signedUnknownKey,
      ),
      SignatureBadge.unverified => (
        Icons.help_outline,
        l10n.post_unverified,
        l10n.post_unverifiedHint,
      ),
    };
    return Tooltip(
      message: explain,
      triggerMode: TooltipTriggerMode.tap,
      child: Semantics(
        label: explain,
        excludeSemantics: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 11 * textScale, color: color),
            const SizedBox(width: 2),
            Text(
              label,
              style: TextStyle(fontSize: 10.5 * textScale, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
