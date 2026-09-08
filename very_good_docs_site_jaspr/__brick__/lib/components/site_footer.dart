import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'package:{{project_name.snakeCase()}}/src/colors.dart';

/// A link entry in a [SiteFooter] column.
typedef FooterLink = ({String label, String href});

/// A titled column of links in a [SiteFooter].
typedef FooterColumn = ({String title, List<FooterLink> links});

/// The site-wide navigation footer, mirroring the Docusaurus template's
/// three-column footer (Docs / Resources / More).
class SiteFooter extends StatelessComponent {
  /// Creates a site-wide footer rendering the given [columns].
  const SiteFooter({required this.columns, super.key});

  /// The footer columns to render.
  final List<FooterColumn> columns;

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      Document.head(children: [Style(styles: _styles)]),
      footer(classes: 'site-footer', [
        div(classes: 'site-footer-columns', [
          for (final column in columns)
            div(classes: 'site-footer-column', [
              div(classes: 'site-footer-title', [Component.text(column.title)]),
              ul([
                for (final link in column.links)
                  li([
                    a(href: link.href, [Component.text(link.label)]),
                  ]),
              ]),
            ]),
        ]),
      ]),
    ]);
  }

  static final List<StyleRule> _styles = [
    css('.site-footer', [
      css('&').styles(
        padding: Padding.symmetric(vertical: 2.rem, horizontal: 1.rem),
        margin: Margin.only(top: 4.rem),
        flex: const Flex(shrink: 0),
        backgroundColor: AppColors.footerBackground,
      ),
      css('.site-footer-columns').styles(
        display: Display.flex,
        maxWidth: 72.rem,
        margin: const Margin.symmetric(horizontal: Unit.auto),
        flexWrap: FlexWrap.wrap,
        gap: Gap.all(2.rem),
      ),
      css('.site-footer-column')
          .styles(flex: Flex(grow: 1, shrink: 1, basis: 12.rem)),
      css('.site-footer-title').styles(
        margin: Margin.only(bottom: 1.rem),
        fontWeight: FontWeight.w700,
      ),
      css('ul').styles(
        padding: Padding.zero,
        margin: Margin.zero,
        listStyle: ListStyle.none,
      ),
      css('li').styles(margin: Margin.only(bottom: .5.rem)),
      css('a', [
        css('&').styles(textDecoration: TextDecoration.none),
        css('&:hover').styles(
          textDecoration: const TextDecoration(
            line: TextDecorationLine.underline,
          ),
        ),
      ]),
    ]),
  ];
}
