import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayoutHelper.isMobile(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 24.scale(),
          horizontal: ResponsiveLayoutHelper.getHorizontalPadding(
            context,
          ).horizontal,
        ),
        color: theme.colorScheme.surfaceContainer.withValues(alpha: 0.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isMobile) ...[
              _buildCopyright(theme),
              SizedBox(height: 4.scale()),
              _buildLicense(theme),
              SizedBox(height: 16.scale()),
              _buildMadeWithFlutter(theme),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCopyright(theme),
                      SizedBox(height: 4.scale()),
                      _buildLicense(theme),
                    ],
                  ),
                  _buildMadeWithFlutter(theme),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCopyright(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Copyright',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(width: 3.scale()),
        Icon(
          Icons.copyright,
          color: theme.colorScheme.onSurfaceVariant,
          size: 14.scale(),
        ),

        SizedBox(width: 3.scale()),
        Text(
          '2025 Mudit Purohit',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLicense(ThemeData theme) {
    return Text(
      'Open-sourced under the MIT License',
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMadeWithFlutter(ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.scale(),
        vertical: 6.scale(),
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Made with',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(width: 6.scale()),
          const FlutterLogo(size: 16),
          SizedBox(width: 6.scale()),
          Text(
            'Flutter',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
