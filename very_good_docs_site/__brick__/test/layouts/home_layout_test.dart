import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_test/server_test.dart';
import 'package:{{project_name.snakeCase()}}/layouts/home_layout.dart';

import '../helpers/helpers.dart';

void main() {
  setUpAll(Jaspr.initializeApp);

  group(HomeLayout, () {
    final page = buildPage(
      data: {
        'site': {'titleBase': 'My Site', 'tagline': 'A very good tagline'},
        'page': {
          'hero': {'image': '/hero.svg', 'darkImage': '/hero_dark.svg'},
          'pillars': [
            {'title': 'Fast', 'image': '/fast.svg', 'description': 'Quick.'},
            {'title': 'Safe', 'image': '/safe.svg', 'description': 'Sound.'},
          ],
        },
      },
    );

    const layout = HomeLayout(
      header: header(classes: 'test-header', <Component>[]),
      siteFooter: footer(classes: 'test-footer', <Component>[]),
      cta: (label: 'Get Started', href: '/docs/overview'),
    );

    test('is selected by the home layout name', () {
      expect(layout.name, equals('home'));
    });

    testServer('renders the title and tagline from site data', (tester) async {
      final response = await tester.render(
        layout.buildLayout(page, const .text('')),
        page: page,
      );
      final hero = response.document!.querySelector('.hero')!;

      expect(hero.querySelector('h1')!.text, equals('My Site'));
      expect(
        hero.querySelector('.hero-tagline')!.text,
        equals('A very good tagline'),
      );
    });

    testServer('renders the call to action', (tester) async {
      final response = await tester.render(
        layout.buildLayout(page, const .text('')),
        page: page,
      );
      final cta = response.document!.querySelector('a.hero-cta')!;

      expect(cta.text, equals('Get Started'));
      expect(cta.attributes['href'], equals('/docs/overview'));
    });

    testServer('renders a hero image per color mode', (tester) async {
      final response = await tester.render(
        layout.buildLayout(page, const .text('')),
        page: page,
      );
      final document = response.document!;

      expect(
        document.querySelector('.hero-image-light')!.attributes['src'],
        equals('/hero.svg'),
      );
      expect(
        document.querySelector('.hero-image-dark')!.attributes['src'],
        equals('/hero_dark.svg'),
      );
    });

    testServer('renders a feature per pillar', (tester) async {
      final response = await tester.render(
        layout.buildLayout(page, const .text('')),
        page: page,
      );
      final features = response.document!.querySelectorAll('.feature');

      expect(features.map((f) => f.querySelector('h3')!.text), [
        'Fast',
        'Safe',
      ]);
      expect(
        features.first.querySelector('img')!.attributes['src'],
        equals('/fast.svg'),
      );
      expect(features.first.querySelector('p')!.text, equals('Quick.'));
    });

    testServer('renders the header, page content, and site footer', (
      tester,
    ) async {
      final response = await tester.render(
        layout.buildLayout(page, const .text('Page content')),
        page: page,
      );
      final document = response.document!;

      expect(
        document.querySelector('.header-container .test-header'),
        isNotNull,
      );
      expect(document.querySelector('main')!.text, contains('Page content'));
      expect(document.querySelector('.page-shell > .test-footer'), isNotNull);
    });

    testServer('adds the site chrome to the head', (tester) async {
      final response = await tester.render(
        layout.buildLayout(page, const .text('')),
        page: page,
      );

      expect(
        response.document!.head!.querySelector(
          'script[type="speculationrules"]',
        ),
        isNotNull,
      );
    });

    testServer('skips pillars missing a field', (tester) async {
      final incomplete = buildPage(
        data: {
          'page': {
            'pillars': [
              {'title': 'Fast', 'image': '/fast.svg'},
              {'title': 'Safe', 'image': '/safe.svg', 'description': 'Sound.'},
            ],
          },
        },
      );

      final response = await tester.render(
        const HomeLayout().buildLayout(incomplete, const .text('')),
        page: incomplete,
      );

      expect(
        response.document!.querySelectorAll('.feature h3').map((h) => h.text),
        equals(['Safe']),
      );
    });

    testServer('omits optional sections without their data', (tester) async {
      final empty = buildPage();

      final response = await tester.render(
        const HomeLayout().buildLayout(empty, const .text('')),
        page: empty,
      );
      final document = response.document!;

      expect(document.querySelector('.hero h1')!.text, isEmpty);
      expect(document.querySelector('.hero-tagline')!.text, isEmpty);
      expect(document.querySelector('.header-container'), isNull);
      expect(document.querySelector('.hero-cta'), isNull);
      expect(document.querySelector('.hero-image'), isNull);
      expect(document.querySelector('.features'), isNull);
    });

    testServer('declares styles for its classes', (tester) async {
      final css = await tester.renderCss(HomeLayout.styles);

      expect(css, contains('.home .hero'));
      expect(css, contains('.home .features'));
    });
  });
}
