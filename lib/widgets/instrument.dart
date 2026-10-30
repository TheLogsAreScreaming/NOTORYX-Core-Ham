import 'package:flutter/material.dart';

import '../theme/mesh_theme.dart';

/// The field-instrument kit: hairlines and columns instead of cards,
/// numbers in the mono face, colour only for signal and danger.
///
/// [ReadoutStrip] for live numbers, [InstrumentLabel] for section titles,
/// [InstrumentRow] for list entries, [SignalReadout] for SNR, and
/// [InstrumentButton] for actions.

/// The hairline used between rows and readouts.
Color get instrumentLine => MeshPalette.line.withValues(alpha: 0.7);

/// One live value in a [ReadoutStrip].
class Readout {
  final String value;
  final String label;
  final Color? color;
  const Readout(this.value, this.label, {this.color});
}

/// A row of live numbers between two hairlines, split by vertical
/// hairlines, like the face of a handheld instrument.
class ReadoutStrip extends StatelessWidget {
  final List<Readout> readouts;
  const ReadoutStrip(this.readouts, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: instrumentLine)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < readouts.length; i++)
              Expanded(
                child: Container(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    i == 0 ? MeshSpace.lg : MeshSpace.md,
                    MeshSpace.md,
                    MeshSpace.xs,
                    MeshSpace.md,
                  ),
                  decoration: i == 0
                      ? null
                      : BoxDecoration(
                          border: BorderDirectional(
                            start: BorderSide(color: instrumentLine),
                          ),
                        ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        readouts[i].value,
                        maxLines: 1,
                        style: MeshTheme.mono(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: readouts[i].color ?? MeshPalette.ink,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        readouts[i].label,
                        maxLines: 1,
                        style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// A quiet section title with an optional trailing note.
class InstrumentLabel extends StatelessWidget {
  final String text;
  final String? trailing;
  const InstrumentLabel(this.text, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        MeshSpace.lg,
        MeshSpace.lg,
        MeshSpace.lg,
        MeshSpace.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
            ),
          ),
          if (trailing != null)
            Text(
              trailing!,
              style: MeshTheme.mono(fontSize: 12, color: MeshPalette.ink3),
            ),
        ],
      ),
    );
  }
}

/// A list entry on a hairline: optional leading icon, title and subtitle,
/// and a trailing widget (a number, a meter, or a chevron when tappable).
class InstrumentRow extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  /// The hairline under the row; off when the row sits in its own card.
  final bool divider;

  const InstrumentRow({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.trailing,
    this.onTap,
    this.titleColor,
    this.divider = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: MeshSpace.lg,
          vertical: 11,
        ),
        decoration: divider
            ? BoxDecoration(
                border: Border(bottom: BorderSide(color: instrumentLine)),
              )
            : null,
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 19, color: MeshPalette.ink3),
              const SizedBox(width: MeshSpace.md),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor ?? MeshPalette.ink,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(
                        subtitle!,
                        style: TextStyle(color: MeshPalette.ink3, fontSize: 13),
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: MeshSpace.sm),
              trailing!,
            ] else if (onTap != null) ...[
              const SizedBox(width: MeshSpace.sm),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: MeshPalette.ink4,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// SNR as four bars and the dB value, coloured by link quality: above
/// about 5 dB is solid for LoRa, below -5 dB marginal.
class SignalReadout extends StatelessWidget {
  final double snr;
  const SignalReadout(this.snr, {super.key});

  static int barsFor(double snr) => snr >= 5
      ? 4
      : snr >= 0
      ? 3
      : snr >= -5
      ? 2
      : 1;

  @override
  Widget build(BuildContext context) {
    final bars = barsFor(snr);
    final color = MeshTheme.snrColor(snr, blocked: false);
    return Semantics(
      label: 'SNR ${snr.toStringAsFixed(1)} dB',
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < 4; i++)
            Container(
              width: 4,
              height: 6.0 + i * 3,
              margin: const EdgeInsets.only(right: 2),
              decoration: BoxDecoration(
                color: i < bars ? color : MeshPalette.line2,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          const SizedBox(width: 6),
          SizedBox(
            width: 38,
            child: Text(
              snr.toStringAsFixed(1),
              textAlign: TextAlign.end,
              style: MeshTheme.mono(fontSize: 13, color: MeshPalette.ink),
            ),
          ),
        ],
      ),
    );
  }
}

/// An outlined action, squared off rather than a pill. [danger] gives it
/// the alert colour.
class InstrumentButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool danger;

  const InstrumentButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = danger ? MeshPalette.alert : MeshPalette.ink;
    // White glass vanishes on a light ground; tint and edge it darker there.
    final dark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 18),
        label: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: false,
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          // A frosted fill, so the button reads as glass on the backdrop.
          backgroundColor: danger
              ? MeshPalette.alert.withValues(alpha: 0.14)
              : dark
              ? Colors.white.withValues(alpha: 0.07)
              : Colors.black.withValues(alpha: 0.04),
          side: BorderSide(
            color: danger
                ? MeshPalette.alert
                : dark
                ? Colors.white.withValues(alpha: 0.16)
                : MeshPalette.line3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          // A style here replaces the theme's, so the family is restated.
          textStyle: const TextStyle(
            fontFamily: MeshFonts.sans,
            fontFamilyFallback: MeshFonts.sansFallback,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
