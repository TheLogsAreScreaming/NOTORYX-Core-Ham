import 'package:flutter/material.dart';

/// The NOTORYX app icon, drawn in-app as a rounded tile.
///
/// Decorative: it always sits next to the NOTORYX name, so screen readers
/// skip it.
class NotoryxLogo extends StatelessWidget {
  const NotoryxLogo({super.key, this.size = 48});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.22),
        child: Image.asset(
          'assets/images/notoryx_logo.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.medium,
        ),
      ),
    );
  }
}
