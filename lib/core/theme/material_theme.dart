import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff68548d),
      surfaceTint: Color(0xff68548d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffebdcff),
      onPrimaryContainer: Color(0xff503c74),
      secondary: Color(0xff635b70),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffeadef8),
      onSecondaryContainer: Color(0xff4b4358),
      tertiary: Color(0xff7f525d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd9e1),
      onTertiaryContainer: Color(0xff643b46),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffef7ff),
      onSurface: Color(0xff1d1b20),
      onSurfaceVariant: Color(0xff49454e),
      outline: Color(0xff7a757f),
      outlineVariant: Color(0xffcbc4cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffd3bbfd),
      primaryFixed: Color(0xffebdcff),
      onPrimaryFixed: Color(0xff230f46),
      primaryFixedDim: Color(0xffd3bbfd),
      onPrimaryFixedVariant: Color(0xff503c74),
      secondaryFixed: Color(0xffeadef8),
      onSecondaryFixed: Color(0xff1f182a),
      secondaryFixedDim: Color(0xffcdc2db),
      onSecondaryFixedVariant: Color(0xff4b4358),
      tertiaryFixed: Color(0xffffd9e1),
      onTertiaryFixed: Color(0xff32101b),
      tertiaryFixedDim: Color(0xfff1b7c5),
      onTertiaryFixedVariant: Color(0xff643b46),
      surfaceDim: Color(0xffded8e0),
      surfaceBright: Color(0xfffef7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8f1fa),
      surfaceContainer: Color(0xfff2ecf4),
      surfaceContainerHigh: Color(0xffede6ee),
      surfaceContainerHighest: Color(0xffe7e0e8),
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
