import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_web/models/skills_model.dart';
import 'package:portfolio_web/widgets/skills_chip.dart';

class AnimatedSkillChip extends StatelessWidget {
  final SkillsModel skill;
  final int index;
  const AnimatedSkillChip({super.key, required this.skill, required this.index});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SkillsChip(skill: skill)
          .animate()
          .fadeIn(delay: (100 * index).ms, duration: 400.ms)
          .scale(curve: Curves.easeOutBack),
    );
  }
}
