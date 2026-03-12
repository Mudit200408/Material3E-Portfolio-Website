import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:motor/motor.dart';

class AnimatedShapeContainer extends StatefulWidget {
  final Widget? child;
  final Color? color;
  final double width;
  final double height;
  final Gradient? gradient;
  final BorderSide border;
  final List<BoxShadow>? boxShadow;

  const AnimatedShapeContainer({
    super.key,
    this.child,
    this.color,
    this.gradient,
    required this.width,
    required this.height,
    this.border = BorderSide.none,
    this.boxShadow,
  });

  @override
  State<AnimatedShapeContainer> createState() => _AnimatedShapeContainerState();
}

class _AnimatedShapeContainerState extends State<AnimatedShapeContainer> {
  int _currentShapeIndex = 0;
  double _scale = 1.0;
  double _bounceScale = 1.0;

  final List<Shapes> _shapes = [
    Shapes.c6_sided_cookie,
    Shapes.arch,
    Shapes.square,
    Shapes.c7_sided_cookie,
    Shapes.pill,
    Shapes.c9_sided_cookie,
    Shapes.slanted,
    Shapes.l4_leaf_clover,
  ];

  void _onTap() {
    // Add Haptics
    HapticFeedback.lightImpact();

    // Trigger bounce before changing shape for smooth transition
    setState(() {
      _bounceScale = 1.2; // Scale up first
    });

    // Change shape while scaling up
    Future.delayed(const Duration(milliseconds: 180), () {
      if (mounted) {
        setState(() {
          _currentShapeIndex = (_currentShapeIndex + 1) % _shapes.length;
          _bounceScale = 1.0; // Spring back to normal
        });
      }
    });
  }

  void _onHover(bool isHovered) {
    setState(() {
      _scale = isHovered ? 1.05 : 1.0;
    });
  }

  Widget _buildShapeContainer() {
    final shape = _shapes[_currentShapeIndex];

    return M3EContainer(
      shape,
      key: ValueKey(_currentShapeIndex),
      color: widget.color,
      width: widget.width,
      height: widget.height,
      gradient: widget.gradient,
      border: widget.border,
      boxShadow: widget.boxShadow,
      child: widget.child ?? const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _onTap,
          // Combine both scale and bounceScale into a single motion value to
          // prevent running two independent tickers simultaneously.
          child: SingleMotionBuilder(
            motion: const MaterialSpringMotion.expressiveSpatialFast().copyWith(
              stiffness: 800,
              damping: 0.5,
            ),
            value: _scale * _bounceScale,
            builder: (context, combinedScale, child) {
              return Transform.scale(
                scale: combinedScale,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.8,
                          end: 1.0,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: AvatarGlow(
                    startDelay: const Duration(milliseconds: 300),
                    glowCount: 3,
                    glowRadiusFactor: 0.25,
                    glowColor: widget.color ?? Colors.blue,
                    glowShape: BoxShape.circle,
                    curve: Curves.fastEaseInToSlowEaseOut,
                    child: _buildShapeContainer(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
