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
    this.curve = Curves.easeOut,
    this.autoRebuild = false,
  });

  @override
  State<ScrollAnimatedFadeIn> createState() => _ScrollAnimatedFadeInState();
}

class _ScrollAnimatedFadeInState extends State<ScrollAnimatedFadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Key _visibilityKey;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _visibilityKey = widget.key ?? UniqueKey();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (info) {
        if (!_isVisible && info.visibleFraction > 0.1) {
          _isVisible = true;
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
      },
      child: widget.child
          .animate(autoPlay: false, controller: _controller)
          .fadeIn(delay: widget.delay, duration: widget.duration)
          .slideY(begin: widget.slideOffset, end: 0, curve: widget.curve),
    );
  }
}
