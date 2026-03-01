import 'package:flutter/material.dart';
import 'package:flutter_m3shapes_extended/flutter_m3shapes_extended.dart';
import 'package:m3e_card_list/m3e_card_list.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:portfolio_web/core/utils/app_constants.dart';
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
                padding: EdgeInsets.only(left: 12.r, bottom: 32.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateAndTitle(context, theme, false),
                    SizedBox(height: 16.h),
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
      width: 2.2,
      color: theme.colorScheme.primary,
      margin: EdgeInsets.symmetric(horizontal: 16.r),
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
            fontVariations: AppConstants.experienceFontNormal,
          ),
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
        ),
        SizedBox(height: 4.h),
        Text(
          experience.jobTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontVariations: AppConstants.experienceFontEmphasized,
          ),
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
        ),
        Text(
          experience.companyName,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontVariations: AppConstants.experienceFontNormal,
          ),
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
        ),
        SizedBox(height: 4.h),
        if (experience.location.isNotEmpty)
          Text(
            experience.location,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontVariations: AppConstants.experienceFontNormal,
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
      margin: EdgeInsets.only(bottom: isMobile ? 0 : 42.r),
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(42.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Key Responsibilities & Achievements',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontVariations: AppConstants.experienceFontEmphasized,
            ),
          ),
          SizedBox(height: 16.h),
          M3ECardColumn(
            outerRadius: 32.r,
            itemPadding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 16.r),
            color: theme.colorScheme.primaryFixedDim.withValues(alpha: 0.6),
            children: [
              ...experience.responsibilities
                  .take(4)
                  .toList()
                  .asMap()
                  .entries
                  .map((entry) {
                    final index = entry.key;
                    final resp = entry.value;

                    // Cycle through shapes
                    const shapes = [
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

                    return Row(
                      children: [
                        M3Container(
                          shape,
                          width: 22.r,
                          height: 22.r,
                          color: shapeColor,
                          child: const SizedBox(),
                        ),
                        SizedBox(width: 12.r),
                        Expanded(
                          child: Text(
                            resp,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                              fontVariations: AppConstants.experienceFontBody,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
