import 'package:flutter/material.dart';
import 'package:portfolio_web/core/theme/theme_data.dart';
import 'package:portfolio_web/material/pages/home_page.dart';
import 'package:responsive_scaler/responsive_scaler.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        // Wrap with ResponsiveBreakpoints
        child = ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 600, name: MOBILE),
            const Breakpoint(start: 601, end: 1200, name: TABLET),
            const Breakpoint(start: 1201, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
        // Then apply ResponsiveScaler
        return ResponsiveScaler.scale(context: context, child: child);
      },
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const HomePage(),
    );
  }
}
