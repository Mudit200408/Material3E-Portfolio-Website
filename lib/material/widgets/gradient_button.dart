import 'package:flutter/material.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class GradientButton extends StatefulWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final Color shadowColor;
  const GradientButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.shadowColor = Colors.transparent,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        borderRadius: BorderRadius.circular(120),
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: 24.scale(),
            vertical: 18.scale(),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? theme.colorScheme.primary.withValues(alpha: 0.6)
                    : Colors.transparent,
                blurRadius: _isHovered ? 4 : 0,
                spreadRadius: _isHovered ? 2 : 0,
                offset: const Offset(0, 4),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primary.withValues(alpha: 0.4),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.buttonName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.scale()),
              Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 28.scale(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}