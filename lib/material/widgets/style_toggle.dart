import 'package:flutter/material.dart';
import 'package:portfolio_web/app_controller.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class StyleToggle extends StatelessWidget {
  final AppStyle currentStyle;
  final void Function(AppStyle) onChanged;

  const StyleToggle({
    super.key,
    required this.currentStyle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMaterial = currentStyle == AppStyle.material;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(
          alpha: 0.15,
        ), // Outer pill color
        borderRadius: BorderRadius.circular(120),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SegmentButton(
            isSelected: isMaterial,
            selectedColor: theme.colorScheme.primary, // warm coral tone
            onTap: () => onChanged(AppStyle.material),
            child: Center(
              child: Text(
                "Material",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isMaterial
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SegmentButton(
            isSelected: !isMaterial,
            selectedColor: theme.colorScheme.secondary, // deep purple tone
            onTap: () => onChanged(AppStyle.cupertino),
            child: Center(
              child: Text(
                "Cupertino",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: !isMaterial
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveSpacing.wXSmall,
          vertical: ResponsiveSpacing.hSmall,
        ),
        child: child,
      ),
    );
  }
}
