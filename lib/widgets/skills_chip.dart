import 'package:flutter/material.dart';
import 'package:portfolio_web/models/skills_model.dart';

class SkillsChip extends StatelessWidget {
  const SkillsChip({super.key, required this.skill});

  final SkillsModel skill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      backgroundColor: theme.colorScheme.primaryContainer.withValues(
        alpha: 0.6,
      ),
      side: BorderSide(color: theme.colorScheme.onPrimaryContainer, width: 0.6),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      label: Text(
        skill.skillName,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
