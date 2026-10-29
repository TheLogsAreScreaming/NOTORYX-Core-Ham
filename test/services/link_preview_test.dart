import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:meshcore_open/services/link_preview.dart';

void main() {
  test('finds the first link and trims trailing punctuation', () {
    expect(
      firstLink(
        'See https://cascadiamesh.org/regions/, then reply.',
      ).toString(),
      'https://cascadiamesh.org/regions/',
    );
    expect(firstLink('no link here'), isNull);
    expect(firstLink('ftp://example.com'), isNull);
  });

  test('reads Open Graph tags, falling back to the title tag', () {
    final url = Uri.parse('https://meshcore.io/');
    final og = parseLinkPreview(
      '<meta property="og:title" content="MeshCore &amp; you">'
      '<meta content="Off-grid messaging" name="description">'
      '<meta property="og:site_name" content="MeshCore">',
      url,
    )!;
    expect(og.title, 'MeshCore & you');
    expect(og.description, 'Off-grid messaging');
    expect(og.site, 'MeshCore');
    final plain = parseLinkPreview('<title>  Plain page </title>', url)!;
    expect(plain.title, 'Plain page');
    expect(plain.site, 'meshcore.io');
    expect(parseLinkPreview('<p>nothing</p>', url), isNull);
  });

  test('fetches each link once and skips non-HTML', () async {
    var calls = 0;
    final fetcher = LinkPreviewFetcher(
      client: () => MockClient((req) async {
        calls++;
        return req.url.path.endsWith('.png')
            ? http.Response('x', 200, headers: {'content-type': 'image/png'})
            : http.Response(
                '<title>Hello</title>',
                200,
                headers: {'content-type': 'text/html; charset=utf-8'},
              );
      }),
    );
    final page = Uri.parse('https://example.com/');
    expect((await fetcher.preview(page))!.title, 'Hello');
    await fetcher.preview(page);
    expect(calls, 1);
    expect(
      await fetcher.preview(Uri.parse('https://example.com/a.png')),
      isNull,
    );
  });
}
