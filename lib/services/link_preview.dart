import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// What a link preview shows: the site, a title and maybe a description.
class LinkPreview {
  final Uri url;
  final String title;
  final String? description;
  final String site;
  const LinkPreview(this.url, this.title, this.description, this.site);
}

final _urlPattern = RegExp(r'https?://[^\s<>"]+', caseSensitive: false);

/// The first web link in [text], or null.
Uri? firstLink(String text) {
  final m = _urlPattern.firstMatch(text);
  if (m == null) return null;
  final raw = m.group(0)!.replaceAll(RegExp(r'[).,!?;:]+$'), '');
  final uri = Uri.tryParse(raw);
  return uri != null && uri.host.isNotEmpty ? uri : null;
}

String _unescape(String s) => s
    .replaceAll('&amp;', '&')
    .replaceAll('&quot;', '"')
    .replaceAll('&#39;', "'")
    .replaceAll('&#x27;', "'")
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();

String? _meta(String html, String key) {
  for (final pattern in [
    '<meta[^>]+(?:property|name)=["\']$key["\'][^>]*content=["\']([^"\']*)["\']',
    '<meta[^>]+content=["\']([^"\']*)["\'][^>]*(?:property|name)=["\']$key["\']',
  ]) {
    final m = RegExp(pattern, caseSensitive: false).firstMatch(html);
    if (m != null && m.group(1)!.trim().isNotEmpty) {
      return _unescape(m.group(1)!);
    }
  }
  return null;
}

/// Reads Open Graph tags (falling back to `<title>`) from [html]. Null when
/// the page has no usable title.
LinkPreview? parseLinkPreview(String html, Uri url) {
  final title =
      _meta(html, 'og:title') ??
      RegExp(
        r'<title[^>]*>([^<]*)</title>',
        caseSensitive: false,
      ).firstMatch(html)?.group(1);
  if (title == null || _unescape(title).isEmpty) return null;
  final description =
      _meta(html, 'og:description') ?? _meta(html, 'description');
  final site = _meta(html, 'og:site_name') ?? url.host;
  String cut(String s, int n) => s.length <= n ? s : '${s.substring(0, n)}…';
  return LinkPreview(
    url,
    cut(_unescape(title), 120),
    description == null ? null : cut(description, 200),
    site,
  );
}

/// Fetches previews, once per link per app run. Only the first 256 KB of a
/// page is read, there's a 6-second limit, and nothing but the HTML is
/// requested (no images).
class LinkPreviewFetcher {
  LinkPreviewFetcher({http.Client Function()? client})
    : _client = client ?? http.Client.new;

  final http.Client Function() _client;
  final Map<String, Future<LinkPreview?>> _cache = {};

  static const maxBytes = 256 * 1024;

  Future<LinkPreview?> preview(Uri url) =>
      _cache.putIfAbsent(url.toString(), () => _fetch(url));

  Future<LinkPreview?> _fetch(Uri url) async {
    if (url.scheme != 'https' && url.scheme != 'http') return null;
    final client = _client();
    try {
      final req = http.Request('GET', url)
        ..headers['User-Agent'] = 'NOTORYX Core Ham link preview'
        ..headers['Accept'] = 'text/html';
      final res = await client.send(req).timeout(const Duration(seconds: 6));
      final type = res.headers['content-type'] ?? '';
      if (res.statusCode != 200 || !type.contains('html')) return null;
      final bytes = <int>[];
      await for (final chunk in res.stream.timeout(
        const Duration(seconds: 6),
      )) {
        bytes.addAll(chunk);
        if (bytes.length >= maxBytes) break;
      }
      return parseLinkPreview(
        utf8.decode(bytes.take(maxBytes).toList(), allowMalformed: true),
        url,
      );
    } catch (_) {
      return null;
    } finally {
      client.close();
    }
  }
}

/// One fetcher for the app, so a link shown twice is fetched once.
final linkPreviews = LinkPreviewFetcher();
