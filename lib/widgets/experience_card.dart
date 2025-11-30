import 'package:flutter/material.dart';
import 'package:flutter_m3shapes/flutter_m3shapes.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:portfolio_web/models/experience_model.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;
  final bool isLeft;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayoutHelper.isMobile(context);

    if (isMobile) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline Line on the left
            _buildTimelineLine(theme),

            // Content on the right
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12.scale(), bottom: 32.scale()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateAndTitle(context, theme, false),
                    SizedBox(height: 16.scale()),
                    _buildCard(context, theme, isMobile: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side (Date/Title or Card)
          Expanded(
            child: isLeft
                ? _buildDateAndTitle(context, theme, true)
                : _buildCard(context, theme),
          ),

          // Center Line
          _buildTimelineLine(theme),

          // Right Side (Card or Date/Title)
          Expanded(
            child: isLeft
                ? _buildCard(context, theme)
                : _buildDateAndTitle(context, theme, false),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineLine(ThemeData theme) {
    return Container(
      width: 2,
      color: theme.colorScheme.primary.withValues(alpha: 0.5),
      margin: EdgeInsets.symmetric(horizontal: 16.scale()),
    );
  }

  Widget _buildDateAndTitle(
    BuildContext context,
    ThemeData theme,
    bool alignRight,
  ) {
    return Column(
      crossAxisAlignment: alignRight
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '${experience.startDate} - ${experience.endDate ?? "Present"}',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.tertiary,
            fontVariations: const [
              FontVariation('wght', 600),
              FontVariation('ROND', 80),
            ],
          ),
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
        ),
        SizedBox(height: 4.scale()),
        Text(
          experience.jobTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
        ),
        Text(
          experience.companyName,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
        ),
        SizedBox(height: 4.scale()),
        if (experience.location.isNotEmpty)
          Text(
            experience.location,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontVariations: const [
                FontVariation('wght', 740),
                FontVariation('ROND', 80),
              ],
            ),
            textAlign: alignRight ? TextAlign.right : TextAlign.left,
          ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context,
    ThemeData theme, {
    bool isMobile = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 0 : 42.scale()),
      padding: EdgeInsets.all(24.scale()),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Responsibilities & Achievements',
            style: theme.textTheme.titleLarge?.copyWith(
              fontVariations: const [FontVariation('wght', 680)],
            ),
          ),
          SizedBox(height: 16.scale()),
          ...experience.responsibilities.take(4).toList().asMap().entries.map((
            entry,
          ) {
            final index = entry.key;
            final resp = entry.value;

            // Cycle through shapes
            final shapes = [
              Shapes.c7_sided_cookie,
              Shapes.square,
              Shapes.arch,
              Shapes.pill,
              Shapes.c7_sided_cookie,
            ];
            final shape = shapes[index % shapes.length];

            final colors = [
              theme.colorScheme.primary,
              theme.colorScheme.tertiary,
            ];
            final shapeColor = colors[index % colors.length];

            return Padding(
              padding: EdgeInsets.only(bottom: 12.scale()),
              child: Row(
                children: [
                  M3Container(
                    shape,
                    width: 16.scale(),
                    height: 16.scale(),
                    color: shapeColor,
                    child: const SizedBox(),
                  ),
                  SizedBox(width: 12.scale()),
                  Expanded(
                    child: Text(resp, style: theme.textTheme.titleMedium),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
