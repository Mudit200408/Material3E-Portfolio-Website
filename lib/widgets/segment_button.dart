import 'package:flutter/material.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

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
    return InkWell(
      splashColor: selectedColor.withValues(alpha: 0.4),
      onTap: onTap,
      customBorder: const StadiumBorder(),
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: isSelected ? selectedColor : Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 8.r),
        child: child,
      ),
    );
  }
}
