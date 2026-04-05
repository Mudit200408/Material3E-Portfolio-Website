import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

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
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return M3EButton(
      tooltip: widget.tooltip,

      size: M3EButtonSize.custom(height: 56.r, width: 56.r, hPadding: 16.r),
      decoration: const M3EButtonDecoration(
        motion: M3EMotion.standardEffectsSlow,
        pressedRadius: 8,
        hoveredRadius: 14,
      ),

      onPressed: widget.onPressed,
      child: SvgPicture.asset(
        widget.iconPath,
        width: 56.r,
        height: 56.r,
        colorFilter: ColorFilter.mode(
          theme.colorScheme.onPrimary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
