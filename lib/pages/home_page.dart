import 'package:flutter/material.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:portfolio_web/core/utils/navigation_provider.dart';
import 'package:portfolio_web/models/nav_section_enums.dart';
import 'package:portfolio_web/pages/about_page.dart';
import 'package:portfolio_web/pages/contact_page.dart';
import 'package:portfolio_web/pages/experience_page.dart';
import 'package:portfolio_web/widgets/home_widgets/home_action_buttons.dart';
import 'package:portfolio_web/widgets/home_widgets/home_hero_section.dart';
import 'package:portfolio_web/widgets/home_widgets/home_skills_section.dart';
import 'package:portfolio_web/pages/project_page.dart';
import 'package:portfolio_web/widgets/animated_background_shapes.dart';
import 'package:portfolio_web/widgets/app_drawer.dart';
import 'package:portfolio_web/widgets/nav_bar.dart';
import 'package:portfolio_web/widgets/footer.dart';
import 'package:provider/provider.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  bool _onUserScroll(
    UserScrollNotification notification,
    NavigationProvider navProvider,
  ) {
    if (navProvider.isProgrammaticScroll) {
      navProvider.setProgrammaticScroll(false);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayoutHelper.isMobile(context);
    final navProvider = context.watch<NavigationProvider>();

    return SelectionArea(
      child: Scaffold(
        drawer: isMobile ? const AppDrawer() : null,
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) =>
              _onUserScroll(notification, navProvider),
          child: Stack(
            children: [
              // Background Shapes
              RepaintBoundary(
                child: AnimatedBackgroundShapes(
                  scrollController: navProvider.scrollController,
                  currentSection: navProvider.currentSection,
                ),
              ),
              // Main Content
              CustomScrollView(
                controller: navProvider.scrollController,
                slivers: [
                  NavBar(isMobile: isMobile),
                  ..._buildPageSections(context, theme, isMobile, navProvider),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageSections(
    BuildContext context,
    ThemeData theme,
    bool isMobile,
    NavigationProvider navProvider,
  ) {
    // Home Section composed of extracted widgets
    final homeSection = Container(
      margin: EdgeInsets.only(top: 75.r),
      key: navProvider.sectionKeys[NavSection.home],
      child: isMobile
          ? _buildMobileHome(context, theme)
          : _buildDesktopHome(context, theme),
    );

    final sections = [
      homeSection,
      AboutPage(key: navProvider.sectionKeys[NavSection.about]),
      ProjectPage(key: navProvider.sectionKeys[NavSection.projects]),
      ExperiencePage(key: navProvider.sectionKeys[NavSection.experience]),
      ContactPage(key: navProvider.sectionKeys[NavSection.contact]),
      const Footer(),
    ];

    return sections
        .map((section) => SliverToBoxAdapter(child: section))
        .toList();
  }

  Widget _buildMobileHome(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.r),
          child: Column(
            children: [
              HomeHeroSection(theme: theme),
              SizedBox(height: 8.h),
              const HomeSkillsSection(),
              SizedBox(height: 16.h),
              const HomeActionButtons(isMobile: true),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHome(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveLayoutHelper.getMaxContentWidth(context),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.r),
              child: Column(
                children: [
                  HomeHeroSection(theme: theme),
                  const HomeSkillsSection(),
                  SizedBox(height: 12.h),
                  const HomeActionButtons(isMobile: false),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
