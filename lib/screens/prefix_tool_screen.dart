import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/snack_bar_builder.dart';
import '../l10n/contact_localization.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/prefix_census.dart';
import '../theme/mesh_theme.dart';
import '../utils/keys.dart';
import '../widgets/connect_ui.dart';
import '../widgets/mesh_ui.dart';

/// Repeater IDs: look up who uses a path ID, see which IDs clash, and pick a
/// free one (with a matching key) for a new repeater.
class PrefixToolScreen extends StatefulWidget {
  const PrefixToolScreen({super.key});

  @override
  State<PrefixToolScreen> createState() => _PrefixToolScreenState();
}

class _PrefixToolScreenState extends State<PrefixToolScreen> {
  int? _bytes;
  bool _includeCompanions = false;
  String _query = '';
  int _shuffle = 0;

  /// Free-ID suggestions, kept until the inputs change or the user asks for
  /// more, so they don't reshuffle on every keystroke.
  List<String> _suggestions = const [];
  String? _suggestionsFor;

  List<String> _freeSuggestions(PrefixCensus census) {
    final key =
        '${census.bytes}|$_includeCompanions|$_shuffle|'
        '${census.byPrefix.length}';
    if (key != _suggestionsFor) {
      _suggestionsFor = key;
      _suggestions = census.suggestFree(12);
    }
    return _suggestions;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final connector = context.watch<MeshCoreConnector>();
    final bytes =
        _bytes ??
        (connector.isConnected ? connector.pathHashByteWidth.clamp(1, 3) : 1);
    final census = PrefixCensus.build(
      connector.allContactsUnfiltered,
      bytes: bytes,
      includeCompanions: _includeCompanions,
    );
    final query = normalizePrefixQuery(_query);
    final matches = census.lookup(query);
    final collisions = census.collisions;
    final suggestions = _freeSuggestions(census);
    final freeCount = bytes == 1
        ? census.freeOneByte.length
        : census.space - census.byPrefix.length;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.prefixTool_title)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            children: [
              ConsolePanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.prefixTool_width,
                      style: TextStyle(
                        color: MeshPalette.ink2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<int>(
                      segments: [
                        for (final b in const [1, 2, 3])
                          ButtonSegment(
                            value: b,
                            label: Text(l10n.prefixTool_widthBytes(b)),
                          ),
                      ],
                      selected: {bytes},
                      onSelectionChanged: (s) =>
                          setState(() => _bytes = s.first),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.prefixTool_includeCompanions,
                            style: TextStyle(color: MeshPalette.ink2),
                          ),
                        ),
                        Switch(
                          value: _includeCompanions,
                          onChanged: (v) =>
                              setState(() => _includeCompanions = v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.prefixTool_summary(
                        census.nodeCount,
                        census.byPrefix.length,
                        collisions.length,
                      ),
                      key: const ValueKey('prefix-summary'),
                      style: TextStyle(
                        color: MeshPalette.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.prefixTool_freeOfSpace(freeCount, census.space),
                      style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              TextField(
                key: const ValueKey('prefix-lookup'),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: l10n.prefixTool_lookupHint,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9a-fA-F]')),
                  LengthLimitingTextInputFormatter(6),
                ],
                textCapitalization: TextCapitalization.characters,
                onChanged: (v) => setState(() => _query = v),
              ),
              if (query.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  matches.isEmpty
                      ? l10n.prefixTool_lookupFree(query)
                      : l10n.prefixTool_lookupUsed(matches.length, query),
                  key: const ValueKey('prefix-lookup-result'),
                  style: TextStyle(
                    color: matches.isEmpty
                        ? MeshPalette.signal
                        : MeshPalette.warn,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                for (final c in matches) _NodeRow(contact: c, bytes: bytes),
                if (matches.isEmpty && query.length <= 4)
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton.icon(
                      onPressed: () => showKeyGeneratorSheet(context, query),
                      icon: const Icon(Icons.key),
                      label: Text(l10n.prefixTool_makeKey),
                    ),
                  ),
              ],
              const SizedBox(height: 22),
              ConsoleKicker(
                l10n.prefixTool_shared,
                trailing: Text(
                  '${collisions.length}',
                  style: MeshTheme.mono(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: MeshPalette.ink3,
                  ),
                ),
              ),
              if (collisions.isEmpty)
                Text(
                  l10n.prefixTool_noShared,
                  style: TextStyle(color: MeshPalette.ink3),
                )
              else ...[
                Text(
                  l10n.prefixTool_sharedHint,
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
                ),
                const SizedBox(height: 8),
                for (final e in collisions.take(30))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ConsolePanel(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _IdChip(id: e.key, color: MeshPalette.warn),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              e.value.map((c) => c.name).join('\n'),
                              style: TextStyle(color: MeshPalette.ink2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
              const SizedBox(height: 22),
              ConsoleKicker(
                l10n.prefixTool_free,
                trailing: TextButton(
                  onPressed: () => setState(() => _shuffle++),
                  child: Text(l10n.prefixTool_shuffle),
                ),
              ),
              Wrap(
                key: ValueKey('free-$_shuffle'),
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final id in suggestions)
                    ActionChip(
                      label: Text(
                        id,
                        style: MeshTheme.mono(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: MeshPalette.signal,
                        ),
                      ),
                      tooltip: l10n.prefixTool_makeKey,
                      onPressed: () => showKeyGeneratorSheet(
                        context,
                        id.substring(0, id.length.clamp(0, 4)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                l10n.prefixTool_onlyKnown,
                style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IdChip extends StatelessWidget {
  const _IdChip({required this.id, required this.color});

  final String id;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        id,
        style: MeshTheme.mono(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _NodeRow extends StatelessWidget {
  const _NodeRow({required this.contact, required this.bytes});

  final Contact contact;
  final int bytes;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ConsolePanel(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _IdChip(
              id: keyPrefixHex(contact.publicKey, bytes),
              color: MeshPalette.accent,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: TextStyle(
                      color: MeshPalette.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    contact.typeLabel(l10n),
                    style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Searches for a key whose public key starts with [prefix] (up to 4 hex
/// characters) and shows it with copy buttons.
Future<void> showKeyGeneratorSheet(BuildContext context, String prefix) =>
    showMeshSheet<void>(
      context,
      builder: (_) => _KeyGeneratorSheet(prefix: normalizePrefixQuery(prefix)),
    );

class _KeyGeneratorSheet extends StatefulWidget {
  const _KeyGeneratorSheet({required this.prefix});

  final String prefix;

  @override
  State<_KeyGeneratorSheet> createState() => _KeyGeneratorSheetState();
}

class _KeyGeneratorSheetState extends State<_KeyGeneratorSheet> {
  int _tries = 0;
  MCKeyPair? _keys;
  bool _cancelled = false;
  bool _showPrivate = false;

  @override
  void initState() {
    super.initState();
    unawaited(_search());
  }

  @override
  void dispose() {
    _cancelled = true;
    super.dispose();
  }

  Future<void> _search() async {
    setState(() {
      _keys = null;
      _tries = 0;
      _showPrivate = false;
    });
    final target = widget.prefix;
    while (!_cancelled) {
      final keys = await generateKeyPair();
      _tries++;
      if (normalizePrefixQuery(pubKeyToHex(keys.public)).startsWith(target)) {
        if (mounted) setState(() => _keys = keys);
        return;
      }
      if (_tries % 64 == 0) {
        // Let the progress text redraw and taps get through.
        await Future<void>.delayed(Duration.zero);
        if (mounted) setState(() {});
      }
    }
  }

  void _copy(String text) {
    unawaited(Clipboard.setData(ClipboardData(text: text)));
    showDismissibleSnackBar(context, content: Text(context.l10n.keyGen_copied));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final keys = _keys;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomSheetHeader(title: l10n.keyGen_title(widget.prefix)),
            if (keys == null) ...[
              Row(
                children: [
                  const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.keyGen_searching(_tries),
                      key: const ValueKey('keygen-progress'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.common_cancel),
              ),
            ] else ...[
              _KeyField(
                label: l10n.keyGen_publicKey,
                value: pubKeyToHex(keys.public).toUpperCase(),
                onCopy: _copy,
              ),
              const SizedBox(height: 12),
              _KeyField(
                label: l10n.keyGen_privateKey,
                value: pubKeyToHex(keys.private),
                obscured: !_showPrivate,
                onReveal: () => setState(() => _showPrivate = !_showPrivate),
                onCopy: _copy,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.keyGen_secretWarning,
                style: TextStyle(
                  color: MeshPalette.warn,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.keyGen_howToUse,
                style: TextStyle(color: MeshPalette.ink2, fontSize: 13),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () => unawaited(_search()),
                icon: const Icon(Icons.refresh),
                label: Text(l10n.keyGen_tryAgain),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _KeyField extends StatelessWidget {
  const _KeyField({
    required this.label,
    required this.value,
    required this.onCopy,
    this.obscured = false,
    this.onReveal,
  });

  final String label;
  final String value;
  final bool obscured;
  final VoidCallback? onReveal;
  final void Function(String) onCopy;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ConsolePanel(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    color: MeshPalette.ink3,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                SelectableText(
                  obscured ? '•' * 24 : value,
                  style: MeshTheme.mono(fontSize: 12, color: MeshPalette.ink),
                ),
              ],
            ),
          ),
          if (onReveal != null)
            IconButton(
              onPressed: onReveal,
              icon: Icon(obscured ? Icons.visibility : Icons.visibility_off),
            ),
          IconButton(
            tooltip: l10n.keyGen_copy,
            onPressed: () => onCopy(value),
            icon: const Icon(Icons.copy),
          ),
        ],
      ),
    );
  }
}
