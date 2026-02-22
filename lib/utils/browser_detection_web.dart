// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class BrowserDetection {
  static bool get isChrome {
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    final isChrome = userAgent.contains('chrome');
    return isChrome;
  }
}
