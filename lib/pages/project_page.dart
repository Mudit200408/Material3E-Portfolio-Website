import 'package:flutter/material.dart';

import 'package:flutter_custom_caraousel_v2/flutter_custom_caraousel_v2.dart';
import 'package:flutter_m3shapes/flutter_m3shapes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio_web/core/loader/loader.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:portfolio_web/widgets/scroll_animated_fade_in.dart';
import 'package:portfolio_web/models/project_model.dart';
import 'package:portfolio_web/services/supabase_services.dart';
import 'package:responsive_scaler/responsive_scaler.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final CarouselControllerv2 _carouselController = CarouselControllerv2();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  final SupabaseServices _supabaseServices = SupabaseServices();
  late Future<List<ProjectModel>> _projectFuture;

  @override
  void initState() {
    super.initState();
    _projectFuture = _supabaseServices.getProjects();
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayoutHelper.isMobile(context);
    final isTablet = ResponsiveLayoutHelper.isTablet(context);
    final isDesktop = ResponsiveLayoutHelper.isDesktop(context);
    return Container(
      color: Colors.transparent,
      margin: isMobile
          ? EdgeInsets.all(21.scale())
          : (isTablet
                ? EdgeInsetsGeometry.all(21.scale())
                : EdgeInsets.symmetric(
                    horizontal: 180.scale(),
                    vertical: 28.scale(),
                  )),
      child: ConstrainedBox(
        constraints: isDesktop
            ? BoxConstraints(maxWidth: 600.scale(), minHeight: 800.scale())
            : BoxConstraints(),
        child: Container(
          padding: isMobile
              ? EdgeInsets.zero
              : EdgeInsets.symmetric(
                  vertical: (isTablet ? 12.scale() : 50.scale()),
                  horizontal: (isTablet ? 12.scale() : 80.scale()),
                ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(52.scale()),
            // color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
          ),
          child: FutureBuilder<List<ProjectModel>>(
            future: _projectFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Loader());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No projects found.'));
              }

              final projects = snapshot.data!;

              return Column(
                spacing: ResponsiveSpacing.hLarge,
                children: [
                  // --- CAROUSEL SECTION ---
                  _buildCarouselWidget(isMobile, isTablet, isDesktop, projects),

                  // --- INFO SECTION ---
                  ValueListenableBuilder<int>(
                    valueListenable: _currentIndex,
                    builder: (context, index, child) {
                      // Ensure index is within bounds
                      if (index >= projects.length) return const SizedBox();
                      final project = projects[index];
                      return IntrinsicHeight(
                        child: Flex(
                          direction: isMobile ? Axis.vertical : Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: ResponsiveSpacing.hSmall,
                          children: [
                            Expanded(
                              flex: 2,
                              child: _buildInfoCard(theme, project, isMobile),
                            ),
                            Expanded(
                              flex: isMobile ? 2 : (isTablet ? 3 : 6),
                              child: _buildDescription(
                                theme,
                                project,
                                isMobile,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselWidget(
    bool isMobile,
    bool isTablet,
    bool isDesktop,
    List<ProjectModel> projects,
  ) {
    return ScrollAnimatedFadeIn(
      delay: const Duration(milliseconds: 300),
      slideOffset: -0.1,
      autoRebuild: true,
      child: SizedBox(
        height: isMobile ? 280.scale() : (isTablet ? 350.scale() : 500.scale()),
        // We add a NotificationListener to get the current index
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            // Check if the scroll is happening and the controller is ready
            if (notification is ScrollUpdateNotification &&
                _carouselController.hasClients) {
              // Get the current item index from the controller
              final int newIndex = _carouselController.currentItem ?? 0;

              // If the index has changed, update the state
              if (newIndex != _currentIndex.value &&
                  newIndex < projects.length) {
                _currentIndex.value = newIndex;
              }
            }
            return true; // Allow the notification to continue
          },
          child: CarouselViewV2.weighted(
            // Pass the controller
            controller: _carouselController,
            flexWeights: isMobile ? const [1, 18, 1] : const [2, 8, 2],
            elevation: 3,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 15),
            consumeMaxWeight: true,
            enableSplash: false,
            isWeb: isDesktop,
            itemSnapping: true,
            shrinkExtent: 10.scale(),
            padding: EdgeInsets.all(8.scale()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(52.scale()),
            ),
            children: List.generate(projects.length, (index) {
              final imagePath = projects[index].image;
              // The package wraps this in Material, so we
              // just need the ClipRRect and Image.
              Widget imageWidget;
              if (imagePath.startsWith('http')) {
                imageWidget = Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 50),
                    );
                  },
                );
              } else {
                imageWidget = Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 50),
                    );
                  },
                );
              }

              return ClipRRect(
                borderRadius: BorderRadius.circular(52.scale()),
                child: imageWidget,
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(ThemeData theme, ProjectModel project, bool isMobile) {
    return ScrollAnimatedFadeIn(
      delay: const Duration(milliseconds: 500),
      slideOffset: 0.4,
      child: Container(
        padding: EdgeInsets.all(24.scale()),
        constraints: isMobile ? BoxConstraints(maxWidth: 150.scale()) : null,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryFixed,
          borderRadius: BorderRadius.circular(52.scale()),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                project.title,
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontVariations: [
                    const FontVariation('wght', 790),
                    const FontVariation('wdth', 80),
                    const FontVariation('slnt', -5),
                    const FontVariation('opsz', 35),
                  ],
                ),
              ),
            ),
            SizedBox(height: ResponsiveSpacing.hMedium),
            Wrap(
              spacing: 3.scale(),
              runSpacing: 4.scale(),
              children: project.tags.map((tag) {
                return Chip(
                  label: Text(
                    tag,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontVariations: const [
                        FontVariation('wght', 450),
                        FontVariation('ROND', 100),
                      ],
                    ),
                  ),
                  shape: StadiumBorder(),
                  side: BorderSide(
                    color: theme.colorScheme.onPrimaryContainer,
                    width: 0.5,
                  ),
                  backgroundColor: theme.colorScheme.surface,
                );
              }).toList(),
            ),
            SizedBox(height: ResponsiveSpacing.hMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (project.pubDev != null && project.pubDev!.isNotEmpty)
                  Expanded(
                    child: _buildGithubButton(
                      theme,
                      label: 'Pub Dev',
                      icon: 'assets/icons/pubdev.svg',
                      url: project.pubDev!,
                      onPressed: () => _launchUrl(project.pubDev!),
                    ),
                  ),
                SizedBox(width: ResponsiveSpacing.wXSmall),
                if (project.github != null && project.github!.isNotEmpty)
                  Expanded(
                    child: _buildGithubButton(
                      theme,
                      label: 'GitHub',
                      icon: 'assets/icons/github.svg',
                      url: project.github!,
                      onPressed: () => _launchUrl(project.github!),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(
    ThemeData theme,
    ProjectModel project,
    bool isMobile,
  ) {
    return ScrollAnimatedFadeIn(
      delay: const Duration(milliseconds: 800),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, anim) =>
            FadeTransition(opacity: anim, child: child),
        child: Container(
          key: ValueKey(project.title),
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(24.scale()),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryFixed,
            borderRadius: BorderRadius.circular(52.scale()),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...project.description.take(4).toList().asMap().entries.map((
                  entry,
                ) {
                  final index = entry.key;
                  final resp = entry.value;

                  // Cycle through shapes
                  final shapes = [
                    Shapes.c4_sided_cookie,
                    Shapes.c6_sided_cookie,
                    Shapes.c7_sided_cookie,
                    Shapes.c9_sided_cookie,
                  ];
                  final shape = shapes[index % shapes.length];

                  final colors = [
                    theme.colorScheme.primary,
                    theme.colorScheme.tertiary,
                  ];
                  final shapeColor = colors[index % colors.length];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.scale()),
                    child: Row(
                      children: [
                        M3Container(
                          shape,
                          width: 16.scale(),
                          height: 16.scale(),
                          color: shapeColor,
                          child: const SizedBox(),
                        ),
                        SizedBox(width: 12.scale()),
                        Expanded(
                          child: Text(
                            resp,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                              fontVariations: const [
                                FontVariation('wght', 550),
                                FontVariation('ROND', 100),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGithubButton(
    ThemeData theme, {
    required String label,
    required String icon,
    required String url,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        icon,
        width: 18.scale(),
        height: 18.scale(),
        colorFilter: ColorFilter.mode(
          theme.colorScheme.onPrimary,
          BlendMode.srcIn,
        ),
      ),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(150.scale(), 75.scale()),
        backgroundColor: theme.colorScheme.onPrimaryContainer,
        foregroundColor: theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
      ),
    );
  }
}
