import 'package:flutter/material.dart';

import 'package:flutter_custom_caraousel_v2/flutter_custom_caraousel_v2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:portfolio_web/core/loader/loader.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:portfolio_web/core/utils/url_launcher_helper.dart';
import 'package:portfolio_web/widgets/scroll_animated_fade_in.dart';
import 'package:portfolio_web/models/project_model.dart';
import 'package:portfolio_web/services/supabase_services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final CarouselControllerv2 _carouselController = CarouselControllerv2();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  late SupabaseServices _supabaseServices;
  Future<List<ProjectModel>>? _projectFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _supabaseServices = context.read<SupabaseServices>();
    _projectFuture ??= _supabaseServices.getProjects();
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (mounted) UrlLauncherHelper.launch(context, url);
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
          ? EdgeInsets.all(21.r)
          : (isTablet
                ? EdgeInsetsGeometry.all(21.r)
                : EdgeInsets.symmetric(horizontal: 180.r, vertical: 28.r)),
      child: ConstrainedBox(
        constraints: isDesktop
            ? BoxConstraints(maxWidth: 600.w, minHeight: 800.h)
            : const BoxConstraints(),
        child: Container(
          padding: isMobile
              ? EdgeInsets.zero
              : EdgeInsets.symmetric(
                  vertical: (isTablet ? 12.r : 50.r),
                  horizontal: (isTablet ? 12.r : 80.r),
                ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(52.r),
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
                spacing: 24.r,
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
                      Widget content = Flex(
                        direction: isMobile ? Axis.vertical : Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 8.r,
                        children: [
                          isMobile
                              ? _buildInfoCard(theme, project, isMobile)
                              : Expanded(
                                  flex: 3,
                                  child: _buildInfoCard(
                                    theme,
                                    project,
                                    isMobile,
                                  ),
                                ),
                          isMobile
                              ? _buildDescription(theme, project, isMobile)
                              : Expanded(
                                  flex: isTablet ? 4 : 6,
                                  child: _buildDescription(
                                    theme,
                                    project,
                                    isMobile,
                                  ),
                                ),
                        ],
                      );

                      return isMobile
                          ? content
                          : IntrinsicHeight(child: content);
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
    final isWeb = isDesktop || isTablet;
    return ScrollAnimatedFadeIn(
      key: const ValueKey('project_header'),
      delay: const Duration(milliseconds: 200),
      slideOffset: -0.1,
      autoRebuild: true,
      child: SizedBox(
        height: isMobile ? 300.r : (isTablet ? 350.r : 380.r),
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
            flexWeights: isMobile ? const [18, 2] : const [2, 8, 2],
            elevation: 3,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 15),
            consumeMaxWeight: true,
            enableSplash: false,
            isWeb: isWeb,
            itemSnapping: true,
            shrinkExtent: 10.r,
            padding: EdgeInsets.all(8.r),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(52.r),
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
                      child: Icon(Icons.broken_image, size: 50.r),
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
                borderRadius: BorderRadius.circular(52.r),
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
      key: ValueKey('project_info_${project.id}'),
      delay: const Duration(milliseconds: 400),
      slideOffset: 0.1,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn, // Smooth expansion/contraction
        alignment: Alignment.topCenter, // Anchors content to top while resizing
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          // Use a layout builder to ensure size changes are detected correctly
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
          transitionBuilder: (child, anim) =>
              FadeTransition(opacity: anim, child: child),
          child: Container(
            key: ValueKey(project.image),
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(52.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    project.title,
                    textAlign: TextAlign.center,
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
                SizedBox(height: 8.r),
                Wrap(
                  spacing: 6.r,
                  runSpacing: 6.r,
                  children: project.tags.map((tag) {
                    return Chip(
                      label: Text(
                        tag,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontVariations: const [
                            FontVariation('wght', 500),
                            FontVariation('ROND', 100),
                          ],
                        ),
                      ),
                      shape: const StadiumBorder(),
                      side: BorderSide(
                        color: theme.colorScheme.onPrimaryContainer,
                        width: 0.5,
                      ),
                      backgroundColor: theme.colorScheme.primaryFixedDim,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    );
                  }).toList(),
                ),

                SizedBox(height: 8.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (project.pubDev != null && project.pubDev!.isNotEmpty)
                      Expanded(
                        child: _buildButton(
                          theme,
                          label: 'Pub Dev',
                          icon: 'assets/icons/pubdev.svg',
                          url: project.pubDev!,
                          onPressed: () => _launchUrl(project.pubDev!),
                        ),
                      ),
                    SizedBox(width: 4.r),
                    if (project.github != null && project.github!.isNotEmpty)
                      Expanded(
                        child: _buildButton(
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
      key: ValueKey('project_mockup_${project.id}'),
      delay: const Duration(milliseconds: 600),
      slideOffset: 0.1,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.topCenter,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          layoutBuilder: (currentChild, previousChildren) {
            // Keeps the layout stable during transition
            return Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
          transitionBuilder: (child, anim) =>
              FadeTransition(opacity: anim, child: child),
          child: Container(
            key: ValueKey(project.title),
            width: double.infinity,
            height: isMobile ? null : double.infinity,
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(52.r),
            ),
            child: M3ECardColumn(
              outerRadius: 32.r,
              color: theme.colorScheme.primaryFixedDim.withValues(alpha: 0.6),
              children: [
                ...project.description.take(4).toList().asMap().entries.map((
                  entry,
                ) {
                  final index = entry.key;
                  final resp = entry.value;

                  // Cycle through shapes
                  const shapes = [
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

                  return Row(
                    children: [
                      M3EContainer(
                        shape,
                        width: 22.r,
                        height: 22.r,
                        color: shapeColor,
                        child: const SizedBox(),
                      ),
                      SizedBox(width: 12.w),
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
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    ThemeData theme, {
    required String label,
    required String icon,
    required String url,
    required VoidCallback onPressed,
  }) {
    return M3EButton.icon(
      onPressed: onPressed,
      size: M3EButtonSize.custom(height: 75.r),
      shape: M3EButtonShape.square,
      icon: SvgPicture.asset(
        icon,
        width: 22.w,
        height: 22.h,
        colorFilter: ColorFilter.mode(
          theme.colorScheme.onPrimary,
          BlendMode.srcIn,
        ),
      ),
      label: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
      decoration: M3EButtonDecoration.styleFrom(
        hoveredRadius: 12,
        pressedRadius: 8,
        borderRadius: 18,
      ),
    );
  }
}
