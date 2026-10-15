import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../theme/mesh_theme.dart';
import '../utils/main_tab_navigation.dart';

class QuickSwitchBar extends StatelessWidget {
  /// The tab whose screen hosts this bar.
  final MainTab current;

  /// Called instead of the default tab switch, for screens that are not a
  /// tab themselves (the line-of-sight map pops back to the map).
  final ValueChanged<MainTab>? onSelected;
  final bool highContrast;

  const QuickSwitchBar({
    super.key,
    required this.current,
    this.onSelected,
    this.highContrast = false,
  });

  void _select(BuildContext context, MainTab tab) {
    if (onSelected != null) {
      onSelected!(tab);
    } else if (tab != current) {
      switchMainTab(context, tab);
    }
  }

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final messagesUnread =
        connector.getTotalContactsUnreadCount() +
        connector.getTotalChannelsUnreadCount();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final labelStyle = theme.textTheme.labelMedium ?? const TextStyle();
    final background = highContrast ? MapPalette.panelDark : Colors.transparent;
    // The selected icon sits on the primary indicator pill, so it uses
    // onPrimary. The label sits below on the bar background, so it must use a
    // foreground color that contrasts with the surface (not onPrimary, which
    // is white-on-white in the light theme).
    final selectedIconColor = highContrast
        ? MapPalette.textPrimary
        : colorScheme.onPrimary;
    final selectedLabelColor = highContrast
        ? MapPalette.textPrimary
        : colorScheme.onSurface;
    final unselectedColor = highContrast
        ? MapPalette.textSecondary
        : colorScheme.onSurfaceVariant;
    final indicator = highContrast ? MapPalette.selected : colorScheme.primary;

    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: background,
              border: Border.all(
                color: highContrast
                    ? MapPalette.border
                    : colorScheme.outlineVariant.withValues(alpha: 0.4),
              ),
            ),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                indicatorColor: indicator,
                labelTextStyle: WidgetStateProperty.resolveWith((states) {
                  final isSelected = states.contains(WidgetState.selected);
                  return labelStyle.copyWith(
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? selectedLabelColor : unselectedColor,
                  );
                }),
                iconTheme: WidgetStateProperty.resolveWith((states) {
                  final isSelected = states.contains(WidgetState.selected);
                  return IconThemeData(
                    color: isSelected ? selectedIconColor : unselectedColor,
                  );
                }),
              ),
              child: NavigationBar(
                height: 60,
                selectedIndex: current.index,
                onDestinationSelected: (index) =>
                    _select(context, MainTab.values[index]),
                destinations: [
                  NavigationDestination(
                    icon: _buildIconWithBadge(
                      context,
                      const Icon(Icons.chat_bubble_outline),
                      messagesUnread,
                    ),
                    selectedIcon: _buildIconWithBadge(
                      context,
                      const Icon(Icons.chat_bubble),
                      messagesUnread,
                    ),
                    label: context.l10n.nav_messages,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.hub_outlined),
                    selectedIcon: const Icon(Icons.hub),
                    label: context.l10n.nav_nodes,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.map_outlined),
                    selectedIcon: const Icon(Icons.map),
                    label: context.l10n.nav_map,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.settings_input_antenna_outlined),
                    selectedIcon: const Icon(Icons.settings_input_antenna),
                    label: context.l10n.nav_radio,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithBadge(BuildContext context, Icon icon, int count) {
    if (count <= 0) return icon;
    final label = count > 99 ? '99+' : '$count';
    return Badge(label: Text(label), child: icon);
  }
}
