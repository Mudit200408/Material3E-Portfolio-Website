import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:portfolio_web/models/nav_section_enums.dart';

import 'package:responsive_scaler/responsive_scaler.dart';

class AppDrawer extends StatelessWidget {
  final Function(NavSection)? onNavigate;
  final NavSection currentSection;
  const AppDrawer({super.key, this.onNavigate, required this.currentSection});

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
                  SvgPicture.asset(
                    'assets/logo/logo.svg',
                    height: 40.scale(),
                    width: 40.scale(),
                  ),
                  SizedBox(width: 12.scale()),
                  Text(
                    'Mudit Purohit',
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
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
            SizedBox(height: 8.scale()),
            // Navigation items
            _buildDrawerItem(
              context,
              icon: 'assets/icons/home.svg',
              title: 'Home',
              isSelected: currentSection == NavSection.home,
              onTap: () {
                Navigator.pop(context);
                onNavigate?.call(NavSection.home);
              },
            ),
            _buildDrawerItem(
              context,
              icon: 'assets/icons/about.svg',
              title: 'About',
              isSelected: currentSection == NavSection.about,
              onTap: () {
                Navigator.pop(context);
                onNavigate?.call(NavSection.about);
              },
            ),
            _buildDrawerItem(
              context,
              icon: 'assets/icons/project.svg',
              title: 'Projects',
              isSelected: currentSection == NavSection.projects,
              onTap: () {
                Navigator.pop(context);
                onNavigate?.call(NavSection.projects);
              },
            ),
            _buildDrawerItem(
              context,
              icon: 'assets/icons/experience.svg',
              title: 'Experience',
              isSelected: currentSection == NavSection.experience,
              onTap: () {
                Navigator.pop(context);
                onNavigate?.call(NavSection.experience);
              },
            ),
            _buildDrawerItem(
              context,
              icon: 'assets/icons/email.svg',
              title: 'Contact Me',
              isSelected: currentSection == NavSection.contact,
              onTap: () {
                Navigator.pop(context);
                onNavigate?.call(NavSection.contact);
              },
            ),
            const Spacer(),
            SizedBox(height: 16.scale()),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.scale(), vertical: 4.scale()),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.6)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          icon,
          colorFilter: isSelected
              ? ColorFilter.mode(theme.colorScheme.primary, BlendMode.srcIn)
              : ColorFilter.mode(theme.colorScheme.onSurface, BlendMode.srcIn),
          width: 24.scale(),
          height: 24.scale(),
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
