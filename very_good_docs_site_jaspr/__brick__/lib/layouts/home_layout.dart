/// @docImport 'package:jaspr_content/components/header.dart';
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';
import 'package:{{project_name.snakeCase()}}/layouts/site_chrome.dart';
import 'package:{{project_name.snakeCase()}}/src/colors.dart';

/// A landing page layout mirroring the Docusaurus template's `index.tsx`:
/// hero banner (title, tagline, CTA, color-mode-aware hero image) followed
/// by three feature pillars.
///
/// Selected by a page with `layout: home` in its frontmatter.
class HomeLayout extends PageLayoutBase with SiteChrome {
  /// Creates a landing page layout.
  const HomeLayout({this.header, this.siteFooter, this.cta});

  /// The header component to render, usually a [Header].
  final Component? header;

  @override
  final Component? siteFooter;

  /// The hero call-to-action link, usually pointing at the docs entry page.
  final ({String label, String href})? cta;

  @override
  String get name => 'home';

  @override
  Iterable<Component> buildHead(Page page) sync* {
    yield* super.buildHead(page);
    yield Style(styles: _styles);
  }

  @override
  Component buildBody(Page page, Component child) {
    final siteData = page.data.site;
    final title = siteData['titleBase'] as String? ?? '';
    final tagline = siteData['tagline'] as String? ?? '';

    return buildShell(
      div(classes: 'home', [
        if (header case final header?)
          div(classes: 'header-container', [header]),
        main_([
          section(classes: 'hero', [
            h1([Component.text(title)]),
            p(classes: 'hero-tagline', [Component.text(tagline)]),
            if (cta case final cta?)
              a(classes: 'hero-cta', href: cta.href, [
                Component.text(cta.label),
              ]),
            const img(
              classes: 'hero-image hero-image-light',
              src: '/images/hero.svg',
              alt: 'Hero',
              width: 720,
            ),
            const img(
              classes: 'hero-image hero-image-dark',
              src: '/images/hero_dark.svg',
              alt: 'Hero',
              width: 720,
            ),
          ]),
          section(classes: 'features', [
            for (final pillar in _pillars)
              div(classes: 'feature', [
                img(src: pillar.image, alt: pillar.title, width: 200),
                h3([Component.text(pillar.title)]),
                p([Component.text(pillar.description)]),
              ]),
          ]),
          child,
        ]),
      ]),
    );
  }

  static const List<({String description, String image, String title})>
  _pillars = [
    (
      title: 'Pillar 1',
      image: '/images/pillar1.svg',
      description:
          'Describe the first thing that makes your project worth using. '
          'Edit these pillars in lib/layouts/home_layout.dart.',
    ),
    (
      title: 'Pillar 2',
      image: '/images/pillar2.svg',
      description:
          'Describe the second one. Swap the artwork by replacing the SVG '
          'files under web/images.',
    ),
    (
      title: 'Pillar 3',
      image: '/images/pillar3.svg',
      description:
          'Describe the third one. Add or remove entries from the list and '
          'the layout reflows to fit.',
    ),
  ];

  static final List<StyleRule> _styles = [
    css('.home', [
      css('.header-container').styles(
        position: const Position.sticky(top: Unit.zero),
        zIndex: const ZIndex(10),
        raw: {'backdrop-filter': 'blur(8px)'},
      ),
      css('.hero', [
        css('&').styles(
          display: Display.flex,
          padding: Padding.symmetric(vertical: 4.rem, horizontal: 1.rem),
          flexDirection: FlexDirection.column,
          alignItems: AlignItems.center,
          textAlign: TextAlign.center,
        ),
        // Matches Infima's .hero__title / .hero__subtitle spacing.
        css('h1').styles(
          margin: Margin.only(bottom: 1.5.rem),
          fontSize: 3.rem,
        ),
        css('.hero-tagline').styles(
          margin: Margin.only(bottom: 2.rem),
          fontSize: 1.5.rem,
        ),
        css('.hero-cta').styles(
          display: Display.inlineBlock,
          padding: Padding.symmetric(vertical: .75.rem, horizontal: 2.rem),
          radius: BorderRadius.circular(.5.rem),
          color: AppColors.heroCtaText,
          fontWeight: FontWeight.w700,
          textDecoration: TextDecoration.none,
          backgroundColor: ContentColors.primary,
        ),
        css('.hero-image').styles(
          maxWidth: 100.percent,
          margin: Margin.only(top: 3.rem),
        ),
        css('.hero-image-dark').styles(display: Display.none),
      ]),
      css('.features', [
        css('&').styles(
          display: Display.flex,
          maxWidth: 72.rem,
          padding: Padding.symmetric(vertical: 2.rem, horizontal: 1.rem),
          margin: const Margin.symmetric(horizontal: Unit.auto),
          flexWrap: FlexWrap.wrap,
          justifyContent: JustifyContent.center,
          gap: Gap.all(2.rem),
        ),
        css('.feature', [
          css('&').styles(
            maxWidth: 20.rem,
            flex: Flex(grow: 1, shrink: 1, basis: 16.rem),
            textAlign: TextAlign.center,
          ),
          css('img').styles(
            display: Display.block,
            margin: const Margin.symmetric(horizontal: Unit.auto),
          ),
        ]),
      ]),
    ]),
    css('html[data-theme="dark"] .home', [
      css('.hero-image-light').styles(display: Display.none),
      css('.hero-image-dark').styles(display: Display.inline),
    ]),
  ];
}
