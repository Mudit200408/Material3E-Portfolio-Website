import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portfolio_web/core/theme/theme_data.dart';
import 'package:portfolio_web/core/utils/navigation_provider.dart';
import 'package:portfolio_web/pages/home_page.dart';
import 'package:portfolio_web/services/supabase_services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_scaler/responsive_scaler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  ResponsiveScaler.init(
    designWidth: 1680,
    designHeight: 900,
    minScale: 0.8,
    maxScale: 1.6,
  );
  runApp(const AppRoot());
}

// lib/main.dart
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        Provider<SupabaseServices>(create: (_) => SupabaseServices()),
      ],
      child: MaterialApp(
        builder: (context, child) {
          child = ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 600, name: MOBILE),
              const Breakpoint(start: 601, end: 1200, name: TABLET),
              const Breakpoint(start: 1201, end: 1920, name: DESKTOP),
            ],
          );
          return ResponsiveScaler.scale(context: context, child: child);
        },
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        title: 'Mudit Purohit - Portfolio',
        home: const HomePage(),
      ),
    );
  }
}
