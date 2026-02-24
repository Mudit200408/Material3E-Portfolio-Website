import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static const List<FontVariation> introFontNormal = [
    FontVariation('wght', 520),
    FontVariation('GRAD', 18),
    FontVariation('ROND', 50),
  ];

  static const List<FontVariation> introFontEmphasized = [
    FontVariation('wght', 750),
    FontVariation('slnt', -5),
    FontVariation('wdth', 70),
    FontVariation('XOPQ', 125),
    FontVariation('XTRA', 468),
    FontVariation('opsz', 28),
  ];

  static String get profileUrl => dotenv.env['PROFILE_URL'] ?? '';
  static String get resumeUrl => dotenv.env['RESUME_URL'] ?? '';
}
