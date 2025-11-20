// lib/material/pages/Experience_section.dart
import 'package:flutter/material.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Just return the content. NO SCROLLVIEWS HERE.
    return Container(
      // The height is just for the placeholder,
      // your content will define its own height.
      height: 600,
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Text(
            'Experience Section',
            style: theme.textTheme.displaySmall?.copyWith(
              fontVariations: const [
                FontVariation('wght', 800),
                FontVariation('GRAD', 50),
                FontVariation('wdth', 20),
              ],
            ),
          ),
          SizedBox(height: 4.scale()),
          Text(
            'A Timeline of my Professional Journey and Key Contributions',
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
