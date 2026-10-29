import 'package:flutter/material.dart';

/// A screen title that shrinks to fit rather than wrapping when the app
/// bar is narrow.
class AdaptiveAppBarTitle extends StatelessWidget {
  final String text;

  const AdaptiveAppBarTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(text, maxLines: 1),
          ),
        ),
      ),
    );
  }
}
