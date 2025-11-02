import 'package:flutter/material.dart';
import 'package:m3e_collection/m3e_collection.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        padding: EdgeInsets.all(4.scale()),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryFixed,
          shape: BoxShape.circle,
        ),
        child: ExpressiveLoadingIndicator(
          // Custom color
          color: theme.colorScheme.primary,

          // Custom polygon shapes
          polygons: [
            MaterialShapes.softBurst,
            MaterialShapes.pentagon,
            MaterialShapes.arrow,
            MaterialShapes.pill,
            MaterialShapes.slanted,
            MaterialShapes.cookie6Sided,
            MaterialShapes.cookie7Sided,
            MaterialShapes.cookie9Sided,
            MaterialShapes.cookie12Sided,
          ],

          // Accessibility
          semanticsLabel: 'Loading',
          semanticsValue: 'In progress',
        ),
      ),
    );
  }
}
