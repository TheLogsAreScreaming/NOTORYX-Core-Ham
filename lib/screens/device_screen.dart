import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../utils/dialog_utils.dart';
import '../utils/disconnect_navigation_mixin.dart';
import '../utils/route_transitions.dart';
import '../widgets/quick_switch_bar.dart';
import '../widgets/battery_indicator_chip.dart';
import '../widgets/radio_stats_entry.dart';
import 'channels_screen.dart';
import 'contacts_screen.dart';
import 'map_screen.dart';
import 'settings_screen.dart';

/// Main hub screen after connecting to a MeshCore device
class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen>
    with DisconnectNavigationMixin {
  bool _showBatteryVoltage = false;
  int _quickIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<MeshCoreConnector>(
      builder: (context, connector, child) {
        // Auto-navigate back to scanner if disconnected
        if (!checkConnectionAndNavigate(connector)) {
          return const SizedBox.shrink();
        }

        final theme = Theme.of(context);

        return PopScope(
          canPop: false,
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 128,
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BatteryIndicatorChip(
                    connector: connector,
                    showVoltage: _showBatteryVoltage,
                    onPressed: () {
                      setState(() {
                        _showBatteryVoltage = !_showBatteryVoltage;
                      });
                    },
                  ),
                  const RadioStatsIconButton(),
                ],
              ),
              titleSpacing: 16,
              centerTitle: false,
              title: _buildAppBarTitle(connector, theme),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.bluetooth_disabled),
                  tooltip: context.l10n.common_disconnect,
                  onPressed: () => _disconnect(context, connector),
                ),
                IconButton(
                  icon: const Icon(Icons.tune),
                  tooltip: context.l10n.common_settings,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                children: [
                  _buildConnectionCard(connector, context),
                  const SizedBox(height: 16),
                  _buildSectionLabel(theme, context.l10n.device_quickSwitch),
                  const SizedBox(height: 12),
                  _buildQuickSwitchBar(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBarTitle(MeshCoreConnector connector, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.device_meshcore,
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          connector.deviceDisplayName,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(ThemeData theme, String text) {
    return Text(
      text,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildConnectionCard(
    MeshCoreConnector connector,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(
                    Icons.wifi_tethering_rounded,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        connector.deviceDisplayName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        connector.deviceIdLabel,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Chip(
                  avatar: Icon(
                    Icons.check_circle,
                    size: 18,
                    color: colorScheme.onSecondaryContainer,
                  ),
                  label: Text(context.l10n.common_connected),
                  backgroundColor: colorScheme.secondaryContainer,
                  labelStyle: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                BatteryIndicatorChip(
                  connector: connector,
                  showVoltage: _showBatteryVoltage,
                  onPressed: () {
                    setState(() {
                      _showBatteryVoltage = !_showBatteryVoltage;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickSwitchBar(BuildContext context) {
    return QuickSwitchBar(
      selectedIndex: _quickIndex,
      onDestinationSelected: (index) {
        _openQuickDestination(index, context);
      },
    );
  }

  void _openQuickDestination(int index, BuildContext context) {
    if (_quickIndex != index) {
      setState(() {
        _quickIndex = index;
      });
    }
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          buildQuickSwitchRoute(const ContactsScreen(hideBackButton: true)),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          buildQuickSwitchRoute(const ChannelsScreen(hideBackButton: true)),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          buildQuickSwitchRoute(const MapScreen(hideBackButton: true)),
        );
        break;
    }
  }

  Future<void> _disconnect(
    BuildContext context,
    MeshCoreConnector connector,
  ) async {
    await showDisconnectDialog(context, connector);
  }
}
