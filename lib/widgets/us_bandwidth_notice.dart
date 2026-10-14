import 'package:flutter/material.dart';

/// Informational only: never modifies settings or blocks a save.
class UsBandwidthNotice extends StatelessWidget {
  const UsBandwidthNotice({super.key, required this.bandwidthHz});

  final int bandwidthHz;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        '${bandwidthHz < 500000 ? 'For US operation in 902–928 MHz, FCC 47 CFR '
                  '15.247(a)(2) specifies a minimum measured 6 dB bandwidth of '
                  '500 kHz for systems using digital modulation. This notice does '
                  'not determine whether your setup is legal. Check your radio’s '
                  'certification and applicable operating rules.\n\n' : ''}'
        'Radios using different bandwidths cannot hear each other. '
        'Coordinate frequency, bandwidth, spreading factor and coding rate '
        'with your local mesh before changing settings.',
      ),
    ),
  );
}
