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

  static const List<FontVariation> headingFont = [
    FontVariation('wght', 875),
    FontVariation('GRAD', -85),
    FontVariation('wdth', 90),
    FontVariation('slnt', 0),
    FontVariation('XOPQ', 125),
    FontVariation('XTRA', 416),
    FontVariation('opsz', 8),
    FontVariation('YOPQ', 32),
    FontVariation('YTAC', 853),
    FontVariation('YTFI', 715),
    FontVariation('YTAS', 100),
    FontVariation('YTLS', 570),
    FontVariation('YTDE', -189),
    FontVariation('YTUC', 760),
  ];

  static const List<FontVariation> experienceFontNormal = [
    FontVariation('wght', 600),
    FontVariation('GRAD', 30),
    FontVariation('ROND', 90),
  ];

  static const List<FontVariation> experienceFontBody = [
    FontVariation('wght', 540),
    FontVariation('GRAD', 30),
    FontVariation('ROND', 65),
  ];
  static const List<FontVariation> experienceFontEmphasized = [
    FontVariation('wght', 800),
    FontVariation('slnt', -4),
    FontVariation('wdth', 85),
    FontVariation('XOPQ', 130),
    FontVariation('XTRA', 480),
    FontVariation('opsz', 30),
  ];

  // About page – segmented button label font
  static const List<FontVariation> segmentedButtonFont = [
    FontVariation('slnt', -8),
    FontVariation('wght', 824),
    FontVariation('wdth', 78),
    FontVariation('GRAD', 15),
    FontVariation('XOPQ', 124),
    FontVariation('XTRA', 500),
    FontVariation('YOPQ', 100),
    FontVariation('YTLC', 750),
    FontVariation('YTAS', 535),
    FontVariation('opsz', 40),
  ];

  // About page – description body text
  static const List<FontVariation> descriptionFont = [
    FontVariation('ROND', 80),
    FontVariation('wght', 600),
  ];

  // Education – institution name (desktop)
  static const List<FontVariation> collegeNameFontDesktop = [
    FontVariation('slnt', 0),
    FontVariation('wdth', 80),
    FontVariation('wght', 700),
    FontVariation('GRAD', -57),
    FontVariation('XOPQ', 50),
    FontVariation('XTRA', 470),
    FontVariation('YOPQ', 79),
    FontVariation('YTAS', 750),
    FontVariation('YTLC', 515),
    FontVariation('opsz', 139),
  ];

  // Education – institution name (mobile)
  static const List<FontVariation> collegeNameFontMobile = [
    FontVariation('slnt', 0),
    FontVariation('wght', 640),
    FontVariation('GRAD', -57),
    FontVariation('XOPQ', 50),
    FontVariation('XTRA', 470),
    FontVariation('YOPQ', 79),
    FontVariation('YTAS', 750),
    FontVariation('YTLC', 515),
  ];

  // Education – degree / branch name
  static const List<FontVariation> branchNameFont = [
    FontVariation('slnt', -5),
    FontVariation('wdth', 50),
    FontVariation('wght', 400),
    FontVariation('GRAD', -80),
    FontVariation('XOPQ', 135),
    FontVariation('XTRA', 500),
    FontVariation('YOPQ', 100),
    FontVariation('YTAS', 730),
    FontVariation('YTLC', 480),
    FontVariation('opsz', 23),
  ];

  // Education – date
  static const List<FontVariation> dateFont = [
    FontVariation('slnt', -2),
    FontVariation('wdth', 55),
    FontVariation('wght', 720),
    FontVariation('opsz', 23),
  ];
  static String get profileUrl => dotenv.env['PROFILE_URL'] ?? '';
  static String get resumeUrl => dotenv.env['RESUME_URL'] ?? '';

  // Contact / PII (read from .env, not hardcoded)
  static String get web3FormsKey => dotenv.env['WEB3FORMS_KEY'] ?? '';
  static String get email => dotenv.env['EMAIL'] ?? '';
  static String get phoneUrl => dotenv.env['PHONE_URL'] ?? '';
  static String get telegramUrl => dotenv.env['TELEGRAM_URL'] ?? '';
  static String get githubUrl => dotenv.env['GITHUB_URL'] ?? '';
  static String get linkedinUrl => dotenv.env['LINKEDIN_URL'] ?? '';
  static String get whatsappUrl => dotenv.env['WHATSAPP_URL'] ?? '';
}
