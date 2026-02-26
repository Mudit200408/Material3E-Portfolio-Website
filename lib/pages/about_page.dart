// lib/material/pages/about_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_web/widgets/scroll_animated_fade_in.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:portfolio_web/widgets/segment_button.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

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
      slideOffset: 0.1,
      child: Container(
        padding: EdgeInsets.all(isMobile ? 16.r : 24.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
          color: theme.colorScheme.primaryFixed,
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
                    : [theme.colorScheme.surface, theme.colorScheme.surface],
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
    const List<FontVariation> segmentedButtonFont = [
      FontVariation('slnt', -8),
      FontVariation('wght', 824),
      FontVariation('wdth', 78),
      FontVariation('GRAD', 15),
      FontVariation('XOPQ', 124),
      FontVariation('XTRA', 500),
      FontVariation('YOPQ', 100),
      FontVariation('YTLC', 750),
      FontVariation('YTAS', 535),
      FontVariation('opsz', 40),
    ];

    return Container(
      decoration: ShapeDecoration(
        color: theme.colorScheme.inversePrimary,
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
              selectedColor: theme.colorScheme.onPrimaryContainer,
              onTap: () => setState(() => selectedTab = 0),
              child: Center(
                child: Text(
                  "About Me",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: isMobile ? 16 : null,
                    color: selectedTab == 0
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onPrimaryContainer,
                    fontVariations: segmentedButtonFont,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SegmentButton(
              width: double.infinity,
              height: isMobile ? 50.r : 60.r,
              isSelected: selectedTab == 1,
              selectedColor: theme.colorScheme.onPrimaryContainer,
              onTap: () => setState(() => selectedTab = 1),
              child: Center(
                child: Text(
                  "Education",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: isMobile ? 16 : null,
                    color: selectedTab == 1
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onPrimaryContainer,
                    fontVariations: segmentedButtonFont,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutMeContent(BuildContext context, ThemeData theme) {
    const List<FontVariation> descriptionFont = [
      FontVariation('ROND', 80),
      FontVariation('wght', 600),
    ];
    return ScrollAnimatedFadeIn(
      delay: 200.ms,
      slideOffset: 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello! I'm Mudit, and I'm genuinely excited to be building in the world of mobile development. I'm a passionate Flutter developer who loves transforming design concepts into smooth, functional apps. I'm focused on mastering best practices like Clean Architecture, SOLID principles, and BLoC state management, because I believe a great app starts with a great foundation!",
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: theme.colorScheme.onSurface,
              fontVariations: descriptionFont,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "I'm constantly learning and developing my skills, and I've already had amazing experiences integrating advanced features using Firebase services and even Gemini AI. From sketching out intuitive user interfaces in Figma to debugging complex integrations, I approach every project as an opportunity to grow.",
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: theme.colorScheme.onSurface,
              fontVariations: descriptionFont,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "I'm on a journey to create innovative and efficient applications, and I can't wait to see what challenge comes next!",
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: theme.colorScheme.onSurface,
              fontVariations: descriptionFont,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationContent(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // College Item
        ScrollAnimatedFadeIn(
          delay: 100.ms,
          child: _buildEducationItem(
            context,
            theme,
            assetString: 'assets/icons/graduate.svg',
            institution: 'Atharva College of Engineering',
            degree: 'BE - Computer Engineering',
            years: '2023-2026',
          ),
        ),
        SizedBox(height: 16.h),
        // Diploma Item
        ScrollAnimatedFadeIn(
          delay: 200.ms,
          child: _buildEducationItem(
            context,
            theme,
            assetString: 'assets/icons/diploma.svg',
            institution: 'Thakur Polytechnic',
            degree: 'Diploma - Information Technology',
            years: '2020-2023',
          ),
        ),
        SizedBox(height: 16.h),
        // School Item
        ScrollAnimatedFadeIn(
          delay: 300.ms,
          child: _buildEducationItem(
            context,
            theme,
            assetString: 'assets/icons/school.svg',
            institution: 'Don Bosco High School',
            degree: 'Xth SSC Board Exams',
            years: '2019-2020',
          ),
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
            )
          : _buildDesktopEducationItem(
              context,
              theme,
              assetString,
              institution,
              degree,
              years,
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
  ) {
    const List<FontVariation> collegeNameFont = [
      FontVariation('slnt', 0),
      FontVariation('wght', 640),
      FontVariation('GRAD', -57),
      FontVariation('XOPQ', 50),
      FontVariation('XTRA', 470),
      FontVariation('YOPQ', 79),
      FontVariation('YTAS', 750),
      FontVariation('YTLC', 515),
    ];
    const List<FontVariation> branchNameFont = [
      FontVariation('slnt', -5),
      FontVariation('wdth', 30),
      FontVariation('wght', 300),
      FontVariation('GRAD', -80),
      FontVariation('XOPQ', 135),
      FontVariation('XTRA', 500),
      FontVariation('YOPQ', 100),
      FontVariation('YTAS', 730),
      FontVariation('YTLC', 480),
      FontVariation('opsz', 23),
    ];
    const List<FontVariation> dateFont = [
      FontVariation('slnt', -2),
      FontVariation('wdth', 55),
      FontVariation('wght', 720),
      FontVariation('opsz', 23),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(4.r),
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: theme.colorScheme.inversePrimary,
              ),
              child: SvgPicture.asset(
                assetString,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onPrimaryContainer,
                  BlendMode.srcIn,
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
                      fontVariations: collegeNameFont,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    degree,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(200),
                      fontVariations: branchNameFont,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              years,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontVariations: dateFont,
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
  ) {
    const List<FontVariation> collegeNameFont = [
      FontVariation('slnt', 0),
      FontVariation('wdth', 80),
      FontVariation('wght', 700),
      FontVariation('GRAD', -57),
      FontVariation('XOPQ', 50),
      FontVariation('XTRA', 470),
      FontVariation('YOPQ', 79),
      FontVariation('YTAS', 750),
      FontVariation('YTLC', 515),
      FontVariation('opsz', 139),
    ];
    const List<FontVariation> branchNameFont = [
      FontVariation('slnt', -5),
      FontVariation('wdth', 60),
      FontVariation('wght', 500),
      FontVariation('GRAD', -80),
      FontVariation('XOPQ', 135),
      FontVariation('XTRA', 500),
      FontVariation('YOPQ', 100),
      FontVariation('YTAS', 730),
      FontVariation('YTLC', 480),
      FontVariation('opsz', 23),
    ];
    const List<FontVariation> dateFont = [
      FontVariation('slnt', -2),
      FontVariation('wdth', 55),
      FontVariation('wght', 750),
      FontVariation('opsz', 23),
    ];
    return SizedBox(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4.r),
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: theme.colorScheme.inversePrimary,
            ),
            child: SvgPicture.asset(
              assetString,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.onPrimaryContainer,
                BlendMode.srcIn,
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
                    fontVariations: collegeNameFont,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  degree,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontVariations: branchNameFont,
                    color: theme.colorScheme.onSurface.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          Text(
            years,
            style: theme.textTheme.titleMedium?.copyWith(
              fontVariations: dateFont,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
