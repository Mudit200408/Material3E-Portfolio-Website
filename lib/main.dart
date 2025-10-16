import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portfolio_web/app.dart';
import 'package:portfolio_web/app_controller.dart';
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
    designWidth: 1920,
    // Optional: Set min/max scale factors for UI elements.
    minScale: 0.8,
    maxScale: 1.2,
    // Optional: Clamp the final text size for accessibility to prevent it from getting too large.
    maxAccessibilityScale: 1.8,
  );
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController(),
      builder: (context, child) {
        return const App();
      },
    );
  }
}
