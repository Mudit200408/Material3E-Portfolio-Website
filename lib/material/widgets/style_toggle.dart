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
        color: theme.colorScheme.primary.withOpacity(0.15), // Outer pill color
        borderRadius: BorderRadius.circular(120),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SegmentButton(
            label: "Material",
            isSelected: isMaterial,
            selectedColor: theme.colorScheme.primary, // warm coral tone
            onTap: () => onChanged(AppStyle.material),
          ),
          _SegmentButton(
            label: "Cupertino",
            isSelected: !isMaterial,
            selectedColor: theme.colorScheme.secondary, // deep purple tone
            onTap: () => onChanged(AppStyle.cupertino),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: AnimatedContainer(
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
        child: Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
