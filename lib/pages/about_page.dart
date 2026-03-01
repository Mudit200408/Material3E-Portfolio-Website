// lib/material/pages/about_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_m3shapes_extended/flutter_m3shapes_extended.dart';
import 'package:m3e_card_list/m3e_card_list.dart';
import 'package:portfolio_web/core/utils/app_constants.dart';
import 'package:portfolio_web/widgets/scroll_animated_fade_in.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:portfolio_web/widgets/segment_button.dart';
import 'package:responsive_scaler/responsive_scaler.dart';
import 'package:motor/motor.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int selectedTab = 0; // 0 for About Me, 1 for Education
  bool _isQuoteHovered = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayoutHelper.isMobile(context);
    final isTablet = ResponsiveLayoutHelper.isTablet(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 60.r : 210.r),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.r),
          child: isMobile
              ? _buildMobileLayout(context, theme)
              : _buildDesktopLayout(context, theme, isTablet),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16.r),
        _buildQuoteCard(context, theme),
        SizedBox(height: 16.r),
        _buildInfoCard(context, theme),
        SizedBox(height: 24.r),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    ThemeData theme,
    bool isTablet,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 24.r,
      children: [
        Flexible(flex: 2, child: _buildQuoteCard(context, theme)),
        Flexible(flex: isTablet ? 3 : 2, child: _buildInfoCard(context, theme)),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, ThemeData theme) {
    final isMobile = ResponsiveLayoutHelper.isMobile(context);
    return ScrollAnimatedFadeIn(
      key: const ValueKey('about_info_card'),
      slideOffset: 0.1,
      child: Container(
        padding: EdgeInsets.all(isMobile ? 16.r : 24.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48.r),
          color: theme.colorScheme.primaryContainer,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSegmentedButtons(context, theme, isMobile),
            SizedBox(height: 24.h),
            SizedBox(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: selectedTab == 0
                    ? _buildAboutMeContent(context, theme)
                    : _buildEducationContent(context, theme),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteCard(BuildContext context, ThemeData theme) {
    return ScrollAnimatedFadeIn(
      key: const ValueKey('about_quote_card'),
      slideOffset: -0.1,
      child: Padding(
        padding: EdgeInsets.symmetric(
          // vertical: 12.scale(),
          horizontal: 8.r,
        ),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isQuoteHovered = true),
          onExit: (_) => setState(() => _isQuoteHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isQuoteHovered
                    ? [theme.colorScheme.primary, theme.colorScheme.secondary]
                    : [Colors.transparent, Colors.transparent],
              ),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                if (_isQuoteHovered)
                  BoxShadow(
                    color: theme.colorScheme.primary.withAlpha(80),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "“Clean code always looks like\nit was written by someone who cares.”",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: _isQuoteHovered
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "- Robert C. Martin",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: _isQuoteHovered
                        ? theme.colorScheme.onPrimary.withValues(alpha: 0.8)
                        : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentedButtons(
    BuildContext context,
    ThemeData theme,
    bool isMobile,
  ) {
    return Container(
      decoration: ShapeDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.2),
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SegmentButton(
              width: double.infinity,
              height: isMobile ? 50.r : 60.r,
              isSelected: selectedTab == 0,
              selectedColor: theme.colorScheme.primary,
              onTap: () => setState(() => selectedTab = 0),
              child: Center(
                child: SingleMotionBuilder(
                  motion: const MaterialSpringMotion.expressiveEffectsSlow(),
                  value: selectedTab == 0 ? 1.0 : 0.0,
                  builder: (context, value, _) {
                    final color = Color.lerp(
                      theme.colorScheme.primary,
                      theme.colorScheme.onPrimary,
                      value,
                    );
                    return Text(
                      "About Me",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: isMobile ? 16 : null,
                        color: color,
                        fontVariations: AppConstants.segmentedButtonFont,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: SegmentButton(
              width: double.infinity,
              height: isMobile ? 50.r : 60.r,
              isSelected: selectedTab == 1,
              selectedColor: theme.colorScheme.primary,
              onTap: () => setState(() => selectedTab = 1),
              child: Center(
                child: SingleMotionBuilder(
                  motion: const MaterialSpringMotion.expressiveEffectsSlow(),
                  value: selectedTab == 1 ? 1.0 : 0.0,
                  builder: (context, value, _) {
                    final color = Color.lerp(
                      theme.colorScheme.primary,
                      theme.colorScheme.onPrimary,
                      value,
                    );
                    return Text(
                      "Education",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: isMobile ? 16 : null,
                        color: color,
                        fontVariations: AppConstants.segmentedButtonFont,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutMeContent(BuildContext context, ThemeData theme) {
    return ScrollAnimatedFadeIn(
      key: const ValueKey('about_me_content'),
      delay: 200.ms,
      slideOffset: 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello! I'm Mudit, and I'm genuinely excited to be building in the world of mobile development. I'm a passionate Flutter developer who loves transforming design concepts into smooth, functional apps. I'm focused on mastering best practices like Clean Architecture, SOLID principles, and BLoC state management, because I believe a great app starts with a great foundation!",
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.8,
              color: theme.colorScheme.onPrimaryContainer,
              fontVariations: AppConstants.descriptionFont,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "I'm constantly learning and developing my skills, and I've already had amazing experiences integrating advanced features using Firebase services and even Gemini AI. From sketching out intuitive user interfaces in Figma to debugging complex integrations, I approach every project as an opportunity to grow.",
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.8,
              color: theme.colorScheme.onPrimaryContainer,
              fontVariations: AppConstants.descriptionFont,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "I'm on a journey to create innovative and efficient applications, and I can't wait to see what challenge comes next!",
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.8,
              color: theme.colorScheme.onPrimaryContainer,
              fontVariations: AppConstants.descriptionFont,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationContent(BuildContext context, ThemeData theme) {
    return M3ECardColumn(
      outerRadius: 42.r,
      innerRadius: 6.r,
      itemPadding: EdgeInsets.all(8.r),
      gap: 3.r,
      color: theme.colorScheme.primaryFixedDim.withValues(alpha: 0.6),
      children: [
        _buildEducationItem(
          context,
          theme,
          assetString: 'assets/icons/graduate.svg',
          institution: 'Atharva College of Engineering',
          degree: 'BE - Computer Engineering',
          years: '2023-2026',
          shapes: Shapes.c4_sided_cookie,
        ),
        _buildEducationItem(
          context,
          theme,
          assetString: 'assets/icons/diploma.svg',
          institution: 'Thakur Polytechnic',
          degree: 'Diploma - Information Technology',
          years: '2020-2023',
          shapes: Shapes.pill,
        ),
        _buildEducationItem(
          context,
          theme,
          assetString: 'assets/icons/school.svg',
          institution: 'Don Bosco High School',
          degree: 'Xth SSC Board Exams',
          years: '2019-2020',
          shapes: Shapes.c12_sided_cookie,
        ),
      ],
    );
  }

  Widget _buildEducationItem(
    BuildContext context,
    ThemeData theme, {
    required String assetString,
    required String institution,
    required String degree,
    required String years,
    required Shapes shapes,
  }) {
    final isMobile = ResponsiveLayoutHelper.isMobile(context);

    return Container(
      padding: EdgeInsets.all(isMobile ? 12.r : 16.r),
      child: isMobile
          ? _buildMobileEducationItem(
              context,
              theme,
              assetString,
              institution,
              degree,
              years,
              shapes,
            )
          : _buildDesktopEducationItem(
              context,
              theme,
              assetString,
              institution,
              degree,
              years,
              shapes,
            ),
    );
  }

  Widget _buildMobileEducationItem(
    BuildContext context,
    ThemeData theme,
    String assetString,
    String institution,
    String degree,
    String years,
    Shapes shapes,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            M3Container(
              shapes,
              width: 60.r,
              height: 60.r,
              color: theme.colorScheme.primary,
              child: Padding(
                padding: EdgeInsets.all(6.r),
                child: SvgPicture.asset(
                  assetString,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primaryContainer,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    institution,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontVariations: AppConstants.collegeNameFontMobile,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    degree,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(200),
                      fontVariations: AppConstants.branchNameFont,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              years,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontVariations: AppConstants.dateFont,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopEducationItem(
    BuildContext context,
    ThemeData theme,
    String assetString,
    String institution,
    String degree,
    String years,
    Shapes shapes,
  ) {
    return SizedBox(
      child: Row(
        children: [
          M3Container(
            shapes,
            width: 60.r,
            height: 60.r,
            color: theme.colorScheme.primary,
            child: Padding(
              padding: EdgeInsets.all(6.r),
              child: SvgPicture.asset(
                assetString,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.primaryContainer,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  institution,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontVariations: AppConstants.collegeNameFontDesktop,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  degree,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontVariations: AppConstants.branchNameFont,
                    color: theme.colorScheme.onSurface.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          Text(
            years,
            style: theme.textTheme.titleMedium?.copyWith(
              fontVariations: AppConstants.dateFont,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
