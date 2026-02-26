import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_scaler/responsive_scaler.dart';
import 'package:motor/motor.dart';

class SocialButton extends StatefulWidget {
  final String iconPath;
  final VoidCallback onPressed;
  final String tooltip;

  const SocialButton({
    super.key,
    required this.iconPath,
    required this.onPressed,
    required this.tooltip,
  });

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Morph to circle (28.r) on hover (desktop) or press (mobile)
    final double radius = (_isHovered || _isPressed) ? 28.r : 16.r;
    return Tooltip(
      message: widget.tooltip,
      child: InkWell(
        onTap: widget.onPressed,
        onHover: (hovering) => setState(() => _isHovered = hovering),
        onHighlightChanged: (highlighted) =>
            setState(() => _isPressed = highlighted),
        // Remove default splash to keep the morphing clean
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        child: SingleMotionBuilder(
          motion: const MaterialSpringMotion.expressiveSpatialFast().copyWith(
            stiffness: 500,
            damping: 0.5,
          ),
          value: radius,
          builder: (context, currentRadius, child) {
            return Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(currentRadius),
              ),
              child: child,
            );
          },
          child: SvgPicture.asset(
            widget.iconPath,
            width: 24.r,
            height: 24.r,
            colorFilter: ColorFilter.mode(
              theme.colorScheme.onPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
