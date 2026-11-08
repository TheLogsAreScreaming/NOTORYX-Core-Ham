import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../screens/licensed_operator_screen.dart';
import '../models/operator_profile.dart';
import '../services/operator_profile_service.dart';
import '../utils/station_readiness.dart';

/// Sits above every screen while a radio is connected and the licensed
/// operator setup isn't finished, so nobody talks to a ham radio without
/// seeing the coordination notice.
class OperatorSetupBanner extends StatelessWidget {
  const OperatorSetupBanner({
    super.key,
    required this.navigatorKey,
    required this.child,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final connected = context.select<MeshCoreConnector, bool>(
      (c) => c.isConnected,
    );
    final profile = context.select<OperatorProfileService, OperatorProfile>(
      (s) => s.profile,
    );
    final name = context.select<MeshCoreConnector, String?>((c) => c.selfName);
    final freqKhz = context.select<MeshCoreConnector, int?>(
      (c) => c.currentFreqHz,
    );
    if (!connected) return child;

    final message = switch (stationReadiness(
      profile,
      nodeName: name,
      freqKhz: freqKhz,
    )) {
      StationReadiness.setupIncomplete => context.l10n.ham_setupBanner,
      StationReadiness.nameMismatch => context.l10n.ham_bannerNameMismatch,
      StationReadiness.outOfBand => context.l10n.ham_bannerOutOfBand,
      StationReadiness.ready => null,
    };
    if (message == null) return child;

    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Material(
          color: scheme.errorContainer,
          child: SafeArea(
            bottom: false,
            child: InkWell(
              onTap: () => navigatorKey.currentState?.push(
                MaterialPageRoute(
                  builder: (_) => const LicensedOperatorScreen(),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: scheme.onErrorContainer,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: scheme.onErrorContainer),
                      ),
                    ),
                    Text(
                      context.l10n.ham_setUp,
                      style: TextStyle(
                        color: scheme.onErrorContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: child,
          ),
        ),
      ],
    );
  }
}
