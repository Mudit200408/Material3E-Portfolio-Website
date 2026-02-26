import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollAnimatedFadeIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideOffset;
  final Curve curve;
  final bool autoRebuild;

  const ScrollAnimatedFadeIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.slideOffset = 0.2,
    this.curve = const Cubic(
      0.34,
      1.56,
      0.64,
      1,
    ), // M3 Expressive spatial spring
    this.autoRebuild = false,
  });

  @override
  State<ScrollAnimatedFadeIn> createState() => _ScrollAnimatedFadeInState();
}

class _ScrollAnimatedFadeInState extends State<ScrollAnimatedFadeIn>
    with SingleTickerProviderStateMixin {
  // A global store to remember which keys have already animated
  static final Set<Key> _alreadyAnimatedKeys = {};

  late final AnimationController _controller;
  late Key _visibilityKey;
  bool _isVisible = false;
  bool _isAlreadyAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _visibilityKey = widget.key ?? UniqueKey();

    if (_alreadyAnimatedKeys.contains(_visibilityKey)) {
      _isVisible = true; // Already animated
      _isAlreadyAnimated = true;
      _controller.value = 1.0; // Instantly finish animation
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedChild = widget.child
        .animate(autoPlay: false, controller: _controller)
        .fadeIn(
          delay: _isAlreadyAnimated ? Duration.zero : widget.delay,
          duration: widget.duration,
          curve: Curves.easeOutCubic, // M3 Expressive effects spring
        )
        .slideY(
          begin: widget.slideOffset,
          end: 0,
          curve: widget.curve, // Spatial spring
          duration: widget.duration,
          delay: _isAlreadyAnimated ? Duration.zero : widget.delay,
        );

    // If already animated, return the child without VisibilityDetector to save performance
    if (_isAlreadyAnimated) {
      return animatedChild;
    }

    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (info) {
        if (!_isVisible && info.visibleFraction > 0.1) {
          _alreadyAnimatedKeys.add(_visibilityKey); // Mark as animated globally
          if (mounted) {
            setState(() {
              _isVisible = true;
            });
            _controller.forward();
            if (widget.autoRebuild) {
              Future.delayed(const Duration(milliseconds: 50), () {
                if (mounted) {
                  setState(() {
                    _visibilityKey = UniqueKey();
                  });
                }
              });
            }
          }
        }
      },
      child: animatedChild,
    );
  }
}
