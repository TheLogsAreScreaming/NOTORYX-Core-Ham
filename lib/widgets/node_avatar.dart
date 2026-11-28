import 'package:flutter/material.dart';

import '../services/node_look_store.dart';
import 'mesh_ui.dart';

/// A node's avatar: the photo picked for it, else an initials circle in the
/// colour picked for it, else [fallback] (or plain initials).
class NodeAvatar extends StatelessWidget {
  const NodeAvatar({
    super.key,
    required this.nodeKey,
    required this.name,
    this.size = 40,
    this.icon,
    this.fallback,
    this.store,
  });

  final String nodeKey;
  final String name;
  final double size;

  /// Shown instead of initials when only a colour was picked.
  final IconData? icon;

  /// What to show when nothing was picked; an initials circle when null.
  final Widget? fallback;

  /// Defaults to [NodeLookStore.instance].
  final NodeLookStore? store;

  @override
  Widget build(BuildContext context) {
    final looks = store ?? NodeLookStore.instance;
    return ListenableBuilder(
      listenable: looks,
      builder: (context, _) {
        final look = looks.lookFor(nodeKey);
        final photo = look?.photo;
        if (photo != null && photo.isNotEmpty) {
          return ExcludeSemantics(
            child: ClipOval(
              child: Image.memory(
                photo,
                width: size,
                height: size,
                fit: BoxFit.cover,
                gaplessPlayback: true,
                errorBuilder: (_, _, _) =>
                    AvatarCircle(name: name, size: size, icon: icon),
              ),
            ),
          );
        }
        final colorValue = look?.colorValue;
        if (colorValue != null) {
          return ExcludeSemantics(
            child: AvatarCircle(
              name: name,
              size: size,
              icon: icon,
              color: Color(colorValue),
            ),
          );
        }
        return fallback ??
            ExcludeSemantics(
              child: AvatarCircle(name: name, size: size, icon: icon),
            );
      },
    );
  }
}
