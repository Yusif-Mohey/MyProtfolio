import 'package:url_launcher/url_launcher_string.dart';

/// Open a URL in an external application or browser.
Future<void> openUrl(String url) async {
  try {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  } catch (_) {}
}
