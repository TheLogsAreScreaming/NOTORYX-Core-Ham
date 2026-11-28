import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../l10n/l10n.dart';
import '../services/node_look_store.dart';
import '../theme/mesh_theme.dart';
import 'mesh_ui.dart';
import 'node_avatar.dart';

/// Lets someone pick a colour or a photo for one node, or go back to the
/// default look.
Future<void> showNodeLookSheet(
  BuildContext context, {
  required String nodeKey,
  required String name,
  NodeLookStore? store,
}) {
  final looks = store ?? NodeLookStore.instance;
  return showMeshSheet<void>(
    context,
    builder: (sheet) =>
        _NodeLookSheet(nodeKey: nodeKey, name: name, looks: looks),
  );
}

class _NodeLookSheet extends StatefulWidget {
  const _NodeLookSheet({
    required this.nodeKey,
    required this.name,
    required this.looks,
  });

  final String nodeKey;
  final String name;
  final NodeLookStore looks;

  @override
  State<_NodeLookSheet> createState() => _NodeLookSheetState();
}

class _NodeLookSheetState extends State<_NodeLookSheet> {
  bool _busy = false;

  Future<void> _pickPhoto() async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final failed = context.l10n.nodeLook_photoFailed;
    setState(() => _busy = true);
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: NodeLookStore.photoSize.toDouble(),
        maxHeight: NodeLookStore.photoSize.toDouble(),
        imageQuality: 80,
      );
      if (picked == null) return;
      final bytes = await shrinkNodePhoto(await picked.readAsBytes());
      if (bytes == null) {
        messenger?.showSnackBar(SnackBar(content: Text(failed)));
        return;
      }
      await widget.looks.setPhoto(widget.nodeKey, bytes);
    } on Exception catch (e, st) {
      debugPrint('Node photo failed: $e\n$st');
      messenger?.showSnackBar(SnackBar(content: Text(failed)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: ListenableBuilder(
        listenable: widget.looks,
        builder: (context, _) {
          final look = widget.looks.lookFor(widget.nodeKey);
          final hasPhoto = look?.photo != null;
          return SingleChildScrollView(
            child: Column(
              key: const ValueKey('node-look-sheet'),
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BottomSheetHeader(
                  title: l10n.nodeLook_title(widget.name),
                  subtitle: l10n.nodeLook_hint,
                  trailing: NodeAvatar(
                    nodeKey: widget.nodeKey,
                    name: widget.name,
                    size: 44,
                    store: widget.looks,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MeshSpace.lg,
                    vertical: MeshSpace.sm,
                  ),
                  child: Wrap(
                    spacing: MeshSpace.md,
                    runSpacing: MeshSpace.md,
                    children: [
                      for (final (i, color) in NodeLookPalette.colors.indexed)
                        _Swatch(
                          color: color,
                          label: l10n.nodeLook_colorN(i + 1),
                          selected: look?.colorValue == color.toARGB32(),
                          onTap: () => unawaited(
                            widget.looks.setColor(
                              widget.nodeKey,
                              color.toARGB32(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: Text(l10n.nodeLook_choosePhoto),
                  trailing: _busy
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : null,
                  onTap: _busy ? null : () => unawaited(_pickPhoto()),
                ),
                if (hasPhoto)
                  ListTile(
                    leading: const Icon(Icons.hide_image_outlined),
                    title: Text(l10n.nodeLook_removePhoto),
                    onTap: () =>
                        unawaited(widget.looks.setPhoto(widget.nodeKey, null)),
                  ),
                if (look != null)
                  ListTile(
                    leading: const Icon(Icons.restart_alt),
                    title: Text(l10n.nodeLook_clear),
                    onTap: () => unawaited(widget.looks.clear(widget.nodeKey)),
                  ),
                const SizedBox(height: MeshSpace.sm),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.color,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final check = MeshPalette.readable(MeshPalette.bg, color);
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: ExcludeSemantics(
        child: InkResponse(
          onTap: onTap,
          radius: 26,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? MeshPalette.ink : MeshPalette.line2,
                width: selected ? 3 : 1,
              ),
            ),
            child: selected ? Icon(Icons.check, color: check) : null,
          ),
        ),
      ),
    );
  }
}

/// Makes [bytes] small enough to keep: returned as is when already under
/// [NodeLookStore.maxPhotoBytes], else re-drawn as a 160-pixel PNG. Null if
/// it can't be decoded or is still too big.
Future<Uint8List?> shrinkNodePhoto(Uint8List bytes) async {
  if (bytes.isEmpty) return null;
  if (bytes.length <= NodeLookStore.maxPhotoBytes) return bytes;
  try {
    final codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: 160,
      targetHeight: 160,
    );
    final frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    frame.image.dispose();
    codec.dispose();
    if (data == null) return null;
    final out = data.buffer.asUint8List();
    return out.length <= NodeLookStore.maxPhotoBytes ? out : null;
  } on Exception catch (e, st) {
    debugPrint('Could not shrink node photo: $e\n$st');
    return null;
  }
}
