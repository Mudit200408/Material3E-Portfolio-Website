import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:portfolio_web/models/nav_section_enums.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class AnimatedBackgroundShapes extends StatefulWidget {
  final ScrollController scrollController;
  final NavSection currentSection;

  const AnimatedBackgroundShapes({
    super.key,
    required this.scrollController,
    required this.currentSection,
  });

  @override
  State<AnimatedBackgroundShapes> createState() =>
      _AnimatedBackgroundShapesState();
}

class _AnimatedBackgroundShapesState extends State<AnimatedBackgroundShapes> {
  // Deterministic configuration for each section
  static final Map<NavSection, List<_ShapeData>> _sectionShapes = {
    // Home Section
    NavSection.home: [
      _ShapeData(
        top: -0.1,
        left: -0.1,
        size: 450.r,
        rotation: 0.5,
        shape: Shapes.c6_sided_cookie,
        parallaxSpeed: 0.05,
        colorType: _ColorType.primary,
      ),
      _ShapeData(
        top: 0.8,
        left: 0.1,
        size: 400.r,
        rotation: 3.5,
        shape: Shapes.c9_sided_cookie,
        parallaxSpeed: 0.08,
        colorType: _ColorType.secondary,
      ),
      _ShapeData(
        top: 0.45,
        left: -0.05,
        size: 300.r,
        rotation: 4.0,
        shape: Shapes.square,
        parallaxSpeed: 0.03,
        colorType: _ColorType.tertiary,
      ),
      _ShapeData(
        top: -0.1,
        left: 0.7,
        size: 350.r,
        rotation: 1.0,
        shape: Shapes.pill,
        parallaxSpeed: 0.06,
        colorType: _ColorType.tertiary,
      ),
      _ShapeData(
        top: 0.7,
        left: 0.8,
        size: 500.r,
        rotation: 2.0,
        shape: Shapes.c7_sided_cookie,
        parallaxSpeed: 0.04,
        colorType: _ColorType.primary,
      ),
      _ShapeData(
        top: 0.2,
        left: 0.9,
        size: 320.r,
        rotation: 5.5,
        shape: Shapes.l4_leaf_clover,
        parallaxSpeed: 0.07,
        colorType: _ColorType.secondary,
      ),
    ],

    // About Section
    NavSection.about: [
      _ShapeData(
        top: -0.1,
        left: 0.8,
        size: 480.r,
        rotation: 1.5,
        shape: Shapes.c6_sided_cookie,
        parallaxSpeed: 0.05,
        colorType: _ColorType.primary,
      ),
      _ShapeData(
        top: 0.9,
        left: 0.5,
        size: 420.r,
        rotation: 4.5,
        shape: Shapes.c9_sided_cookie,
        parallaxSpeed: 0.08,
        colorType: _ColorType.secondary,
      ),
      _ShapeData(
        top: -0.1,
        left: 0.2,
        size: 350.r,
        rotation: 5.0,
        shape: Shapes.square,
        parallaxSpeed: 0.03,
        colorType: _ColorType.tertiary,
      ),
      _ShapeData(
        top: 0.6,
        left: 0.9,
        size: 380.r,
        rotation: 2.0,
        shape: Shapes.pill,
        parallaxSpeed: 0.06,
        colorType: _ColorType.tertiary,
      ),
      _ShapeData(
        top: 0.8,
        left: -0.1,
        size: 520.r,
        rotation: 3.0,

        shape: Shapes.c7_sided_cookie,
        parallaxSpeed: 0.04,
        colorType: _ColorType.primary,
      ),
      _ShapeData(
        top: 0.3,
        left: -0.1,
        size: 340.r,
        rotation: 0.5,
        shape: Shapes.l4_leaf_clover,
        parallaxSpeed: 0.07,
        colorType: _ColorType.secondary,
      ),
    ],

    // Projects Section
    NavSection.projects: [
      _ShapeData(
        top: -0.15,
        left: 0.5,
        size: 500.r,
        rotation: 2.5,
        shape: Shapes.c6_sided_cookie,
        parallaxSpeed: 0.05,
        colorType: _ColorType.primary,
      ),
      _ShapeData(
        top: 0.85,
        left: -0.1,
        size: 450.r,
        rotation: 4.0,
        shape: Shapes.c9_sided_cookie,
        parallaxSpeed: 0.08,
        colorType: _ColorType.secondary,
      ),
      _ShapeData(
        top: 0.2,
        left: -0.1,
        size: 320.r,
        rotation: 6.0,
        shape: Shapes.square,
        parallaxSpeed: 0.03,
        colorType: _ColorType.tertiary,
      ),
      _ShapeData(
        top: 0.05,
        left: 0.12,
        size: 360.r,
        rotation: 0.5,
        shape: Shapes.pill,
        parallaxSpeed: 0.06,
        colorType: _ColorType.tertiary,
      ),
      _ShapeData(
        top: 0.9,
        left: 0.8,
        size: 400.r,
        rotation: 3.5,
        shape: Shapes.c7_sided_cookie,
        parallaxSpeed: 0.04,
        colorType: _ColorType.primary,
      ),
      _ShapeData(
        top: 0.1,
        left: 0.9,
        size: 300.r,
        rotation: 5.5,
        shape: Shapes.l4_leaf_clover,
        parallaxSpeed: 0.07,
        colorType: _ColorType.secondary,
      ),
    ],

    // Experience Section
    NavSection.experience: [
      _ShapeData(
        top: 0.2,
        left: -0.15,
        size: 460.r,
        rotation: 3.5,
        shape: Shapes.c6_sided_cookie,
        parallaxSpeed: 0.05,
        colorType: _ColorType.primary,
      ),
      _ShapeData(
        top: 0.6,
        left: 0.9,
        size: 480.r,
        rotation: 1.0,
        shape: Shapes.c9_sided_cookie,
        parallaxSpeed: 0.08,
        colorType: _ColorType.secondary,
      ),
      _ShapeData(
        top: -0.1,
        left: 0.6,
        size: 340.r,
        rotation: 5.0,
        shape: Shapes.square,
        parallaxSpeed: 0.03,
        colorType: _ColorType.tertiary,
      ),
      _ShapeData(
        top: 0.9,
        left: 0.1,
        size: 370.r,
        rotation: 2.0,
        shape: Shapes.pill,
        parallaxSpeed: 0.06,
        colorType: _ColorType.tertiary,
      ),
      _ShapeData(
        top: -0.1,
        left: 0.15,
        size: 410.r,
        rotation: 4.5,
        shape: Shapes.c7_sided_cookie,
        parallaxSpeed: 0.04,
        colorType: _ColorType.primary,
      ),
      _ShapeData(
        top: 0.93,
        left: 0.6,
        size: 330.r,
        rotation: 0.5,
        shape: Shapes.l4_leaf_clover,
        parallaxSpeed: 0.07,
        colorType: _ColorType.secondary,
      ),
    ],

    // Contact Section
    NavSection.contact: [
      _ShapeData(
        top: 0.8,
        left: 0.8,
        size: 550.r,
        rotation: 4.5,
        shape: Shapes.c6_sided_cookie,
        parallaxSpeed: 0.05,
        colorType: _ColorType.primary,
      ),
      _ShapeData(
        top: 0.0,
        left: 0.0,
        size: 550.r,
        rotation: 2.0,
        shape: Shapes.c9_sided_cookie,
        parallaxSpeed: 0.08,
        colorType: _ColorType.primary,
      ),
      _ShapeData(
        top: 0.8,
        left: 0.1,
        size: 300.r,
        rotation: 6.0,
        shape: Shapes.square,
        parallaxSpeed: 0.03,
        colorType: _ColorType.tertiary,
      ),
      _ShapeData(
        top: 0.2,
        left: 0.8,
        size: 350.r,
        rotation: 0.3,
        shape: Shapes.pill,
        parallaxSpeed: 0.06,
        colorType: _ColorType.tertiary,
      ),
      _ShapeData(
        top: 0.85,
        left: 0.4,
        size: 400.r,
        rotation: 3.5,
        shape: Shapes.c7_sided_cookie,
        parallaxSpeed: 0.04,
        colorType: _ColorType.primary,
      ),
      _ShapeData(
        top: 0.1,
        left: 0.4,
        size: 320.r,
        rotation: 5.5,
        shape: Shapes.l4_leaf_clover,
        parallaxSpeed: 0.07,
        colorType: _ColorType.secondary,
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedBackgroundShapes oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile = ResponsiveLayoutHelper.isMobile(context);

    final allShapes =
        _sectionShapes[widget.currentSection] ??
        _sectionShapes[NavSection.home]!;

    // On mobile, show fewer shapes (first 3) to reduce clutter
    final shapes = isMobile ? allShapes.take(4).toList() : allShapes;

    return AnimatedBuilder(
      animation: widget.scrollController,
      builder: (context, child) {
        final scrollOffset = widget.scrollController.hasClients
            ? widget.scrollController.offset
            : 0.0;

        return Stack(
          children: shapes.map((data) {
            // Calculate parallax offset
            final parallaxOffset = scrollOffset * data.parallaxSpeed;

            // Resolve color
            Color color;
            switch (data.colorType) {
              case _ColorType.primary:
                color = theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.7,
                );
                break;
              case _ColorType.secondary:
                color = theme.colorScheme.secondaryContainer.withValues(
                  alpha: 0.8,
                );
                break;
              case _ColorType.tertiary:
                color = theme.colorScheme.tertiaryContainer.withValues(
                  alpha: 0.7,
                );
                break;
            }

            // Reduce size on mobile
            final shapeSize = isMobile ? data.size * 0.6 : data.size;

            return AnimatedPositioned(
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeInOutCubic,
              top: (data.top * size.height) - parallaxOffset,
              left: data.left * size.width,
              child: RepaintBoundary(
                child: Transform.rotate(
                  angle:
                      data.rotation +
                      (scrollOffset * 0.0005), // Slower rotation
                  child: M3EContainer(
                    data.shape,
                    width: shapeSize,
                    height: shapeSize,
                    color: color,
                    child: const SizedBox(),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

enum _ColorType { primary, secondary, tertiary }

class _ShapeData {
  final double top;
  final double left;
  final double size;
  final double rotation;
  final Shapes shape;
  final double parallaxSpeed;
  final _ColorType colorType;

  _ShapeData({
    required this.top,
    required this.left,
    required this.size,
    required this.rotation,
    required this.shape,
    required this.parallaxSpeed,
    required this.colorType,
  });
}
