import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'package:{{project_name.snakeCase()}}/src/colors.dart';

/// A link entry in a [SiteFooter] column.
typedef FooterLink = ({String label, String href});

/// A titled column of links in a [SiteFooter].
typedef FooterColumn = ({String title, List<FooterLink> links});

/// The site-wide navigation footer, rendering one column per
/// [FooterColumn].
class SiteFooter extends StatelessComponent {
  /// Creates a site-wide footer rendering the given [columns].
  const SiteFooter({required this.columns, super.key});

  /// The footer columns to render.
  final List<FooterColumn> columns;

  @override
  Component build(BuildContext context) {
    return footer(classes: 'site-footer', [
      div(classes: 'site-footer-columns', [
        for (final column in columns)
          div(classes: 'site-footer-column', [
            div(classes: 'site-footer-title', [.text(column.title)]),
            ul([
              for (final link in column.links)
                li([
                  a(href: link.href, [.text(link.label)]),
                ]),
            ]),
          ]),
      ]),
    ]);
  }

  /// The styles for this component, bundled into the site stylesheet.
  @css
  static List<StyleRule> get styles => [
    css('.site-footer', [
      css('&').styles(
        padding: .symmetric(vertical: 2.rem, horizontal: 1.rem),
        margin: .only(top: 4.rem),
        flex: const Flex(shrink: 0),
        backgroundColor: AppColors.footerBackground,
      ),
      css('.site-footer-columns').styles(
        display: .flex,
        maxWidth: 72.rem,
        margin: const .symmetric(horizontal: .auto),
        flexWrap: .wrap,
        gap: .all(2.rem),
      ),
      css('.site-footer-column')
          .styles(flex: Flex(grow: 1, shrink: 1, basis: 12.rem)),
      css('.site-footer-title').styles(
        margin: .only(bottom: 1.rem),
        fontWeight: .w700,
      ),
      css('ul').styles(padding: .zero, margin: .zero, listStyle: .none),
      css('li').styles(margin: .only(bottom: .5.rem)),
      css('a', [
        css('&').styles(textDecoration: .none),
        css('&:hover')
            .styles(textDecoration: const TextDecoration(line: .underline)),
      ]),
    ]),
  ];
}
