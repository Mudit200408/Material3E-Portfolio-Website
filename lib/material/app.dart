import 'package:flutter/material.dart';
import 'package:portfolio_web/core/theme/theme_data.dart';
import 'package:portfolio_web/material/pages/home_page.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        // The scale method now reads the global config set in main().
        return ResponsiveScaler.scale(context: context, child: child!);
      },
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const HomePage(),
    );
  }
}
