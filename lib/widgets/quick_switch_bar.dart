import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../theme/mesh_theme.dart';
import '../utils/main_tab_navigation.dart';

/// Bastion's bottom bar: Chats, Nodes and Map switch tabs; More (tools
/// and settings) opens as a page on top.
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

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final contactsUnreadCount = connector.getTotalContactsUnreadCount();
    final channelsUnreadCount = connector.getTotalChannelsUnreadCount();
    final background = highContrast
        ? MapPalette.panelDark
        : MeshPalette.bg.withAlpha(0xF2);
    final muted = MeshPalette.ink4;
    final l10n = context.l10n;

    void handleDestination(int index) {
      final tab = MainTab.values[index];
      if (tab != current) HapticFeedback.selectionClick();
      if (onSelected != null) {
        onSelected!(tab);
      } else if (tab != current) {
        switchMainTab(context, tab, from: current);
      }
    }

    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: background,
              border: Border(
                top: BorderSide(color: MeshPalette.line, width: 1),
              ),
            ),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                labelTextStyle: WidgetStateProperty.resolveWith((states) {
                  final selected = states.contains(WidgetState.selected);
                  return TextStyle(
                    color: selected ? MeshPalette.ink : muted,
                    fontSize: 11.5,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  );
                }),
                iconTheme: WidgetStateProperty.resolveWith((states) {
                  final selected = states.contains(WidgetState.selected);
                  return IconThemeData(
                    color: selected ? MeshPalette.ink : muted,
                    size: 22,
                  );
                }),
              ),
              child: NavigationBar(
                height: 58,
                selectedIndex: current.index,
                onDestinationSelected: handleDestination,
                destinations: [
                  NavigationDestination(
                    icon: const Icon(Icons.speed_outlined),
                    selectedIcon: const Icon(Icons.speed_rounded),
                    label: l10n.nav_home,
                  ),
                  NavigationDestination(
                    icon: _buildIconWithBadge(
                      const Icon(Icons.chat_bubble_outline_rounded),
                      channelsUnreadCount,
                    ),
                    selectedIcon: _buildIconWithBadge(
                      const Icon(Icons.chat_bubble_rounded),
                      channelsUnreadCount,
                    ),
                    label: l10n.nav_chats,
                  ),
                  NavigationDestination(
                    icon: _buildIconWithBadge(
                      const Icon(Icons.cell_tower_outlined),
                      contactsUnreadCount,
                    ),
                    selectedIcon: _buildIconWithBadge(
                      const Icon(Icons.cell_tower_rounded),
                      contactsUnreadCount,
                    ),
                    label: l10n.nav_nodes,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.map_outlined),
                    selectedIcon: const Icon(Icons.map_rounded),
                    label: l10n.nav_map,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.grid_view_outlined),
                    selectedIcon: const Icon(Icons.grid_view_rounded),
                    label: l10n.nav_more,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithBadge(Icon icon, int count) {
    if (count <= 0) return icon;
    final label = count > 99 ? '99+' : '$count';
    return Badge(label: Text(label), child: icon);
  }
}
