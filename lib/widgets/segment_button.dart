import 'package:flutter/material.dart';
import 'package:responsive_scaler/responsive_scaler.dart';
import 'package:motor/motor.dart';

class SegmentButton extends StatelessWidget {
  final Widget child;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback onTap;
  final double width;
  final double height;

  const SegmentButton({
    super.key,
    required this.child,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
    this.width = 100,
    this.height = 36,
  });

  @override
  Widget build(BuildContext context) {
    return SingleMotionBuilder(
      motion: const MaterialSpringMotion.expressiveEffectsSlow(),
      value: isSelected ? 1.0 : 0.0,
      builder: (context, value, _) {
        final color = Color.lerp(Colors.transparent, selectedColor, value);

        return Material(
          type: MaterialType.transparency,
          child: Ink(
            width: width,
            height: height,
            decoration: ShapeDecoration(
              shape: const StadiumBorder(),
              color: color,
            ),
            child: InkWell(
              onTap: onTap,
              customBorder: const StadiumBorder(),
              splashColor: selectedColor.withValues(alpha: 0.4),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 8.r),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
