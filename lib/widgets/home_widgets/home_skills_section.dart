import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_web/core/loader/loader.dart';
import 'package:portfolio_web/models/skills_model.dart';
import 'package:portfolio_web/services/supabase_services.dart';
import 'package:portfolio_web/widgets/animated_skill_chip.dart';
import 'package:portfolio_web/widgets/scroll_animated_fade_in.dart';
import 'package:provider/provider.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class HomeSkillsSection extends StatelessWidget {
  const HomeSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Read SupabaseServices provided at the root
    final supabase = context.read<SupabaseServices>();

    return ScrollAnimatedFadeIn(
      key: const ValueKey('home_skills_marquee'),
      delay: 600.ms,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
        child: FutureBuilder<List<SkillsModel>>(
          future: supabase.getSkills(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            } else if (snapshot.hasError) {
              return const Text('Error loading skills');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const SizedBox.shrink();
            }

            final skills = snapshot.data!;
            return Wrap(
              spacing: 4.r,
              runSpacing: 4.r,
              alignment: WrapAlignment.center,
              children: skills.asMap().entries.map((entry) {
                final index = entry.key;
                final skill = entry.value;
                return AnimatedSkillChip(skill: skill, index: index);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
