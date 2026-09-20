import 'dart:ui';

import 'package:flutter/material.dart';

import '../screens/bastion_tools_screen.dart';
import '../screens/settings_screen.dart';
import '../theme/mesh_theme.dart';

class QuickSwitchBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final int contactsUnreadCount;
  final int channelsUnreadCount;
  final bool highContrast;

  const QuickSwitchBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.contactsUnreadCount = 0,
    this.channelsUnreadCount = 0,
    this.highContrast = false,
  });

  @override
  Widget build(BuildContext context) {
    final background = highContrast
        ? MapPalette.panelDark
        : const Color(0xF20B0E11);
    const cyan = Color(0xFF18D3D3);
    const muted = Color(0xFF9AA6AF);

    void handleDestination(int index) {
      if (index <= 2) {
        onDestinationSelected(index);
        return;
      }
      if (index == 3) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const BastionToolsScreen()),
        );
        return;
      }
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SettingsScreen()),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: background,
              border: Border(
                top: BorderSide(color: cyan.withValues(alpha: .45), width: 1),
              ),
            ),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                indicatorColor: cyan.withValues(alpha: .18),
                labelTextStyle: WidgetStateProperty.resolveWith((states) {
                  final selected = states.contains(WidgetState.selected);
                  return TextStyle(
                    color: selected ? cyan : muted,
                    fontSize: 10.5,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                  );
                }),
                iconTheme: WidgetStateProperty.resolveWith((states) {
                  final selected = states.contains(WidgetState.selected);
                  return IconThemeData(
                    color: selected ? cyan : muted,
                    size: 22,
                  );
                }),
              ),
              child: NavigationBar(
                height: 64,
                selectedIndex: selectedIndex < 0 ? 0 : (selectedIndex > 2 ? 2 : selectedIndex),
                onDestinationSelected: handleDestination,
                destinations: [
                  NavigationDestination(
                    icon: _buildIconWithBadge(
                      const Icon(Icons.hub_outlined),
                      contactsUnreadCount,
                    ),
                    selectedIcon: _buildIconWithBadge(
                      const Icon(Icons.hub_rounded),
                      contactsUnreadCount,
                    ),
                    label: 'NODES',
                  ),
                  NavigationDestination(
                    icon: _buildIconWithBadge(
                      const Icon(Icons.forum_outlined),
                      channelsUnreadCount,
                    ),
                    selectedIcon: _buildIconWithBadge(
                      const Icon(Icons.forum_rounded),
                      channelsUnreadCount,
                    ),
                    label: 'CHATS',
                  ),
                  const NavigationDestination(
                    icon: Icon(Icons.map_outlined),
                    selectedIcon: Icon(Icons.map_rounded),
                    label: 'MAP',
                  ),
                  const NavigationDestination(
                    icon: Icon(Icons.construction_outlined),
                    selectedIcon: Icon(Icons.construction_rounded),
                    label: 'TOOLS',
                  ),
                  const NavigationDestination(
                    icon: Icon(Icons.tune_outlined),
                    selectedIcon: Icon(Icons.tune_rounded),
                    label: 'SETTINGS',
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
