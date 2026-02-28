import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motor/motor.dart';
import 'package:portfolio_web/core/utils/navigation_provider.dart';
import 'package:portfolio_web/models/nav_section_enums.dart';
import 'package:provider/provider.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class NavBar extends StatelessWidget {
  final bool isMobile;

  const NavBar({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0,
      backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.1),
      automaticallyImplyLeading: isMobile,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 10),
          child: Container(
            color: theme.colorScheme.surface.withValues(alpha: 0.3),
          ),
        ),
      ),
      title: isMobile
          ? _buildMobileAppBar(context, theme)
          : _buildDesktopAppBar(context, theme),
    );
  }

  Widget _buildMobileAppBar(BuildContext context, ThemeData theme) {
    return const Row(children: [Spacer()]);
  }

  Widget _buildDesktopAppBar(BuildContext context, ThemeData theme) {
    final navProvider = context.watch<NavigationProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/logo/logo.svg', height: 40.r, width: 40.r),
        const Spacer(flex: 4),
        Container(
          decoration: ShapeDecoration(
            color: theme.colorScheme.primaryContainer,
            shape: const StadiumBorder(),
          ),
          padding: EdgeInsets.all(8.r),
          child: Row(
            children: [
              _buildTab(
                text: 'Home',
                section: NavSection.home,
                context: context,
                navProvider: navProvider,
              ),
              _buildTab(
                text: 'About',
                section: NavSection.about,
                context: context,
                navProvider: navProvider,
              ),
              _buildTab(
                text: 'Projects',
                section: NavSection.projects,
                context: context,
                navProvider: navProvider,
              ),
              _buildTab(
                text: 'Experience',
                section: NavSection.experience,
                context: context,
                navProvider: navProvider,
              ),
              _buildTab(
                text: 'Contact Me',
                section: NavSection.contact,
                context: context,
                navProvider: navProvider,
              ),
            ],
          ),
        ),
        const Spacer(flex: 3),
        const Spacer(),
      ],
    );
  }

  Widget _buildTab({
    required String text,
    required NavSection section,
    required BuildContext context,
    required NavigationProvider navProvider,
  }) {
    final theme = Theme.of(context);
    final isSelected = navProvider.currentSection == section;

    String iconPath;
    switch (section) {
      case NavSection.home:
        iconPath = 'assets/icons/home.svg';
        break;
      case NavSection.about:
        iconPath = 'assets/icons/about.svg';
        break;
      case NavSection.projects:
        iconPath = 'assets/icons/project.svg';
        break;
      case NavSection.experience:
        iconPath = 'assets/icons/experience.svg';
        break;
      case NavSection.contact:
        iconPath = 'assets/icons/email.svg';
        break;
    }

    return Padding(
      padding: EdgeInsets.only(left: 6.r),
      child: SingleMotionBuilder(
        motion: const MaterialSpringMotion.expressiveSpatialSlow().copyWith(
          stiffness: 500,
          damping: 0.5,
        ),
        value: isSelected ? 1.0 : 0.0,
        builder: (context, value, child) {
          final color =
              Color.lerp(
                Colors.transparent,
                theme.colorScheme.primary,
                value,
              ) ??
              Colors.transparent;
          final textColor =
              Color.lerp(
                theme.colorScheme.onPrimaryContainer,
                theme.colorScheme.onPrimary,
                value,
              ) ??
              theme.colorScheme.onPrimaryContainer;
          final safeValue = value < 0.0 ? 0.0 : value;
          final fontWeight = lerpDouble(520, 600, value) ?? 520;

          return TextButton(
            onPressed: () => navProvider.scrollToSection(section),
            style: TextButton.styleFrom(
              backgroundColor: color,
              shape: const StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 4.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: safeValue,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          iconPath,
                          height: 18.r,
                          width: 18.r,
                          colorFilter: ColorFilter.mode(
                            textColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 6.r),
                      ],
                    ),
                  ),
                ),
                Text(
                  text,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: textColor,
                    fontVariations: [FontVariation('wght', fontWeight)],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
