import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../theme/mesh_theme.dart';

/// Runs a command on the companion CLI and returns its reply.
typedef CliRunner = Future<String> Function(String command);

/// A text command line for the connected companion radio (firmware v14+).
class CompanionCliScreen extends StatefulWidget {
  /// Overrides the connector's CLI; for tests.
  final CliRunner? run;

  const CompanionCliScreen({super.key, this.run});

  @override
  State<CompanionCliScreen> createState() => _CompanionCliScreenState();
}

class _Exchange {
  final String command;
  String? reply;
  bool failed = false;

  _Exchange(this.command);
}

class _CompanionCliScreenState extends State<CompanionCliScreen> {
  /// Read-only commands that are safe to tap.
  static const _quickCommands = [
    'ver',
    'board',
    'get name',
    'get tz.offset',
    'get wifi.status',
  ];

  final _controller = TextEditingController();
  final _focus = FocusNode();
  final _scroll = ScrollController();
  final List<_Exchange> _history = [];
  bool _running = false;

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _run(String command) async {
    final text = command.trim();
    if (text.isEmpty || _running) return;
    final run = widget.run ?? context.read<MeshCoreConnector>().runCliCommand;
    final exchange = _Exchange(text);
    setState(() {
      _history.add(exchange);
      _running = true;
    });
    _controller.clear();
    _scrollToEnd();
    try {
      final reply = await run(text);
      exchange.reply = reply.trim();
    } on TimeoutException {
      exchange.failed = true;
    } catch (e) {
      exchange
        ..failed = true
        ..reply = '$e';
    } finally {
      if (mounted) {
        setState(() => _running = false);
        _scrollToEnd();
        _focus.requestFocus();
      }
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.jumpTo(_scroll.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final mono = MeshTheme.mono(fontSize: 14, color: scheme.onSurface);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.companionCli_title)),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning_amber_rounded, color: MeshPalette.warn),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.companionCli_warning,
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final c in _quickCommands)
                    ActionChip(
                      label: Text(c, style: MeshTheme.mono(fontSize: 13)),
                      onPressed: _running ? null : () => _run(c),
                    ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: _history.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          l10n.companionCli_empty,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: scheme.onSurfaceVariant),
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _scroll,
                      padding: const EdgeInsets.all(16),
                      itemCount: _history.length,
                      itemBuilder: (context, i) {
                        final e = _history[i];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                '\$ ${e.command}',
                                style: mono.copyWith(color: scheme.primary),
                              ),
                              const SizedBox(height: 4),
                              if (e.reply == null && !e.failed)
                                const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              else
                                SelectableText(
                                  e.failed && e.reply == null
                                      ? l10n.companionCli_noReply
                                      : e.reply!,
                                  style: mono.copyWith(
                                    color: e.failed ? scheme.error : null,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focus,
                      autocorrect: false,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.send,
                      style: mono,
                      decoration: InputDecoration(
                        hintText: l10n.companionCli_hint,
                      ),
                      onSubmitted: _run,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    tooltip: l10n.companionCli_send,
                    style: IconButton.styleFrom(
                      minimumSize: const Size(48, 48),
                    ),
                    onPressed: _running ? null : () => _run(_controller.text),
                    icon: const Icon(Icons.keyboard_return),
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
