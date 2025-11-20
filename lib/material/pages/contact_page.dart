// lib/material/pages/Contact_section.dart
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Just return the content. NO SCROLLVIEWS HERE.
    return Container(
      // The height is just for the placeholder,
      // your content will define its own height.
      height: 600,
      child: Center(
        child: Text('Contact Section', style: theme.textTheme.headlineLarge),
      ),
    );
  }
}
