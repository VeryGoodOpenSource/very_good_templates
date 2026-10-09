import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_test/server_test.dart';
import 'package:{{project_name.snakeCase()}}/components/site_header.dart';

import '../helpers/helpers.dart';

void main() {
  setUpAll(Jaspr.initializeApp);

  group(SiteHeader, () {
    final page = buildPage(
      data: {
        'site': {'titleBase': 'My Site'},
      },
    );

    testServer('renders the logo and the site title from site data', (
      tester,
    ) async {
      final response = await tester.render(
        const SiteHeader(logo: '/images/logo.svg'),
        page: page,
      );

      final brand = response.document!.querySelector('a.header-title')!;
      expect(brand.attributes['href'], equals('/'));
      expect(
        brand.querySelector('img')!.attributes['src'],
        equals('/images/logo.svg'),
      );
      expect(brand.querySelector('span')!.text, equals('My Site'));
    });

    testServer('renders an empty title when site data has none', (
      tester,
    ) async {
      final response = await tester.render(
        const SiteHeader(logo: '/images/logo.svg'),
      );

      expect(
        response.document!.querySelector('a.header-title span')!.text,
        isEmpty,
      );
    });

    testServer('renders left items as nav links', (tester) async {
      final response = await tester.render(
        const SiteHeader(
          logo: '/images/logo.svg',
          leftItems: [(label: 'Overview', href: '/docs/overview')],
        ),
        page: page,
      );

      final link = response.document!.querySelector('.header-nav a')!;
      expect(link.text, equals('Overview'));
      expect(link.attributes['href'], equals('/docs/overview'));
    });

    testServer('omits the nav when there are no left items', (tester) async {
      final response = await tester.render(
        const SiteHeader(logo: '/images/logo.svg'),
        page: page,
      );

      expect(response.document!.querySelector('.header-nav'), isNull);
    });

    testServer('renders right items at the far end', (tester) async {
      final response = await tester.render(
        const SiteHeader(
          logo: '/images/logo.svg',
          rightItems: [span(classes: 'right-item', <Component>[])],
        ),
        page: page,
      );

      expect(
        response.document!.querySelector('.header-items .right-item'),
        isNotNull,
      );
    });

    testServer('renders the sidebar toggle by default', (tester) async {
      final response = await tester.render(
        const SiteHeader(logo: '/images/logo.svg'),
        page: page,
      );

      expect(
        response.document!.querySelector('.sidebar-toggle-button'),
        isNotNull,
      );
    });

    testServer('hides the sidebar toggle when disabled', (tester) async {
      final response = await tester.render(
        const SiteHeader(logo: '/images/logo.svg', showSidebarToggle: false),
        page: page,
      );

      expect(
        response.document!.querySelector('.sidebar-toggle-button'),
        isNull,
      );
    });

    testServer('declares styles for its classes', (tester) async {
      final css = await tester.renderCss(SiteHeader.styles);

      expect(css, contains('.header'));
      expect(css, contains('.header-nav-link'));
    });
  });
}
