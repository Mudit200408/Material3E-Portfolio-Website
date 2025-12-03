import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_web/widgets/resume_viewer_modal.dart';
import 'package:portfolio_web/widgets/scroll_animated_fade_in.dart';
import 'package:portfolio_web/core/loader/loader.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:portfolio_web/models/nav_section_enums.dart';
import 'package:portfolio_web/pages/about_page.dart';
import 'package:portfolio_web/pages/contact_page.dart';
import 'package:portfolio_web/pages/experience_page.dart';
import 'package:portfolio_web/pages/project_page.dart';
import 'package:portfolio_web/widgets/animated_background_shapes.dart';
import 'package:portfolio_web/widgets/animated_shape_container.dart';
import 'package:portfolio_web/widgets/app_drawer.dart';
import 'package:portfolio_web/widgets/gradient_button.dart';
import 'package:portfolio_web/widgets/outlined_button.dart';
import 'package:portfolio_web/widgets/skills_chip.dart';
import 'package:portfolio_web/models/skills_model.dart';
import 'package:portfolio_web/services/supabase_services.dart';
import 'package:responsive_scaler/responsive_scaler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NavSection _currentSection = NavSection.home;
  bool _isProgrammaticScroll = false;
  final _scrollController = ScrollController();
  // Global keys for different sections
  final Map<NavSection, GlobalKey> _sectionKeys = {
    NavSection.home: GlobalKey(),
    NavSection.about: GlobalKey(),
    NavSection.projects: GlobalKey(),
    NavSection.experience: GlobalKey(),
    NavSection.contact: GlobalKey(),
  };

  static const List<FontVariation> introFontNormal = [
    FontVariation('wght', 520),
    FontVariation('GRAD', 18),
    FontVariation('ROND', 50),
  ];

  static const List<FontVariation> introFontEmphasized = [
    FontVariation('wght', 750),
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
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isProgrammaticScroll) return;
    final screenHeight = MediaQuery.of(context).size.height;
    final triggerLine = screenHeight / 3;

    NavSection activeSection = _currentSection; // Start with the current one

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll - 1.0) {
      activeSection = NavSection.values.last; // Force select the last section
    } else {
      // Iterate through our keys in REVERSE order
      for (final section in NavSection.values.reversed) {
        final key = _sectionKeys[section];
        final context = key?.currentContext;

        if (context != null) {
          final box = context.findRenderObject() as RenderBox;
          final position = box.localToGlobal(Offset.zero).dy;

          if (position <= triggerLine) {
            activeSection = section;
            break; // Found it
          }
        }
      }
    }

    // Only call setState if the section has actually changed
    if (_currentSection != activeSection) {
      setState(() {
        _currentSection = activeSection;
      });
    }
  }

  Future<void> _scrollToSection(NavSection section) async {
    // 1. Update state immediately on click
    setState(() {
      _currentSection = section;
    });

    // 2. Find the key from the map
    final key = _sectionKeys[section];
    final context = key?.currentContext;

    if (context != null) {
      _isProgrammaticScroll = true;

      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );

      _isProgrammaticScroll = false;
    }
  }

  bool _onUserScroll(UserScrollNotification notification) {
    // If the user starts scrolling, we know it's no longer a programmatic scroll.
    if (_isProgrammaticScroll) {
      setState(() {
        _isProgrammaticScroll = false;
      });
    }
    // Return false to allow the notification to continue bubbling
    return false;
  }

  Future<String> _getResumeUrl() async {
    final envUrl = dotenv.env['RESUME_URL'] ?? '';
    return envUrl;
  }

  void _openResumeModal() async {
    setState(() {
      isLoading = true;
    });

    late String url;
    try {
      url = await _getResumeUrl();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unable to load resume URL: $e')));
      return;
    }
    setState(() {
      isLoading = false;
    });
    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ResumeViewerModal(resumeUrl: url),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayoutHelper.isMobile(context);

    return Scaffold(
      drawer: isMobile
          ? AppDrawer(
              currentSection: _currentSection, // 1. Pass the current state
              onNavigate: _scrollToSection, // 2. Pass the scroll function
            )
          : null,
      body: NotificationListener<UserScrollNotification>(
        onNotification: _onUserScroll,
        child: Stack(
          children: [
            // Background Shapes
            AnimatedBackgroundShapes(
              scrollController: _scrollController,
              currentSection: _currentSection,
            ),
            // Main Content
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                _buildAppBar(context, theme, isMobile),
                ..._buildPageSections(context, theme, isMobile),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageSections(
    BuildContext context,
    ThemeData theme,
    bool isMobile,
  ) {
    // This is your OLD layout, now just for the "Home" section
    final homeSection = Container(
      key: _sectionKeys[NavSection.home],
      child: isMobile
          ? _buildMobileHomeContent(context, theme)
          : _buildDesktopHomeContent(context, theme),
    );

    final aboutSection = AboutPage(key: _sectionKeys[NavSection.about]);

    // 2. CREATE STUBS FOR YOUR OTHER SECTIONS
    //    You will need to build these out
    final projectsSection = ProjectPage(key: _sectionKeys[NavSection.projects]);

    final experienceSection = ExperiencePage(
      key: _sectionKeys[NavSection.experience],
    );

    final contactSection = ContactPage(key: _sectionKeys[NavSection.contact]);

    // 3. Put all sections in a list
    final sections = [
      homeSection,
      aboutSection,
      projectsSection,
      experienceSection,
      contactSection,
    ];

    // 4. Convert each section widget into a Sliver and return the list
    return sections
        .map((section) => SliverToBoxAdapter(child: section))
        .toList();
  }

  Widget _buildAppBar(BuildContext context, ThemeData theme, bool isMobile) {
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
    return Row(children: [const Spacer()]);
  }

  Widget _buildDesktopAppBar(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo/logo.png',
          height: 50.scale(),
          width: 50.scale(),
        ),
        const Spacer(flex: 4),
        Container(
          decoration: ShapeDecoration(
            color: theme.colorScheme.primaryFixed,
            shape: const StadiumBorder(),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 8.scale(),
            horizontal: 8.scale(),
          ),
          child: Row(
            children: [
              _buildTab(
                'Home',
                context,
                onPressed: () => _scrollToSection(NavSection.home),
                isSelected: _currentSection == NavSection.home,
              ),
              _buildTab(
                'About',
                context,
                onPressed: () => _scrollToSection(NavSection.about),
                isSelected: _currentSection == NavSection.about,
              ),
              _buildTab(
                'Projects',
                context,
                onPressed: () => _scrollToSection(NavSection.projects),
                isSelected: _currentSection == NavSection.projects,
              ),
              _buildTab(
                'Experience',
                context,
                onPressed: () => _scrollToSection(NavSection.experience),
                isSelected: _currentSection == NavSection.experience,
              ),
              _buildTab(
                'Contact Me',
                context,
                onPressed: () => _scrollToSection(NavSection.contact),
                isSelected: _currentSection == NavSection.contact,
              ),
            ],
          ),
        ),

        const Spacer(),
      ],
    );
  }

  Widget _buildMobileHomeContent(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: ResponsiveSpacing.hCustom(0.05)),
        Padding(
          padding: ResponsiveLayoutHelper.getHorizontalPadding(context),
          child: Column(
            children: [
              _buildProfileSection(context, theme),
              SizedBox(height: ResponsiveSpacing.hXLarge),
              _buildIntroText(context, theme),
              SizedBox(height: ResponsiveSpacing.hMedium),
              _buildInfoBox(context, theme),
              SizedBox(height: ResponsiveSpacing.hSmall),
              _buildSkillsSection(context, theme),
              SizedBox(height: ResponsiveSpacing.hMedium),
              _buildActionButtons(context, isMobile: true),
              SizedBox(height: ResponsiveSpacing.hLarge),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHomeContent(BuildContext context, ThemeData theme) {
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
                  SizedBox(height: ResponsiveSpacing.hXLarge),
                  _buildIntroText(context, theme),
                  SizedBox(height: ResponsiveSpacing.hXSmall),
                  _buildInfoBox(context, theme),
                  _buildSkillsSection(context, theme),
                  SizedBox(height: ResponsiveSpacing.hCustom(0.04)),
                  _buildActionButtons(context, isMobile: false),
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

    return ScrollAnimatedFadeIn(
      child: AnimatedShapeContainer(
        width: imageSize.scale(),
        height: imageSize.scale(),
        color: theme.colorScheme.primaryFixed,
        border: BorderSide(
          color: theme.colorScheme.onPrimaryContainer,
          width: 2,
        ),
        child: Image.asset(
          'assets/images/profile.png',
          width: imageSize.scale(),
          height: imageSize.scale(),
        ),
      ),
    );
  }

  Widget _buildIntroText(BuildContext context, ThemeData theme) {
    return ScrollAnimatedFadeIn(
      delay: 200.ms,
      child: Column(
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
                      FontVariation('wght', 350),
                      FontVariation('wdth', 50),
                      FontVariation('opsz', 19),
                      FontVariation('GRAD', 30),
                    ],
                    letterSpacing: 0.2.scale(),
                  ),
                ),
                TextSpan(
                  text: 'Mudit Purohit',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontVariations: const [
                      FontVariation('wght', 800),
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
      ),
    );
  }

  Widget _buildInfoBox(BuildContext context, ThemeData theme) {
    return ScrollAnimatedFadeIn(
      delay: 400.ms,
      child: Container(
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
          color: theme.colorScheme.primaryFixed.withValues(alpha: 0.5),
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
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context, ThemeData theme) {
    return ScrollAnimatedFadeIn(
      delay: 600.ms,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSpacing.wMedium,
          vertical: ResponsiveSpacing.hMedium,
        ),
        child: isLoading
            ? const Loader()
            : Wrap(
                spacing: ResponsiveSpacing.wXSmall,
                runSpacing: ResponsiveSpacing.hXSmall,
                alignment: WrapAlignment.center,
                children: skills.asMap().entries.map((entry) {
                  final index = entry.key;
                  final skill = entry.value;
                  return SkillsChip(skill: skill)
                      .animate()
                      .fadeIn(delay: (100 * index).ms, duration: 400.ms)
                      .scale(curve: Curves.easeOutBack);
                }).toList(),
              ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, {required bool isMobile}) {
    return ScrollAnimatedFadeIn(
      delay: 800.ms,
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        spacing: ResponsiveSpacing.hSmall,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomOutlinedButton(
            buttonName: isLoading ? "Loading..." : "View Resume",
            onPressed: _openResumeModal,
          ),
          GradientButton(
            buttonName: 'Get in Touch',
            onPressed: () => _scrollToSection(NavSection.contact),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    String text,
    BuildContext context, {
    required VoidCallback onPressed,
    bool isSelected = false,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 6.scale()),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isSelected
              ? theme.colorScheme.primary
              : Colors.transparent,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSpacing.wXSmall,
            vertical: ResponsiveSpacing.hXSmall,
          ),
        ),
        child: Text(
          text,
          style: theme.textTheme.labelLarge?.copyWith(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
