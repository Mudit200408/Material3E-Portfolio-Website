import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class CustomButton extends StatefulWidget {
  final String buttonName;
  final VoidCallback onPressed;
  const CustomButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayoutHelper.isMobile(context);

    final theme = Theme.of(context);
    return M3EButton.icon(
      onPressed: widget.onPressed,
      size: M3EButtonSize.custom(
        height: 74.r,
        width: isMobile ? double.infinity : null,
      ),
      label: Text(
        widget.buttonName,
        style: theme.textTheme.titleLarge?.copyWith(
          fontVariations: [const FontVariation('wght', 530)],
          color: theme.colorScheme.surface,
        ),
      ),
      icon: Icon(
        Icons.arrow_forward_rounded,
        color: theme.colorScheme.surface,
        size: 28.r,
      ),
      decoration: M3EButtonDecoration.styleFrom(
        backgroundBuilder: (context, states, child) {
          return DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary, theme.colorScheme.tertiary],
              ),
            ),
            child: child,
          );
        },
      ),
    );
  }
}
