import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class ResponsiveLayoutHelper {
  // Breakpoint helpers
  static bool isMobile(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isMobile ||
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isTablet;

  static bool isDesktop(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isDesktop;

  // Get max content width
  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) {
      return double.infinity;
    } else if (isTablet(context)) {
      return 800;
    } else {
      return 1200.scale();
    }
  }

  // Responsive value selector
  static T responsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return desktop;
  }
}
