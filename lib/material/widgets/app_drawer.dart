import 'package:flutter/material.dart';
import 'package:portfolio_web/app.dart';
import 'package:portfolio_web/material/widgets/style_toggle.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class AppDrawer extends StatelessWidget {
  final Function(String)? onNavigate;

  const AppDrawer({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.scale()),
            // Logo or header
            Padding(
              padding: EdgeInsets.all(16.scale()),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 32.scale(),
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(width: 12.scale()),
                  Text(
                    'Portfolio',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
            SizedBox(height: 8.scale()),
            // Navigation items
            _buildDrawerItem(
              context,
              icon: Icons.home_outlined,
              title: 'Home',
              isSelected: true,
              onTap: () {
                Navigator.pop(context);
                onNavigate?.call('Home');
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.work_outline,
              title: 'Projects',
              onTap: () {
                Navigator.pop(context);
                onNavigate?.call('Projects');
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.design_services_outlined,
              title: 'Services',
              onTap: () {
                Navigator.pop(context);
                onNavigate?.call('Services');
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.person_outline,
              title: 'About',
              onTap: () {
                Navigator.pop(context);
                onNavigate?.call('About');
              },
            ),
            const Spacer(),
            // Style toggle at bottom
            Padding(
              padding: EdgeInsets.all(16.scale()),
              child: Column(
                children: [
                  Divider(
                    thickness: 1,
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                  SizedBox(height: 12.scale()),
                  Row(
                    children: [
                      Text(
                        'Theme Style',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      StyleToggle(
                        currentStyle: App.controller.appStyle,
                        onChanged: (style) {
                          App.controller.setStyle(style);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.scale()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.scale(), vertical: 4.scale()),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.primaryContainer.withOpacity(0.6)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
          size: 24.scale(),
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
