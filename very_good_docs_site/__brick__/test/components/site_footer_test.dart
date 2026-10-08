import 'package:jaspr/server.dart';
import 'package:jaspr_test/server_test.dart';
import 'package:{{project_name.snakeCase()}}/components/site_footer.dart';

import '../helpers/helpers.dart';

void main() {
  setUpAll(Jaspr.initializeApp);

  group(SiteFooter, () {
    testServer('renders a titled column of links per column', (tester) async {
      final response = await tester.render(
        const SiteFooter(
          columns: [
            (
              title: 'Docs',
              links: [
                (label: 'Overview', href: '/docs/overview'),
                (label: 'Guides', href: '/docs/guides'),
              ],
            ),
            (
              title: 'More',
              links: [(label: 'GitHub', href: 'https://github.com')],
            ),
          ],
        ),
      );

      final columns = response.document!.querySelectorAll(
        '.site-footer-column',
      );
      expect(columns, hasLength(2));

      final docs = columns.first;
      expect(docs.querySelector('.site-footer-title')!.text, equals('Docs'));
      expect(
        docs.querySelectorAll('a').map((a) => a.attributes['href']),
        equals(['/docs/overview', '/docs/guides']),
      );
      expect(columns.last.querySelector('a')!.text, equals('GitHub'));
    });

    testServer('declares styles for its classes', (tester) async {
      final css = await tester.renderCss(SiteFooter.styles);

      expect(css, contains('.site-footer'));
      expect(css, contains('.site-footer-column'));
    });
  });
}
