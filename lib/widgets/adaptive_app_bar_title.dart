import '../theme/mesh_theme.dart';
import 'package:flutter/material.dart';

class AdaptiveAppBarTitle extends StatelessWidget {
  final String text;

  const AdaptiveAppBarTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final cyan = MeshPalette.accent;
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'BASTION',
              maxLines: 1,
              style: TextStyle(
                color: cyan,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.7,
              ),
            ),
            FittedBox(fit: BoxFit.scaleDown, child: Text(text, maxLines: 1)),
          ],
        ),
      ),
    );
  }
}
