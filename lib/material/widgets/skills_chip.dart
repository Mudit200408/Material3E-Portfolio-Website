import 'package:flutter/material.dart';
import 'package:portfolio_web/models/skills_model.dart';

class SkillsChip extends StatelessWidget {
  const SkillsChip({super.key, required this.skill});

  final SkillsModel skill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      backgroundColor: theme.colorScheme.surfaceContainerLow,
      side: BorderSide(color: theme.colorScheme.primary, width: 0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      label: Text(
        skill.skillName,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}