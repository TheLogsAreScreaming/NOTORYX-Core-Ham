import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/contact.dart';
import '../models/path_selection.dart';
import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../services/repeater_command_service.dart';
import '../widgets/path_management_dialog.dart';
import '../helpers/cayenne_lpp.dart';

class TelemetryScreen extends StatefulWidget {
  final Contact repeater;
  final String password;

  const TelemetryScreen({
    super.key,
    required this.repeater,
    required this.password,
  });

  @override
  State<TelemetryScreen> createState() => _TelemetryScreenState();
}

class _TelemetryScreenState extends State<TelemetryScreen> {
  static const int _statusPayloadOffset = 8;
  static const int _statusStatsSize = 52;
  static const int _statusResponseBytes = _statusPayloadOffset + _statusStatsSize;
  Uint8List _tagData = Uint8List(4);
  int _timeEstment = 0;

  bool _isLoading = false;
  Timer? _statusTimeout;
  StreamSubscription<Uint8List>? _frameSubscription;
  RepeaterCommandService? _commandService;
  PathSelection? _pendingStatusSelection;

  @override
  void initState() {
    super.initState();
    final connector = Provider.of<MeshCoreConnector>(context, listen: false);
    _commandService = RepeaterCommandService(connector);
    _setupMessageListener();
    _loadTelemetry();
  }

  void _setupMessageListener() {
    final connector = Provider.of<MeshCoreConnector>(context, listen: false);

    // Listen for incoming text messages from the repeater
    _frameSubscription = connector.receivedFrames.listen((frame) {
      if (frame.isEmpty) return;

    if(frame[0] == respCodeSent){
      _tagData = frame.sublist(2, 6);
      _timeEstment = frame.buffer.asByteData().getUint32(6, Endian.little);
    }

    // Check if it's a binary response
    if (frame[0] == pushCodeBinaryResponse && listEquals(frame.sublist(2, 6), _tagData)) {
      _handleStatusResponse(context, frame.sublist(6));
    }
  });
}

  void _handleStatusResponse(BuildContext context, Uint8List frame) {

    final parsedTelemetry = CayenneLpp.parse(frame);
    for (final entry in parsedTelemetry) {
      print('Telemetry - Channel: ${entry['channel']}, Type: ${entry['type']}, Value: ${entry['value']}');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Received status response (not implemented).'),
        backgroundColor: Colors.green,
      )
    );
    _statusTimeout?.cancel();
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  Contact _resolveRepeater(MeshCoreConnector connector) {
    return connector.contacts.firstWhere(
      (c) => c.publicKeyHex == widget.repeater.publicKeyHex,
      orElse: () => widget.repeater,
    );
  }

  Future<void> _loadTelemetry() async {
    if (_commandService == null) return;

    setState(() {
      _isLoading = true;
    });
    try {
      final connector = Provider.of<MeshCoreConnector>(context, listen: false);
      final repeater = _resolveRepeater(connector);
      final selection = await connector.preparePathForContactSend(repeater);
      _pendingStatusSelection = selection;
      final frame = buildSendBinaryReq(repeater.publicKey, payload: Uint8List.fromList([reqTypeGetTelemetry]));
      await connector.sendFrame(frame);

      final pathLengthValue = selection.useFlood ? -1 : selection.hopCount;
      final messageBytes = frame.length >= _statusResponseBytes
          ? frame.length
          : _statusResponseBytes;
      final timeoutMs = connector.calculateTimeout(
        pathLength: pathLengthValue,
        messageBytes: messageBytes,
      );
      _statusTimeout?.cancel();
      _statusTimeout = Timer(Duration(milliseconds: timeoutMs), () {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Status request timed out.'),
            backgroundColor: Colors.red,
          ),
        );
        _recordStatusResult(false);
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading status: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _recordStatusResult(bool success) {
    final selection = _pendingStatusSelection;
    if (selection == null) return;
    final connector = Provider.of<MeshCoreConnector>(context, listen: false);
    final repeater = _resolveRepeater(connector);
    connector.recordRepeaterPathResult(repeater, selection, success, null);
    _pendingStatusSelection = null;
  }

  @override
  void dispose() {
    _frameSubscription?.cancel();
    _commandService?.dispose();
    _statusTimeout?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final repeater = _resolveRepeater(connector);
    final isFloodMode = repeater.pathOverride == -1;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Repeater Status'),
            Text(
              repeater.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(isFloodMode ? Icons.waves : Icons.route),
            tooltip: 'Routing mode',
            onSelected: (mode) async {
              if (mode == 'flood') {
                await connector.setPathOverride(repeater, pathLen: -1);
              } else {
                await connector.setPathOverride(repeater, pathLen: null);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'auto',
                child: Row(
                  children: [
                    Icon(Icons.auto_mode, size: 20, color: !isFloodMode ? Theme.of(context).primaryColor : null),
                    const SizedBox(width: 8),
                    Text(
                      'Auto (use saved path)',
                      style: TextStyle(
                        fontWeight: !isFloodMode ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'flood',
                child: Row(
                  children: [
                    Icon(Icons.waves, size: 20, color: isFloodMode ? Theme.of(context).primaryColor : null),
                    const SizedBox(width: 8),
                    Text(
                      'Force Flood Mode',
                      style: TextStyle(
                        fontWeight: isFloodMode ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.timeline),
            tooltip: 'Path management',
            onPressed: () => PathManagementDialog.show(context, contact: repeater),
          ),
          IconButton(
            icon: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadTelemetry,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: _loadTelemetry,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text("Not implemented yet", style: Theme.of(context).textTheme.bodyMedium),
              //_buildSystemInfoCard(),
              //const SizedBox(height: 16),
              //_buildRadioStatsCard(),
              //const SizedBox(height: 16),
              //_buildPacketStatsCard(),
            ],
          ),
        ),
      ),
    );
  }
}