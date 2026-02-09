import 'package:flutter/material.dart';
import '../app_theme.dart';

class MobileNavDrawer extends StatelessWidget {
  final List<NavItem> items;
  final Function(String) onItemTap;
  final VoidCallback onClose;

  const MobileNavDrawer({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '메뉴',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: onClose,
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: items.map((item) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(item.icon, color: Colors.white, size: 20),
                    ),
                    title: Text(
                      item.label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    onTap: () {
                      onItemTap(item.id);
                      onClose();
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem {
  final String id;
  final String label;
  final IconData icon;

  const NavItem({
    required this.id,
    required this.label,
    required this.icon,
  });
}
