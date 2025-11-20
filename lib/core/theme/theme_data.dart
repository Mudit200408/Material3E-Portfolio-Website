import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF6750A4),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFEADDFF),
  onPrimaryContainer: Color(0xFF4F378A),

  secondary: Color(0xFF625B71),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE8DEF8),
  onSecondaryContainer: Color(0xFF4A4459),

  tertiary: Color(0xFF7D5260),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD8E4),
  onTertiaryContainer: Color(0xFF633B48),

  error: Color(0xFFB3261E),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFF9DEDC),
  onErrorContainer: Color(0xFF852221),

  background: Color(0xFFFEF7FF),
  onBackground: Color(0xFF1D1B20),

  surface: Color(0xFFFEF7FF),
  onSurface: Color(0xFF1D1B20),
  surfaceVariant: Color(0xFFE7E0EC),
  onSurfaceVariant: Color(0xFF49454F),

  outline: Color(0xFF79747E),
  outlineVariant: Color(0xFFCAC4D0),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  surfaceTint: Color(0xFF6750A4),

  inverseSurface: Color(0xFF322F35),
  onInverseSurface: Color(0xFFF5EFF7),
  inversePrimary: Color(0xFFD0BCFF),

  // Extended M3 container surfaces
  surfaceDim: Color(0xFFDED8E1),
  surfaceBright: Color(0xFFFEF7FF),
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFF7F2FA),
  surfaceContainer: Color(0xFFF3EDF7),
  surfaceContainerHigh: Color(0xFFECE6F0),
  surfaceContainerHighest: Color(0xFFE6E0E9),

  // Fixed and tonal roles (Material 3 dynamic colors)
  primaryFixed: Color(0xFFEADDFF),
  onPrimaryFixed: Color(0xFF21005D),
  primaryFixedDim: Color(0xFFD0BCFF),
  onPrimaryFixedVariant: Color(0xFF4F378B),

  secondaryFixed: Color(0xFFE8DEF8),
  onSecondaryFixed: Color(0xFF1D192B),
  secondaryFixedDim: Color(0xFFCCC2DC),
  onSecondaryFixedVariant: Color(0xFF4A4458),

  tertiaryFixed: Color(0xFFFFD8E4),
  onTertiaryFixed: Color(0xFF31111D),
  tertiaryFixedDim: Color(0xFFEFB8C8),
  onTertiaryFixedVariant: Color(0xFF633B48),
);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  fontFamily: 'GoogleSansFlex',
);
