import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:responsive_scaler/responsive_scaler.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayoutHelper.isMobile(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.r, horizontal: 48.r),
        color: theme.colorScheme.surfaceContainer.withValues(alpha: 0.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isMobile) ...[
              _buildCopyright(theme),
              SizedBox(height: 4.h),
              _buildLicense(theme),
              SizedBox(height: 16.h),
              _buildMadeWithFlutter(theme),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCopyright(theme),
                      SizedBox(height: 4.h),
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

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
      }
    }
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
        SizedBox(width: 3.w),
        Icon(
          Icons.copyright,
          color: theme.colorScheme.onSurfaceVariant,
          size: 14.r,
        ),

        SizedBox(width: 3.w),
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
    return InkWell(
      onTap: () => _launchUrl(
        'https://github.com/Mudit200408/Material3E-Portfolio-Website',
      ),
      child: Text(
        'Open-sourced under the MIT License',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.primary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMadeWithFlutter(ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
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
          SizedBox(width: 6.w),
          const FlutterLogo(size: 16),
          SizedBox(width: 6.w),
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
