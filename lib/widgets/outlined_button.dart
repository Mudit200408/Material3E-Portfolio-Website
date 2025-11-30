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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24.scale(),
            vertical: 18.scale(),
          ),
          decoration: ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(
                color: _isHovered
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.primary,
                width: 1.5,
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
                  color: _isHovered
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.primary,
                ),
              ),
              SizedBox(width: 8.scale()),
              SvgPicture.asset(
                'assets/icons/document.svg',
                colorFilter: ColorFilter.mode(
                  _isHovered
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.primary,
                  BlendMode.srcIn,
                ),
                width: 28.scale(),
                height: 28.scale(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
