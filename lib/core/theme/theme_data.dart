import 'package:flutter/material.dart';
import 'package:portfolio_web/core/theme/material_theme.dart';

const _textTheme = TextTheme(
  displayLarge: TextStyle(fontFamily: 'GoogleSansFlex'),
  displayMedium: TextStyle(fontFamily: 'GoogleSansFlex'),
  displaySmall: TextStyle(fontFamily: 'GoogleSansFlex'),
  headlineLarge: TextStyle(fontFamily: 'GoogleSansFlex'),
  headlineMedium: TextStyle(fontFamily: 'GoogleSansFlex'),
  headlineSmall: TextStyle(fontFamily: 'GoogleSansFlex'),
  titleLarge: TextStyle(fontFamily: 'GoogleSansFlex'),
  titleMedium: TextStyle(fontFamily: 'GoogleSansFlex'),
  titleSmall: TextStyle(fontFamily: 'GoogleSansFlex'),
  bodyLarge: TextStyle(fontFamily: 'GoogleSansFlex'),
  bodyMedium: TextStyle(fontFamily: 'GoogleSansFlex'),
  bodySmall: TextStyle(fontFamily: 'GoogleSansFlex'),
  labelLarge: TextStyle(fontFamily: 'GoogleSansFlex'),
  labelMedium: TextStyle(fontFamily: 'GoogleSansFlex'),
  labelSmall: TextStyle(fontFamily: 'GoogleSansFlex'),
);

final MaterialTheme _materialTheme = MaterialTheme(_textTheme);

final ThemeData lightTheme = _materialTheme.light();

// Keeping appTheme for backward compatibility if needed, defaulting to light
final ThemeData appTheme = lightTheme;
