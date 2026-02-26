import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,

      // Primary - Deep Purple (#5400CC)
      primary: Color.fromARGB(255, 76, 54, 137),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color.fromARGB(255, 196, 165, 255),
      onPrimaryContainer: Color.fromARGB(255, 43, 9, 97),

      // Secondary - Soft Purple (#A88BFF)
      secondary: Color(0xFFA88BFF),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFE8DDFF),
      onSecondaryContainer: Color(0xFF21005E),

      // Tertiary - Rose/Pink (#D77095)
      tertiary: Color(0xFFD77095),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFFFD9E3),
      onTertiaryContainer: Color(0xFF581934),

      // Error
      error: Color(0xFFD4141B),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),

      // Surface & Background
      surface: Color(0xFFF4F1F8),
      onSurface: Color(0xFF24005B),
      onSurfaceVariant: Color(0xFF513689),

      // Surface Variants for depth
      surfaceDim: Color(0xFFDED8E0),
      surfaceBright: Color(0xFFFDF7FF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF8F2FA),
      surfaceContainer: Color(0xFFF2ECF4),
      surfaceContainerHigh: Color(0xFFECE6EE),
      surfaceContainerHighest: Color(0xFFEADDFF),

      // Outlines & Utilities
      outline: Color(0xFF7A757F),
      outlineVariant: Color(0xFFCAC4CF),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF322F35),
      onInverseSurface: Color(0xFFF5EFF7),
      inversePrimary: Color(0xFFCFBDFE),

      // Fixed Roles (Material 3)
      primaryFixed: Color(0xFFD9CEFF),
      onPrimaryFixed: Color(0xFF201047),
      primaryFixedDim: Color(0xFFCFBDFE),
      onPrimaryFixedVariant: Color(0xFF4D3D75),
      secondaryFixed: Color(0xFFE8DEF8),
      onSecondaryFixed: Color(0xFF1E192B),
      secondaryFixedDim: Color(0xFFCBC2DB),
      onSecondaryFixedVariant: Color(0xFF4A4458),
      tertiaryFixed: Color(0xFFFFD9E3),
      onTertiaryFixed: Color(0xFF31101D),
      tertiaryFixedDim: Color(0xFFEFB8C8),
      onTertiaryFixedVariant: Color(0xFF633B48),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
