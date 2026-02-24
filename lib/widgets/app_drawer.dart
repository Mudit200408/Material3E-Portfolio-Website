import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio_web/core/utils/navigation_provider.dart';
import 'package:portfolio_web/models/nav_section_enums.dart';
import 'package:provider/provider.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Watch for scroll changes to highlight active section
    final navProvider = context.watch<NavigationProvider>();

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      elevation: 0,
      width: 280.w,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 32.h),
            // Header Image/Logo
            SvgPicture.asset(
              'assets/logo/logo.svg',
              height: 100.r,
              width: 100.r,
            ),
            SizedBox(height: 48.h),
            _buildDrawerItem(
              context: context,
              title: 'Home',
              iconPath: 'assets/icons/home.svg',
              section: NavSection.home,
              navProvider: navProvider,
            ),
            _buildDrawerItem(
              context: context,
              title: 'About',
              iconPath: 'assets/icons/about.svg',
              section: NavSection.about,
              navProvider: navProvider,
            ),
            _buildDrawerItem(
              context: context,
              title: 'Projects',
              iconPath: 'assets/icons/project.svg',
              section: NavSection.projects,
              navProvider: navProvider,
            ),
            _buildDrawerItem(
              context: context,
              title: 'Experience',
              iconPath: 'assets/icons/experience.svg',
              section: NavSection.experience,
              navProvider: navProvider,
            ),
            _buildDrawerItem(
              context: context,
              title: 'Contact',
              iconPath: 'assets/icons/email.svg',
              section: NavSection.contact,
              navProvider: navProvider,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required String title,
    required String iconPath,
    required NavSection section,
    required NavigationProvider navProvider,
  }) {
    final theme = Theme.of(context);
    final isSelected = navProvider.currentSection == section;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: isSelected
            ? theme.colorScheme.primaryFixed
            : Colors.transparent,
        leading: SvgPicture.asset(
          iconPath,
          height: 24.r,
          width: 24.r,
          colorFilter: ColorFilter.mode(
            isSelected
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onSurfaceVariant,
            BlendMode.srcIn,
          ),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: isSelected
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        onTap: () {
          Navigator.pop(context); // Close the drawer
          navProvider.scrollToSection(section);
        },
      ),
    );
  }
}
