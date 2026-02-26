import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Animate border width on hover
    final borderWidth = _isHovered ? 2.5 : 1.5;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 18.r),
          decoration: ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(
                color: theme.colorScheme.primary,
                width: borderWidth,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.buttonName,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontVariations: [const FontVariation('wght', 530)],
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(width: 8.w),
              SvgPicture.asset(
                'assets/icons/document.svg',
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.primary,
                  BlendMode.srcIn,
                ),
                width: 28.r,
                height: 28.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
