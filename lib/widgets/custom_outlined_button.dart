import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class CustomOutlinedButton extends StatefulWidget {
  final String buttonName;
  final VoidCallback onPressed;
  const CustomOutlinedButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayoutHelper.isMobile(context);

    return M3EButton.icon(
      onPressed: widget.onPressed,
      style: M3EButtonStyle.outlined,
      size: M3EButtonSize.custom(
        height: 74.r,
        width: isMobile ? double.infinity : null,
      ),
      label: Text(
        widget.buttonName,
        style: theme.textTheme.titleLarge?.copyWith(
          fontVariations: [const FontVariation('wght', 530)],
          color: theme.colorScheme.primary,
        ),
      ),
      icon: SvgPicture.asset(
        'assets/icons/document.svg',
        colorFilter: ColorFilter.mode(
          theme.colorScheme.primary,
          BlendMode.srcIn,
        ),
        width: 28.r,
        height: 28.r,
      ),
      decoration: M3EButtonDecoration.styleFrom(
        side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
      ),
    );
  }
}
