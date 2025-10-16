import 'package:flutter/material.dart';
import 'package:portfolio_web/app.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:portfolio_web/material/widgets/animated_shape_container.dart';
import 'package:portfolio_web/material/widgets/app_drawer.dart';
import 'package:portfolio_web/material/widgets/gradient_button.dart';
import 'package:portfolio_web/material/widgets/outlined_button.dart';
import 'package:portfolio_web/material/widgets/skills_chip.dart';
import 'package:portfolio_web/material/widgets/style_toggle.dart';
import 'package:portfolio_web/models/skills_model.dart';
import 'package:portfolio_web/services/supabase_services.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<FontVariation> introFontNormal = [
    FontVariation('wght', 280),
    FontVariation('GRAD', 18),
  ];

  static const List<FontVariation> introFontEmphasized = [
    FontVariation('wght', 700),
    FontVariation('slnt', -5),
    FontVariation('wdth', 70),
    FontVariation('XOPQ', 125),
    FontVariation('XTRA', 468),
    FontVariation('opsz', 28),
  ];

  List<SkillsModel> skills = [];
  final SupabaseServices _supabaseServices = SupabaseServices();
  bool isLoading = true;

  Future<void> _loadSkills() async {
    try {
      final fetchedSkills = await _supabaseServices.getSkills();
      setState(() {
        skills = fetchedSkills;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading skills: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSkills();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayoutHelper.isMobile(context);

    return Scaffold(
      drawer: isMobile ? const AppDrawer() : null,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, theme, isMobile),
          SliverToBoxAdapter(
            child: ResponsiveLayoutHelper.responsiveValue(
              context,
              mobile: _buildMobileLayout(context, theme),
              desktop: _buildDesktopLayout(context, theme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ThemeData theme, bool isMobile) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: theme.colorScheme.surface,
      elevation: 0,
      title: isMobile
          ? _buildMobileAppBar(context, theme)
          : _buildDesktopAppBar(context, theme),
    );
  }

  Widget _buildMobileAppBar(BuildContext context, ThemeData theme) {
    return Row(
      children: [
        const Spacer(),
        StyleToggle(
          currentStyle: App.controller.appStyle,
          onChanged: (style) {
            setState(() {
              App.controller.setStyle(style);
            });
          },
        ),
      ],
    );
  }

  Widget _buildDesktopAppBar(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        _buildTab('Home', context, isSelected: true),
        _buildTab('Projects', context),
        _buildTab('Services', context),
        _buildTab('About', context),
        const Spacer(),
        StyleToggle(
          currentStyle: App.controller.appStyle,
          onChanged: (style) {
            setState(() {
              App.controller.setStyle(style);
            });
          },
        ),
        const Spacer(flex: 2),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: ResponsiveSpacing.hCustom(0.05)),
        Padding(
          padding: ResponsiveLayoutHelper.getHorizontalPadding(context),
          child: Column(
            children: [
              _buildProfileSection(context, theme),
              SizedBox(height: ResponsiveSpacing.hMedium),
              _buildIntroText(context, theme),
              SizedBox(height: ResponsiveSpacing.hMedium),
              _buildInfoBox(context, theme),
              SizedBox(height: ResponsiveSpacing.hMedium),
              _buildSkillsSection(context, theme),
              SizedBox(height: ResponsiveSpacing.hMedium),
              _buildActionButtons(context, isStacked: true),
              SizedBox(height: ResponsiveSpacing.hLarge),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: ResponsiveSpacing.hCustom(0.1)),
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveLayoutHelper.getMaxContentWidth(context),
            ),
            child: Padding(
              padding: ResponsiveLayoutHelper.getHorizontalPadding(context),
              child: Column(
                children: [
                  _buildProfileSection(context, theme),
                  SizedBox(height: ResponsiveSpacing.hMedium),
                  _buildIntroText(context, theme),
                  SizedBox(height: ResponsiveSpacing.hXSmall),
                  _buildInfoBox(context, theme),
                  SizedBox(height: ResponsiveSpacing.hMedium),
                  _buildSkillsSection(context, theme),
                  SizedBox(height: ResponsiveSpacing.hCustom(0.04)),
                  _buildActionButtons(context, isStacked: false),
                  SizedBox(height: ResponsiveSpacing.hLarge),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(BuildContext context, ThemeData theme) {
    final imageSize = ResponsiveLayoutHelper.responsiveValue(
      context,
      mobile: 200.0,
      tablet: 250.0,
      desktop: 300.0,
    );

    return AnimatedShapeContainer(
      width: imageSize.scale(),
      height: imageSize.scale(),
      color: theme.colorScheme.primaryContainer,
      child: Image.asset(
        'assets/images/profile.png',
        width: imageSize.scale(),
        height: imageSize.scale(),
      ),
    );
  }

  Widget _buildIntroText(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Hello, I am ',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontVariations: const [
                    FontVariation('wght', 180),
                    FontVariation('wdth', 18),
                    FontVariation('opsz', 19),
                    FontVariation('GRAD', 30),
                  ],
                  letterSpacing: 0.2.scale(),
                ),
              ),
              TextSpan(
                text: 'Mudit Purohit',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: theme.colorScheme.primary.withAlpha(180),
                  fontVariations: const [
                    FontVariation('wght', 750),
                    FontVariation('slnt', -8),
                    FontVariation('GRAD', 80),
                    FontVariation('wdth', 20),
                    FontVariation('opsz', 23),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ResponsiveSpacing.hSmall),
        Text(
          'Cross Platform App Developer',
          textAlign: TextAlign.center,
          style: theme.textTheme.displaySmall?.copyWith(
            color: theme.colorScheme.primary,
            fontVariations: const [
              FontVariation('wght', 800),
              FontVariation('GRAD', 50),
              FontVariation('wdth', 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox(BuildContext context, ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSpacing.wSmall,
        vertical: ResponsiveSpacing.hSmall,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveLayoutHelper.responsiveValue(
          context,
          mobile: ResponsiveSpacing.wXSmall,
          desktop: ResponsiveSpacing.wMedium,
        ),
        vertical: ResponsiveSpacing.hMedium,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryFixed.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'I am a skilled ',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontVariations: introFontNormal,
              ),
            ),
            TextSpan(
              text: 'Flutter Developer',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontVariations: introFontEmphasized,
              ),
            ),
            TextSpan(
              text:
                  ' with expertise in building robust and scalable mobile applications. My experience includes using ',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontVariations: introFontNormal,
              ),
            ),
            TextSpan(
              text: 'Clean Architecture ',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontVariations: introFontEmphasized,
              ),
            ),
            TextSpan(
              text: 'and ',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontVariations: introFontNormal,
              ),
            ),
            TextSpan(
              text: 'SOLID principles ',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontVariations: introFontEmphasized,
              ),
            ),
            TextSpan(
              text: 'for clean, maintainable code. I\'m proficient in ',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontVariations: introFontNormal,
              ),
            ),
            TextSpan(
              text: 'Dart',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontVariations: introFontEmphasized,
              ),
            ),
            TextSpan(
              text: ', and have integrated ',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontVariations: introFontNormal,
              ),
            ),
            TextSpan(
              text: 'Firebase services ',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontVariations: introFontEmphasized,
              ),
            ),
            TextSpan(
              text: 'and ',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontVariations: introFontNormal,
              ),
            ),
            TextSpan(
              text: 'Gemini AI ',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontVariations: introFontEmphasized,
              ),
            ),
            TextSpan(
              text:
                  'to create dynamic and intelligent applications. I am passionate about creating innovative and efficient applications that provide a seamless user experience.',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontVariations: introFontNormal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSpacing.wMedium,
        vertical: ResponsiveSpacing.hMedium,
      ),
      child: isLoading
          ? const CircularProgressIndicator()
          : Wrap(
              spacing: ResponsiveSpacing.wXSmall,
              runSpacing: ResponsiveSpacing.hXSmall,
              alignment: WrapAlignment.center,
              children: skills.map((skill) {
                return SkillsChip(skill: skill);
              }).toList(),
            ),
    );
  }

  Widget _buildActionButtons(BuildContext context, {required bool isStacked}) {
    if (isStacked) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GradientButton(buttonName: 'Get in Touch', onPressed: () {}),
          SizedBox(height: ResponsiveSpacing.hXSmall),
          CustomOutlinedButton(buttonName: "Download Resume", onPressed: () {}),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientButton(buttonName: 'Get in Touch', onPressed: () {}),
        SizedBox(width: ResponsiveSpacing.wXSmall),
        CustomOutlinedButton(buttonName: "Download Resume", onPressed: () {}),
      ],
    );
  }

  Widget _buildTab(
    String text,
    BuildContext context, {
    bool isSelected = false,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 6.scale()),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: isSelected
              ? theme.colorScheme.primary
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSpacing.wXSmall,
            vertical: ResponsiveSpacing.hXSmall,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
