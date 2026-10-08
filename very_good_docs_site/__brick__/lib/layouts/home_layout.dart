import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';
import 'package:{{project_name.snakeCase()}}/layouts/site_chrome.dart';
import 'package:{{project_name.snakeCase()}}/src/colors.dart';

typedef _Pillar = ({String title, String image, String description});

/// A landing page layout: a hero banner (title, tagline, call to action, and
/// a color-mode-aware image) followed by a row of feature pillars.
///
/// Selected by a page with `layout: home` in its frontmatter. The title and
/// tagline come from `content/_data/site.yaml`. The hero images and pillars
/// come from the page's own frontmatter:
///
/// ```yaml
/// hero:
///   image: /images/hero.svg
///   darkImage: /images/hero_dark.svg
/// pillars:
///   - title: Pillar 1
///     image: /images/pillar1.svg
///     description: What makes the project worth using.
/// ```
class HomeLayout extends PageLayoutBase with SiteChrome {
  /// Creates a landing page layout.
  const HomeLayout({this.header, this.siteFooter, this.cta});

  /// The header component to render, usually a `SiteHeader`.
  final Component? header;

  @override
  final Component? siteFooter;

  /// The hero call-to-action link, usually pointing at the docs entry page.
  final ({String label, String href})? cta;

  @override
  String get name => 'home';

  @override
  Component buildBody(Page page, Component child) {
    final siteData = page.data.site;
    final title = siteData['titleBase'] as String? ?? '';
    final tagline = siteData['tagline'] as String? ?? '';
    final pageData = page.data.page;
    final heroImages = switch (pageData['hero']) {
      {'image': final String light, 'darkImage': final String dark} => (
        light: light,
        dark: dark,
      ),
      _ => null,
    };
    final pillars = switch (pageData['pillars']) {
      final List<Object?> items => [
        for (final item in items)
          if (item case {
            'title': final String title,
            'image': final String image,
            'description': final String description,
          })
            (title: title, image: image, description: description),
      ],
      _ => const <_Pillar>[],
    };

    return buildShell(
      div(classes: 'home', [
        if (header case final header?)
          div(classes: 'header-container', [header]),
        main_([
          section(classes: 'hero', [
            h1([.text(title)]),
            p(classes: 'hero-tagline', [.text(tagline)]),
            if (cta case final cta?)
              a(classes: 'hero-cta', href: cta.href, [.text(cta.label)]),
            if (heroImages case (:final light, :final dark)) ...[
              img(
                classes: 'hero-image hero-image-light',
                src: light,
                alt: 'Hero',
                width: 720,
              ),
              img(
                classes: 'hero-image hero-image-dark',
                src: dark,
                alt: 'Hero',
                width: 720,
              ),
            ],
          ]),
          if (pillars.isNotEmpty)
            section(classes: 'features', [
              for (final pillar in pillars)
                div(classes: 'feature', [
                  img(src: pillar.image, alt: pillar.title, width: 200),
                  h3([.text(pillar.title)]),
                  p([.text(pillar.description)]),
                ]),
            ]),
          child,
        ]),
      ]),
    );
  }

  /// The styles for this layout, bundled into the site stylesheet.
  @css
  static List<StyleRule> get styles => [
    css('.home', [
      css('.header-container').styles(
        position: const .sticky(top: .zero),
        zIndex: const ZIndex(10),
        raw: {'backdrop-filter': 'blur(8px)'},
      ),
      css('.hero', [
        css('&').styles(
          display: .flex,
          padding: .symmetric(vertical: 4.rem, horizontal: 1.rem),
          flexDirection: .column,
          alignItems: .center,
          textAlign: .center,
        ),
        css('h1').styles(
          margin: .only(bottom: 1.5.rem),
          fontSize: 3.rem,
        ),
        css('.hero-tagline').styles(
          margin: .only(bottom: 2.rem),
          fontSize: 1.5.rem,
        ),
        css('.hero-cta').styles(
          display: .inlineBlock,
          padding: .symmetric(vertical: .75.rem, horizontal: 2.rem),
          radius: .circular(.5.rem),
          color: AppColors.heroCtaText,
          fontWeight: .w700,
          textDecoration: .none,
          backgroundColor: ContentColors.primary,
        ),
        css('.hero-image').styles(
          maxWidth: 100.percent,
          margin: .only(top: 3.rem),
        ),
        css('.hero-image-dark').styles(display: .none),
      ]),
      css('.features', [
        css('&').styles(
          display: .flex,
          maxWidth: 72.rem,
          padding: .symmetric(vertical: 2.rem, horizontal: 1.rem),
          margin: const .symmetric(horizontal: .auto),
          flexWrap: .wrap,
          justifyContent: .center,
          gap: .all(2.rem),
        ),
        css('.feature', [
          css('&').styles(
            maxWidth: 20.rem,
            flex: Flex(grow: 1, shrink: 1, basis: 16.rem),
            textAlign: .center,
          ),
          css('img').styles(
            display: .block,
            margin: const .symmetric(horizontal: .auto),
          ),
        ]),
      ]),
    ]),
    css('html[data-theme="dark"] .home', [
      css('.hero-image-light').styles(display: .none),
      css('.hero-image-dark').styles(display: .inline),
    ]),
  ];
}
