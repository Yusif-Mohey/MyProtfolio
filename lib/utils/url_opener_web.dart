import 'dart:html' as html;

/// Open a URL in a new tab/window on the web.
Future<void> openUrl(String url) async {
  try {
    html.window.open(url, '_blank');
  } catch (_) {}
}
