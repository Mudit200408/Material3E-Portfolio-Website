// lib/material/pages/about_section.dart
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Just return the content. NO SCROLLVIEWS HERE.
    return Container(
      // The height is just for the placeholder,
      // your content will define its own height.
      height: 600, 
      color: theme.colorScheme.surfaceVariant,
      child: Center(
        child: Text('About Section', style: theme.textTheme.headlineLarge),
      ),
    );
  }
}