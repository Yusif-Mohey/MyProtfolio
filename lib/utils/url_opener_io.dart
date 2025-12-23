import 'package:url_launcher/url_launcher_string.dart';

/// Open a URL on non-web platforms using `url_launcher`.
Future<void> openUrl(String url) async {
  try {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  } catch (_) {}
}
