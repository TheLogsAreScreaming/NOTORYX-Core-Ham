import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/contact_localization.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../services/trace_pinger.dart';
import '../theme/mesh_theme.dart';
import '../widgets/instrument.dart';
import '../widgets/ember_backdrop.dart';
import 'repeater_ping_screen.dart';

/// How long between clicks for an SNR: about 1.5 s when barely heard,
/// down to about 0.12 s when it's strong, like a metal detector.
Duration clickIntervalFor(double snr) {
  final t = ((snr + 15) / 27).clamp(0.0, 1.0);
  return Duration(milliseconds: (1500 - t * 1380).round());
}

/// Antenna hunt: probes one repeater over and over and shows how well this
/// radio hears it in very large digits, clicking faster as it improves, so
/// you can turn an antenna or walk around without staring at the screen.
class AntennaHuntScreen extends StatefulWidget {
  const AntennaHuntScreen({super.key, this.pinger});

  final TracePinger? pinger;

  @override
  State<AntennaHuntScreen> createState() => _AntennaHuntScreenState();
}

class _AntennaHuntScreenState extends State<AntennaHuntScreen> {
  late final TracePinger _pinger =
      widget.pinger ?? TracePinger(context.read<MeshCoreConnector>());
  Contact? _target;
  bool _hunting = false;
  bool _sound = true;
  PingResult? _last;
  double? _best;
  int _misses = 0;
  Timer? _clicks;

  Future<void> _loop() async {
    while (_hunting && mounted) {
      final target = _target;
      if (target == null) break;
      final result = await _pinger.ping(
        target.publicKey,
        timeout: const Duration(seconds: 5),
      );
      if (!mounted || !_hunting) break;
      setState(() {
        if (result == null) {
          _misses++;
        } else {
          _misses = 0;
          _last = result;
          if (_best == null || result.snrBack > _best!) _best = result.snrBack;
        }
      });
      _retune();
      await Future<void>.delayed(const Duration(milliseconds: 600));
    }
  }

  void _retune() {
    _clicks?.cancel();
    final last = _last;
    // Two misses in a row: silence rather than a stale rhythm.
    if (!_hunting || !_sound || last == null || _misses >= 2) return;
    _clicks = Timer.periodic(clickIntervalFor(last.snrBack), (_) {
      SystemSound.play(SystemSoundType.click);
      HapticFeedback.selectionClick();
    });
  }

  void _toggle() {
    setState(() {
      _hunting = !_hunting;
      if (_hunting) {
        _misses = 0;
        _best = null;
      }
    });
    if (_hunting) {
      unawaited(_loop());
    } else {
      _clicks?.cancel();
    }
  }

  @override
  void dispose() {
    _hunting = false;
    _clicks?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final online = context.watch<MeshCoreConnector>().isConnected;
    final last = _last;
    final stale = _misses >= 2;
    final snr = last?.snrBack;
    final color = snr == null || stale
        ? MeshPalette.ink4
        : MeshTheme.snrColor(snr, blocked: false);
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(l10n.hunt_title),
        ),
        body: ListView(
          children: [
            InstrumentRow(
              icon: Icons.cell_tower_rounded,
              title: _target?.name ?? l10n.ping_choose,
              subtitle: _target?.pathLabel(l10n),
              onTap: _hunting
                  ? null
                  : () async {
                      final picked = await pickRepeater(context);
                      if (picked != null && mounted) {
                        setState(() {
                          _target = picked;
                          _last = null;
                          _best = null;
                        });
                      }
                    },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: MeshSpace.xl),
              child: Column(
                children: [
                  Semantics(
                    liveRegion: true,
                    label: snr == null
                        ? l10n.hunt_noSignal
                        : 'SNR ${snr.toStringAsFixed(1)} dB',
                    excludeSemantics: true,
                    child: Text(
                      snr == null ? '—' : snr.toStringAsFixed(1),
                      style: MeshTheme.mono(
                        fontSize: 88,
                        fontWeight: FontWeight.w500,
                        color: color,
                      ),
                    ),
                  ),
                  Text(
                    stale ? l10n.hunt_noReply : l10n.hunt_heardHere,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: MeshPalette.ink3),
                  ),
                ],
              ),
            ),
            ReadoutStrip([
              Readout(
                last == null ? '—' : last.snrThere.toStringAsFixed(1),
                l10n.ping_snrThere,
              ),
              Readout(
                _best == null ? '—' : _best!.toStringAsFixed(1),
                l10n.hunt_best,
              ),
              Readout(
                last == null ? '—' : '${last.roundTrip.inMilliseconds}',
                l10n.ping_avgMs,
              ),
            ]),
            SwitchListTile(
              title: Text(l10n.hunt_sound),
              subtitle: Text(l10n.hunt_soundHint),
              value: _sound,
              onChanged: (v) {
                setState(() => _sound = v);
                _retune();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(MeshSpace.lg),
              child: InstrumentButton(
                label: _hunting ? l10n.hunt_stop : l10n.hunt_start,
                icon: _hunting ? Icons.stop_rounded : Icons.track_changes,
                danger: _hunting,
                onPressed: _target == null || !online ? null : _toggle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
              child: Text(
                l10n.hunt_explainer,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: MeshPalette.ink3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
