import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Shared URL launcher utility — replaces duplicated `_launchUrl` methods
/// across contact_page, project_page, and footer.
class UrlLauncherHelper {
  UrlLauncherHelper._(); // prevent instantiation

  static Future<void> launch(BuildContext context, String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
      }
    }
  }
}
