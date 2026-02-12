import 'package:flutter/material.dart';
import 'package:portfolio_web/core/loader/loader.dart';
import 'package:portfolio_web/widgets/experience_card.dart';
import 'package:portfolio_web/widgets/scroll_animated_fade_in.dart';
import 'package:portfolio_web/models/experience_model.dart';
import 'package:portfolio_web/services/supabase_services.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final SupabaseServices _supabaseServices = SupabaseServices();
  late Future<List<ExperienceModel>> _experienceFuture;

  @override
  void initState() {
    super.initState();
    _experienceFuture = _supabaseServices.getExperience();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 58.r),
      child: Column(
        children: [
          ScrollAnimatedFadeIn(
            child: Text(
              'Experience',
              style: theme.textTheme.displaySmall?.copyWith(
                fontVariations: const [
                  FontVariation('wght', 800),
                  FontVariation('GRAD', 50),
                  FontVariation('wdth', 50),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.r),
          ScrollAnimatedFadeIn(
            delay: const Duration(milliseconds: 200),
            child: Text(
              'A Timeline of my Professional Journey and Key Contributions',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 58.r),
          FutureBuilder<List<ExperienceModel>>(
            future: _experienceFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Loader());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No experience data found.'));
              }

              final experienceList = snapshot.data!;

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experienceList.length,
                itemBuilder: (context, index) {
                  final experience = experienceList[index];
                  // Alternate left/right for desktop, always left for mobile (handled in widget)
                  final isLeft = index % 2 == 0;

                  return ScrollAnimatedFadeIn(
                    delay: Duration(
                      milliseconds: 100 * (index % 3),
                    ), // Staggered delay
                    child: ExperienceCard(
                      experience: experience,
                      isLeft: isLeft,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
